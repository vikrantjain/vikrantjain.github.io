#!/usr/bin/env bash
# Screenshot a page of the built site (_site/) with headless Chrome.
#
#   scripts/screenshot.sh [-o DIR] [-w "1280 390"] PAGE [SELECTOR]
#
#   PAGE      site path, e.g. /verifiable-credentials-are-ready/
#   SELECTOR  optional CSS selector, e.g. .discuss-cta. The element is brought to
#             the top of the shot by hiding everything above it except the navbar.
#   -o DIR    output directory (default: ${TMPDIR:-/tmp}/blog-screenshots)
#   -w LIST   viewport widths in px (default: "1280 390", desktop and phone)
#
# Run scripts/preview.sh build first. Prints the path of each PNG it writes.
set -euo pipefail

out="${TMPDIR:-/tmp}/blog-screenshots"
widths="1280 390"
while getopts "o:w:" opt; do
  case "$opt" in
    o) out="$OPTARG" ;;
    w) widths="$OPTARG" ;;
    *) exit 2 ;;
  esac
done
shift $((OPTIND - 1))
[ $# -ge 1 ] || { echo "usage: $0 [-o DIR] [-w WIDTHS] PAGE [SELECTOR]" >&2; exit 2; }
page="/${1#/}"; page="${page%/}/"; [ "$page" = "//" ] && page="/"
selector="${2:-}"

cd "$(dirname "$0")/.."
chrome="$(command -v google-chrome chromium chromium-browser 2>/dev/null | head -1)"
[ -n "$chrome" ] || { echo "No Chrome or Chromium found on PATH." >&2; exit 1; }
[ -f "_site${page}index.html" ] || { echo "_site${page}index.html not found. Run scripts/preview.sh build first." >&2; exit 1; }

# A copy of the page next to the original keeps its relative asset URLs working.
shot="_site${page}__screenshot.html"
port=4199
python3 -m http.server "$port" --bind 127.0.0.1 --directory _site >/dev/null 2>&1 &
server=$!
trap 'kill "$server" 2>/dev/null; rm -f "$shot"' EXIT

python3 -I - "_site${page}index.html" "$shot" "$selector" <<'EOF'
import json, sys
src, dst, selector = sys.argv[1:]
html = open(src, encoding="utf-8").read()
if selector:
    js = """<script>addEventListener('DOMContentLoaded', () => {
  const el = document.querySelector(%s);
  if (!el) {
    document.body.insertAdjacentHTML('afterbegin',
      '<div style="position:fixed;inset:0;z-index:9999;background:#c00;color:#fff;font:700 28px sans-serif;padding:40px">SELECTOR NOT FOUND</div>');
    return;
  }
  const keep = e => e.matches('nav, .navbar, script, style, link');
  for (let n = el; n && n !== document.body; n = n.parentElement)
    for (let p = n.previousElementSibling; p; p = p.previousElementSibling)
      if (!keep(p)) p.style.display = 'none';
  const nav = document.querySelector('.navbar');
  document.body.style.paddingTop = ((nav ? nav.offsetHeight : 0) + 24) + 'px';
});</script>""" % json.dumps(selector)
    html = html.replace("</head>", js + "</head>", 1)
open(dst, "w", encoding="utf-8").write(html)
EOF

for _ in $(seq 1 20); do curl -s -o /dev/null "http://127.0.0.1:$port/" && break; sleep 0.2; done

mkdir -p "$out"
name="$(echo "${page}" | tr -c 'a-zA-Z0-9-\n' '-' | sed 's/^-*//; s/-*$//')"; name="${name:-home}"
for w in $widths; do
  h=$(( w < 600 ? 1000 : 800 ))
  png="$out/${name}-${w}.png"
  "$chrome" --headless=new --disable-gpu --hide-scrollbars --virtual-time-budget=3000 \
    --window-size="$w,$h" --screenshot="$png" \
    "http://127.0.0.1:$port${page}__screenshot.html" >/dev/null 2>&1
  echo "$png"
done
