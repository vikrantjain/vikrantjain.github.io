#!/usr/bin/env bash
# Local preview of the site in the ruby:3.3 Docker image (no Ruby on the host).
#
#   scripts/preview.sh serve   # live server at http://localhost:4000 (default)
#   scripts/preview.sh build   # one-shot compile into _site/
#
# Runs as the current user, so _site/ and vendor/bundle never end up root-owned.
set -euo pipefail

mode="${1:-serve}"
case "$mode" in
  serve) jekyll_args="serve --host 0.0.0.0 --livereload" ; ports=(-p 4000:4000 -p 35729:35729) ;;
  build) jekyll_args="build" ; ports=() ;;
  *) echo "usage: $0 [serve|build]" >&2; exit 2 ;;
esac

if ! docker info >/dev/null 2>&1; then
  echo "Docker daemon is not reachable. Start it with: sudo systemctl start docker" >&2
  exit 1
fi

cd "$(dirname "$0")/.."
exec docker run --rm "${ports[@]}" --user "$(id -u):$(id -g)" \
  -v "$PWD":/srv/jekyll -w /srv/jekyll ruby:3.3 \
  bash -c "bundle config set --local path vendor/bundle && bundle install --quiet && \
    bundle exec jekyll $jekyll_args --config _config.yml,_config_local.yml"
