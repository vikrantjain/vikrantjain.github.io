# CLAUDE.md

Guidance for working in this repo.

## What this is

Personal blog of Vikrant Jain, published with **Jekyll** on **GitHub Pages**.

- **Repo:** `vikrantjain/vikrantjain.github.io` (root user site)
- **Live URL:** https://vikrantjain.github.io/
- **Theme:** Beautiful Jekyll via `remote_theme: daattali/beautiful-jekyll@6.0.1` (no local theme files; build is native GitHub Pages, no Actions)
- Articles were migrated from Hashnode (`vikrantjain.hashnode.dev`). Hashnode is no longer the source of truth — this repo is.

## Structure

- `_posts/` — published articles, `YYYY-MM-DD-slug.md`. Everything here is live.
- `_includes/mermaid.html` — loads mermaid.js and renders ` ```mermaid ` code blocks as diagrams.
- `_includes/styles.html` — Hashnode-style CSS (Inter font, reading sizing, centered titles, full-width thin `hr`, code/quote styling).
- `_config.yml` — site config. Both includes are injected on every page via the `head-extra` default (a Beautiful Jekyll hook). `permalink: /:title/`. `url: https://vikrantjain.github.io` is set explicitly so `jekyll-seo-tag`/`jekyll-feed`/`jekyll-sitemap` emit absolute URLs (og:image, RSS, sitemap) instead of relying on GitHub Pages auto-injection; `_config_local.yml` overrides it to `http://localhost:4000` for local preview.
- `assets/images/` — images referenced by posts.
- `index.md` (`layout: home`), `about.md` (`layout: page`).

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

## Mermaid

GitHub Pages does **not** render mermaid on its own (that's a github.com repo-view feature only). It works here because `_includes/mermaid.html` loads mermaid.js and is included on every page via `head-extra`. Don't remove it.

## Publishing workflow

`main` always equals the live site; GitHub Pages auto-builds on push. Work in progress lives on branches (Pages never builds them).

1. Draft in the separate `../articles/` working folder.
2. Branch off `main`, add the post to `_posts/` with the frontmatter above.
3. Open a PR (the "ready to publish?" checkpoint), then merge to `main`.

## Local preview

No Ruby is installed on the host — preview runs in the `ruby:3.3` Docker image.
The exact `docker run` command (and a `jekyll build` compile-check variant) is
in **README.md** under "Local preview". Site serves at http://localhost:4000.

## Open items / constraints

- In-body cross-links between the author's own articles must use relative URLs (`/slug/`), not `vikrantjain.hashnode.dev` URLs.
