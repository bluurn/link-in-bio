# BRYGHT Link-in-Bio

A Linktree-style Rails app. A community manager curates digital content from a catalog onto a public mobile-first link-in-bio page. Visitors click through to internal content detail pages.

## Prerequisites

- Ruby 3.4.9 (`.ruby-version` is present — rbenv/asdf will pick it up automatically)
- PostgreSQL 14+ running locally

**Option A — devenv (Nix):** installs Ruby, Bundler, and PostgreSQL automatically.

```sh
# install devenv: https://devenv.sh/getting-started
devenv up        # starts PostgreSQL
devenv shell     # enter the environment (or rely on direnv)
```

**Option B — Docker:** starts PostgreSQL only; Ruby must be installed separately.

```sh
docker compose up -d
```

**Option C — local PostgreSQL:** install Postgres however you like, then set `PGHOST` and `PGPORT` if they differ from the defaults (`localhost`, `5432`).

## Setup

```sh
bundle install
bin/rails db:create db:migrate db:seed
```

Seeds create one community (`bryght`), 120 catalog items (40 each of Course / Event / Playlist), and 6 pre-selected items.

## Running the app

```sh
bin/dev        # starts Rails + Tailwind CSS watcher
```

Then open:

| URL | Description |
|-----|-------------|
| `http://localhost:3000/` | Redirects to the first community's public page |
| `http://localhost:3000/bryght` | Public link-in-bio page |
| `http://localhost:3000/bryght/manage` | Management view |

## Tests

```sh
bin/rails test                              # full suite
bin/rails test test/models/content_test.rb # single file
bin/rails test test/models/content_test.rb:42 # single test by line
```

## Lint & security

```sh
bin/rubocop    # style (rubocop-rails-omakase)
bin/brakeman   # static security scan
```

---

## Decisions

**Type filter + live search via Turbo Frames.** With 120 catalog items, a plain scrollable list is manageable but noisy. A type filter (Course / Event / Playlist) combined with a debounced title search (300 ms, Stimulus) narrows results instantly without a page reload. The catalog lives in a `<turbo-frame>` so only that section refreshes on filter changes; add/remove actions use standard redirects that thread the current filter params back, keeping the view state intact.

**Add/Remove via redirect, not Turbo Streams.** Keeping selection changes as plain POST/DELETE + redirect avoids the complexity of Turbo Stream responses targeting both the catalog frame and the selection panel. Turbo's soft navigation makes the redirect feel fast. The search params (`q`, `kind`) are passed as hidden fields and preserved across the redirect.

**No authentication on `/manage`.** Out of scope per the spec. The route is effectively unlisted — no link to it appears on the public page.

**Single community in seeds, multi-community in code.** The data model and routes support multiple communities (each with their own slug and independent selection), but the seeds only create one (`bryght`) for the demo.

**Cover images via external URLs.** Seeds use `picsum.photos` placeholder images. Active Storage is available in the stack but upload/media management is explicitly out of scope.

---

## Limitations & open points

- `/manage` has no authentication — add HTTP Basic Auth or Devise before any real deployment
- No ordering control for selected items (insertion order only); drag-and-drop reordering would need a `position` column and a Stimulus drag controller
- No pagination on the catalog — 120 items is fine, but the type filter + search keeps it practical at that scale; pagination would be needed beyond ~300 items
- Cover image upload not implemented — `cover_image_url` stores a string URL; Active Storage wiring is left as a next step
