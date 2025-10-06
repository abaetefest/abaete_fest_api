# Claude Code Instructions for Abaetefest API

## Git Commit Guidelines

When committing changes to this repository:

- **Do NOT include Co-Authored-By tag** - Commit as Iago Cavalcante only
- **Do NOT add Claude Code attribution** in commit messages
- Use clear, descriptive commit messages following conventional commits format

## Project-Specific Notes

### Environment Setup
- Production secrets are stored in Fly.io
- Fetch secrets via: `fly ssh console -a polished-snowflake-9723 --command "env"`
- Local `.env` file contains production credentials for development
- Always ensure `.env` is in `.gitignore`

### Development Workflow
1. Use Docker Compose for local development: `docker-compose up`
2. Set `DB_HOST=db` when using Docker, `DB_HOST=localhost` for local PostgreSQL
3. Run migrations: `mix ecto.migrate`
4. Compile: `mix compile`

### Dependencies
- Elixir 1.18.4
- Erlang/OTP 27+
- Phoenix 1.8.1
- PostgreSQL 16+
- Key packages: Guardian (JWT), phoenix_view, Bcrypt, AWS S3, OneSignal

### Linear Integration
- Project: Abaetefest
- Team: Iago Cavalcante
- Always update issue status and add comments when completing tasks
