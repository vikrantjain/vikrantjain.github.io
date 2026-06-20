# Blog

Personal blog, published with Jekyll on GitHub Pages. GitHub builds and
deploys the site server-side on every push to `main` — no local toolchain
needed.

## Structure

- `_posts/` — published articles, named `YYYY-MM-DD-slug.md`. Everything here
  is live.
- `_includes/` — custom includes layered on the remote theme: `styles.html`
  (site CSS), `mermaid.html` (diagram rendering), `discuss-cta.html` (post
  discussion footer).
- `assets/images/` — images referenced by posts, including `og-<slug>` social
  cards.
- `index.md` (home), `about.md`, `tags.html` (tag index) — top-level pages.
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

## Local preview

Publishing needs no local toolchain, but to preview changes before pushing,
run Jekyll in the `ruby:3.3` Docker image (no Ruby is installed on the host).
The `github-pages` gem in the `Gemfile` mirrors GitHub's build environment, so
what you see locally matches production. From the repo root:

```bash
docker run --rm -p 4000:4000 -v "$PWD":/srv/jekyll -w /srv/jekyll ruby:3.3 \
  bash -c "bundle config set --local path vendor/bundle && bundle install && \
  bundle exec jekyll serve --host 0.0.0.0 --livereload --config _config.yml,_config_local.yml"
```

Then open http://localhost:4000. For a one-shot compile check (no server),
swap `jekyll serve ...` for `jekyll build ...` — output lands in `_site/`.

`_config_local.yml` overrides `url` to `localhost` so absolute URLs (og:image,
RSS feed, sitemap) point local instead of the live domain. `vendor/bundle` and
`_site/` are gitignored.
