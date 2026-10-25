---
name: preview
description: Build, serve, or screenshot the blog locally to see changes rendered. Use when the user asks to preview the site or how something looks, and before committing any change to _includes/, _config.yml, tags.html, a top-level page, or a post, to confirm the rendered HTML (and, for visual changes, the screenshots) is right.
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

To test a frontmatter variant no post uses yet (say, several `discuss`
platforms), add a temporary post under `_posts/`, build, and delete it before
committing. Run `git status` to confirm it is gone.

## To see how it looks: `scripts/screenshot.sh`

Use this for any change to CSS, layout, or how an include looks. Markup that
greps correctly can still render badly. Run it after `build`:

```bash
scripts/screenshot.sh -o <scratchpad>/shots /<slug>/ .discuss-cta
```

- The second argument is an optional CSS selector. The script hides everything
  above that element, so it appears at the top of the shot. Without one, the
  shot shows the top of the page.
- It shoots at 1280 px (desktop) and 390 px (phone) by default. Use `-w` to
  change the widths.
- It prints the path of each PNG. Read every one before you report on how the
  page looks. Check the phone shot for wrapped buttons and cramped spacing.
- A red "SELECTOR NOT FOUND" shot means the selector matched nothing.

## For the user to browse: `serve`

`scripts/preview.sh serve` blocks until stopped. Run it in the background, then
give the user http://localhost:4000. Livereload rebuilds on each file save.
Edits to `_config.yml` need a restart.
