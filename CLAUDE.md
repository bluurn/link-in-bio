# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Development Environment

This project uses [devenv](https://devenv.sh) (Nix-based) for a reproducible environment. The shell activates automatically via direnv when entering the project directory.

```sh
devenv shell   # enter manually
devenv up      # start PostgreSQL and any other configured processes
```

All commands below assume you are inside the devenv shell (or have direnv active).

## Database

devenv manages a local PostgreSQL instance. It sets `PGHOST` and `PGPORT` automatically; `database.yml` picks these up via `ENV`.

```sh
bin/rails db:create    # create development + test DBs (also handled by devenv initialDatabases)
bin/rails db:migrate
bin/rails db:seed
```

## Running the App

```sh
bin/rails server       # http://localhost:3000
bin/rails console
```

## Tests

```sh
bin/rails test                        # all tests
bin/rails test test/models/foo_test.rb          # single file
bin/rails test test/models/foo_test.rb:42       # single test by line
bin/rails test:system                 # system (Capybara/Selenium) tests
```

## Linting & Security

```sh
bin/rubocop            # lint (config in .rubocop.yml, inherits rubocop-rails-omakase)
bin/brakeman           # static security scan
```

## Architecture

Rails 8.1 monolith with:
- **Import maps** (`importmap-rails`) — no Node/webpack build step for JS
- **Stimulus + Turbo** (`stimulus-rails`, `turbo-rails`) — Hotwire stack for frontend interactivity
- **Sprockets** — asset pipeline for CSS/images
- **Action Cable** — WebSocket support (via `cable.yml`)
- **Active Storage** — file attachment support (configured in `storage.yml`)

devenv provides PostgreSQL; databases `link_in_bio_development` and `link_in_bio_test` are created on `devenv up`.
