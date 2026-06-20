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

All site customization rides on Beautiful Jekyll hooks — there are **no** local theme-layout overrides. `_config.yml` injects `_includes/styles.html` and `_includes/mermaid.html` site-wide via `head-extra`; posts also get `_includes/toc.html` (head-extra) and `_includes/discuss-cta.html` (after-content). Each include documents itself — the non-obvious, not-in-code bits:

- `_config.yml` sets `url:` explicitly so `jekyll-seo-tag`/`jekyll-feed`/`jekyll-sitemap` emit absolute URLs (og:image, RSS, sitemap) instead of relying on GitHub Pages auto-injection. `_config_local.yml` overrides it to localhost for preview.
- **Mermaid:** GitHub Pages doesn't render mermaid itself (that's a github.com repo-view feature). It works only because `mermaid.html` loads mermaid.js site-wide — don't remove it, and don't swap diagrams for images.
- **Remote themes ship `_layouts`/`_includes`/`_sass` only — not root pages.** Hence `tags.html` is recreated locally (explicit `permalink: /tags/`); without it the theme's tag index isn't inherited and every post's `#tag` link 404s.

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

`share-img` is the OG/social-card image, stored as `assets/images/og-<slug>.<ext>`
(every post has one except `documentation-is-not-a-deliverable`). `discuss` is an
optional frontmatter map that renders a footer via `_includes/discuss-cta.html`
— see that file for supported platform keys and behavior. Never hand-write a
discussion link in the body.

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
