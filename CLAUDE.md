# CLAUDE.md

Guidance for working in this repo. For the file map, publishing workflow, and
local preview, see **README.md** — this file covers the conventions and gotchas
that aren't obvious from the files themselves.

## What this is

Personal blog of Vikrant Jain, published with **Jekyll** on **GitHub Pages**.

- **Repo:** `vikrantjain/vikrantjain.github.io` (root user site)
- **Live URL:** https://vikrantjain.github.io/
- **Theme:** Beautiful Jekyll via `remote_theme: daattali/beautiful-jekyll@6.0.1`. No local theme files; native GitHub Pages build (no Actions, no custom plugins beyond `jekyll-sitemap`/`jekyll-seo-tag`/`jekyll-feed`).
- Articles were migrated from Hashnode (`vikrantjain.hashnode.dev`). Hashnode is no longer the source of truth — this repo is.

## How customization works (don't break these)

All site customization rides on Beautiful Jekyll hooks — there are **no** local theme-layout overrides:

- `_includes/styles.html` (Hashnode-style CSS: Inter font, reading sizing, centered titles, full-width thin `hr`, code/quote/tag styling) and `_includes/mermaid.html` are injected on every page via the `head-extra` default in `_config.yml`. Posts also get `_includes/discuss-cta.html` via the `after-content` default.
- `_config.yml` sets `url: https://vikrantjain.github.io` explicitly so `jekyll-seo-tag`/`jekyll-feed`/`jekyll-sitemap` emit absolute URLs (og:image, RSS, sitemap) instead of relying on GitHub Pages auto-injection. `_config_local.yml` overrides it to `http://localhost:4000` for preview.
- **Remote themes ship `_layouts`/`_includes`/`_sass` only — not root-level pages.** That's why `tags.html` is recreated locally (with an explicit `permalink: /tags/`); without it the theme's tag index isn't inherited and every post's `#tag` link 404s. Its chip/section styling lives in `styles.html`.
- **Mermaid:** GitHub Pages does **not** render mermaid on its own (that's a github.com repo-view feature only). It works here only because `mermaid.html` loads mermaid.js site-wide. Don't remove the include, and don't replace diagrams with images.

## Post frontmatter convention

```yaml
---
layout: post
title: "..."
description: "..."        # SEO; omit to fall back to auto-excerpt
date: YYYY-MM-DD
permalink: /slug/         # matches the original Hashnode slug
share-img: "/assets/images/og-slug.png"  # OG/social card image; optional
tags: [a, b, c]
discuss:                  # optional; renders a "Discuss this post" footer
  linkedin: "https://www.linkedin.com/posts/..."
  reddit: "https://www.reddit.com/r/..."
---
```

`share-img` sets the Open Graph / Twitter card image used when a post is shared.
OG images live in `assets/images/` named `og-<slug>.<ext>`. All posts have one
except `documentation-is-not-a-deliverable` (intentionally none).

`discuss` is an optional map of platform → URL. Each entry is independent (omit
any platform), and nothing renders if the whole block is absent — so you never
hand-write a discussion link at the bottom of an article. Known keys
(`linkedin`, `x`/`twitter`, `reddit`, `hackernews`/`hn`, `github`, `mastodon`)
get friendly labels; any other key is title-cased. Rendered by
`_includes/discuss-cta.html`, wired via the posts `after-content` default.

Body conventions (kept generator-agnostic for portability):
- Section headings use `###` (h3). The title lives in frontmatter. Do not use `#`/`##` in the body.
- Mermaid goes in ` ```mermaid ` fenced blocks (rendered live site-wide — do not replace with images).
- No Liquid tags inside post bodies.
- In-body cross-links between the author's own articles use relative URLs (`/slug/`), not `vikrantjain.hashnode.dev` URLs.

## About page

`about.md` is intentionally **evergreen**: it states identity, the blog's
thesis, durable domain experience, and patents — and deliberately omits anything
time-bound (current employer/role, year counts, active projects). LinkedIn and
GitHub links carry everything that changes, so the page stays low-maintenance.
Keep it that way: don't add facts that need editing as roles or dates change.
