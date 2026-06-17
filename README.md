# Blog

Personal blog, published with Jekyll on GitHub Pages. GitHub builds and
deploys the site server-side on every push to `main` — no local toolchain
needed.

## Structure

- `_posts/` — published articles, named `YYYY-MM-DD-slug.md`. Everything here
  is live.
- `assets/images/` — images referenced by posts.
- `_config.yml` — site config. `permalink: /:title/` locks clean URLs.

## Publishing workflow

`main` always equals the published site. Work in progress lives on branches,
which GitHub Pages never builds.

1. Draft an article in the separate `articles/` working folder.
2. When ready, branch off `main` (e.g. `post/<slug>`) and add the body as
   `_posts/YYYY-MM-DD-slug.md` with Jekyll frontmatter (`layout`, `title`,
   `description`, `tags`, `permalink`).
3. Open a PR. The PR is the "ready to publish?" checkpoint.
4. Merge to `main`. GitHub Pages builds and deploys automatically.
