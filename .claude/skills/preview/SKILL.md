---
name: preview
description: Build or serve the blog locally in Docker to see changes rendered. Use when the user asks to preview the site, and before committing any change to _includes/, _config.yml, tags.html, a top-level page, or a post, to confirm the rendered HTML is right.
---

# Preview the blog locally

`scripts/preview.sh` runs Jekyll in Docker with the same `github-pages` gem as
production. It exits with a clear message if the Docker daemon is not running.
Relay that message to the user. Do not try to start Docker yourself.

## To verify your own change: `build`

Run `scripts/preview.sh build`. It compiles into `_site/` and exits.

Then check the rendered output, not the source. Each post is at
`_site/<permalink-slug>/index.html`. Grep for the markup you changed and read
the surrounding lines. For a site-wide include, check one post that uses the
feature and one that does not (for example, a post without `discuss`).

## For the user to browse: `serve`

`scripts/preview.sh serve` blocks until stopped. Run it in the background, then
give the user http://localhost:4000. Livereload rebuilds on each file save.
Edits to `_config.yml` need a restart.
