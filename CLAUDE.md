# CLAUDE.md

Guidance for working in this repo. For the file map, publishing workflow, and
local preview, see **README.md** — this file covers the conventions and gotchas
that aren't obvious from the files themselves.

## What this is

Personal blog of Vikrant Jain, published with **Jekyll** on **GitHub Pages**.

- **Repo:** `vikrantjain/vikrantjain.github.io` (root user site)
- **Live URL:** https://vikrantjain.dev/ (custom domain via `CNAME`; the repo is still the `vikrantjain.github.io` user site)
- **Theme:** Beautiful Jekyll via `remote_theme: daattali/beautiful-jekyll@6.0.1`. No local theme files; native GitHub Pages build (no Actions, no custom plugins beyond `jekyll-sitemap`/`jekyll-seo-tag`/`jekyll-feed`).

## How customization works (don't break these)

All site customization rides on Beautiful Jekyll hooks (`head-extra`/`after-content` in `_config.yml`) — there are **no** local theme-layout overrides. Each include documents itself — the non-obvious, not-in-code bits:

- `_config.yml` sets `url:` explicitly so `jekyll-seo-tag`/`jekyll-feed`/`jekyll-sitemap` emit absolute URLs (og:image, RSS, sitemap) instead of relying on GitHub Pages auto-injection. `_config_local.yml` overrides it to localhost for preview.
- **Exclusions go in both config files.** `_config_local.yml` replaces the whole `exclude` list from `_config.yml` instead of merging with it. A path excluded only in `_config_local.yml` is still published in production. Local preview hides it, so the leak goes unnoticed.
- **Mermaid:** GitHub Pages doesn't render mermaid itself (that's a github.com repo-view feature). It works only because `mermaid.html` loads mermaid.js site-wide — don't remove it.
- **Remote themes ship `_layouts`/`_includes`/`_sass` only — not root pages.** Hence `tags.html` is recreated locally (explicit `permalink: /tags/`); without it the theme's tag index isn't inherited and every post's `#tag` link 404s.

## Post frontmatter contract

Posts are written by the `article-writer` plugin, which owns the content and the field values. This repo owns how each field renders. The field names and their meanings are the contract between the two.

**Renaming or repurposing a field needs the same change in the plugin's `references/jekyll-blog.md`.** Otherwise the plugin keeps writing the old field and the blog silently ignores it.

```yaml
---
layout: post
title: "..."              # also <title> and og:title; there is no separate SEO-title field
subtitle: "..."           # shown under the title and as the home-page blurb
description: "..."        # SEO; omit to fall back to auto-excerpt
date: YYYY-MM-DD
permalink: /slug/         # permanent once published; inbound links depend on it
share-img: "/assets/images/og-slug.png"  # OG/social card image; optional
tags: [a, b, c]
discuss:                  # optional; map of platform → discussion URL
  linkedin: "https://www.linkedin.com/posts/..."
---
```

`share-img` must point to a file that exists, stored as `assets/images/og-<slug>.<ext>`.
A missing file still builds, but every social share shows a broken card.
`discuss` renders the card in `_includes/discuss-cta.html`, which lists the
supported platform keys.
Never hand-write a discussion link in the body.

The build relies on these body rules:
- Section headings use `###` (h3). `_includes/toc.html` builds the table of contents from h3 only, so a `##` section is missing from it.
- Mermaid goes in ` ```mermaid ` fenced blocks. `_includes/mermaid.html` renders only those.
- No Liquid tags inside post bodies, code fences included. Jekyll processes them, which breaks the build or renders them empty.

## About page

`about.md` is intentionally **evergreen**: it states identity, the blog's
thesis, durable domain experience, and patents — and deliberately omits anything
time-bound (current employer/role, year counts, active projects). LinkedIn and
GitHub links carry everything that changes, so the page stays low-maintenance.
Keep it that way: don't add facts that need editing as roles or dates change.
