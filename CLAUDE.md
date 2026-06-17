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
- `_config.yml` — site config. Both includes are injected on every page via the `head-extra` default (a Beautiful Jekyll hook). `permalink: /:title/`.
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
tags: [a, b, c]
---
```

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

## Open items / constraints

- The **multi-agent article** (`../articles/claude-chat/article.md`) is a contracted client deliverable and must NOT be published until written client approval. It is deliberately not in this repo yet.
- A few post bodies still contain `vikrantjain.hashnode.dev` cross-links to the author's own articles; these should be repointed to relative URLs (`/slug/`).
- Never publish real client/vendor/person/financial identifiers in any article.
