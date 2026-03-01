# Portfolio — Christof Van Berendonck

Personal portfolio and CMS built with Ruby on Rails 8. Public visitors browse the CV, portfolio and GitHub projects; the authenticated admin manages all content through a back-office interface.

## Features

**Public pages**
- **Home** — presentation with animated particle-network background and typing effect
- **Curriculum Vitae** — skills, professional experience (with missions and projects), education, spoken languages, and live Codewars stats
- **Portfolio** — public GitHub repositories fetched live via the GitHub API

**Admin CMS** (login required)
- CRUD for Skills, Educations, Experiences (with nested Projects)
- Rich-text editor (TinyMCE) for missions and tools fields

**Internationalisation**
- Three languages: French (default), English, Dutch
- UI labels translated via Rails i18n (`config/locales/`)
- Dynamic content (job titles, missions, tools, project descriptions) translated at database level with the [Mobility](https://github.com/shioyama/mobility) gem (key-value backend, fallback to French)

**External integrations**
- `GithubService` — fetches public, non-forked repos for the "Christofvb" account
- `CodewarsService` — fetches kata stats for the "Christofvb" account
- Both services cache responses for 24 h via Rails.cache (Solid Cache)

## Tech stack

| Layer | Choice |
|---|---|
| Language / framework | Ruby 3.3.5 / Rails 8.0 |
| Database | SQLite (dev) |
| Asset pipeline | Propshaft + Tailwind CSS v4 |
| JavaScript | Importmap + Hotwire (Turbo + Stimulus) |
| Authentication | Devise (single admin user, registration disabled) |
| Translations | Rails i18n + Mobility gem |
| Background jobs | Solid Queue |
| Cache | Solid Cache |
| Action Cable | Solid Cable |
| Deployment | Kamal + Docker (Heroku) |

## Local setup

```bash
git clone https://github.com/christofvb/portfolio.git
cd portfolio

bundle install
bin/rails db:create db:migrate db:seed

bin/dev   # Rails server + Tailwind watcher on http://localhost:3000
```

To create an admin account:

```bash
bin/rails console
User.create!(email: "you@example.com", password: "yourpassword")
```

## Running tests

```bash
bin/rails test              # all unit + integration tests
bin/rails test:system       # system tests (Capybara / Selenium)
```

## Linting and security

```bash
bin/rubocop     # code style (rubocop-rails-omakase)
bin/brakeman    # static security analysis
```

## Deployment

The app is deployed on Heroku via Docker + Kamal.

```bash
bin/kamal deploy
```

After a deploy that includes new migrations:

```bash
heroku run bin/rails db:migrate
```
