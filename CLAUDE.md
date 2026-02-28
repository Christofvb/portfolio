# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

**Development server:**
```bash
bin/dev          # Starts Rails server + Tailwind CSS watcher
```

**Rails tasks:**
```bash
bin/rails server          # Rails only
bin/rails db:migrate
bin/rails db:seed
bin/rails console
```

**Tests:**
```bash
bin/rails test                                      # All tests
bin/rails test test/models/skill_test.rb           # Single file
bin/rails test:system                              # System tests (Capybara/Selenium)
```

**Linting & security:**
```bash
bin/rubocop         # Code style (rubocop-rails-omakase)
bin/brakeman        # Security scan
```

**Deployment:**
```bash
bin/kamal deploy    # Deploy via Kamal to Docker
```

## Architecture

This is a **Rails 8 portfolio/CMS application** for Christof Van Berendonck. Public visitors see the portfolio; authenticated admins manage content.

### Tech stack
- **Ruby 3.3.5 / Rails 8.0**
- **SQLite** — single DB in development; separate DBs for cache/queue/cable in production
- **Propshaft** asset pipeline, **Tailwind CSS v4**, **Importmap** (no JS build step)
- **Hotwire** (Turbo + Stimulus) for interactivity
- **Devise** for admin authentication
- **Solid Cache / Queue / Cable** — database-backed Rails 8 defaults
- **Kamal + Docker** for deployment

### Public vs. admin split

| Route | Controller | Auth required |
|---|---|---|
| `/` | `pages#home` | No |
| `/curriculum_vitae` | `pages#resume` | No |
| `/portfolio` | `pages#portfolio` | No |
| `/skills`, `/educations`, `/experiences`, `/projects` | CRUD controllers | Yes (`authenticate_user!`) |

### Domain models

- **Skill** — technology skills with an enum `skill_type`: `language(0)`, `framework(1)`, `tool(2)`, `other(3)`
- **Education** — school, degree, dates, description
- **Experience** — job entry; `has_many :projects, dependent: :destroy` with `accepts_nested_attributes_for :projects, allow_destroy: true`
- **Project** — belongs to an experience (name, description)
- **User** — Devise authentication; typically a single admin user

### External services (`app/services/`)

Both services cache responses for 1 day using Rails.cache.

- **GithubService** — fetches public (non-forked) repos for "Christofvb" via `Net::HTTP`
- **CodewarsService** — fetches CodeWars profile for "Christofvb" via `Net::HTTP`

### Frontend

**CSS** lives in `app/assets/tailwind/` with component partials (buttons, cards, forms, tables, header, resume, skills list) compiled into `app/assets/builds/tailwind.css`.

**Stimulus controllers** (`app/javascript/controllers/`):
- `typing_controller.js` — typing animation on home page
- `tinymce_controller.js` — rich text editor for experience missions/tools fields
- `projects_controller.js`, `modal_controller.js`, `reveal_controller.js`, `codewars_controller.js`

### Key conventions

- Omakase RuboCop style (`rubocop-rails-omakase`)
- `authenticate_user!` before filter on all admin controllers (skills, educations, experiences, projects index)
- Experience forms use nested attributes — projects are created/edited/destroyed inline within the experience form
