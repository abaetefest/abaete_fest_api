# AbaeteFest API

A comprehensive festival and events management platform built with Elixir and Phoenix Framework for the Abaetefest in Abaetetuba, Brazil.

## Features

- Event management with multiple categories
- Tourist attractions with geolocation
- User authentication with JWT (Guardian)
- AWS S3 integration for media uploads
- Push notifications via OneSignal
- RESTful JSON API

## Prerequisites

- Elixir 1.18.4+ and Erlang/OTP 27+
- PostgreSQL 16+
- (Optional) Docker and Docker Compose

## Local Development Setup

### Option 1: With Docker (Recommended)

This is the easiest way to get started. Docker Compose will handle all dependencies including PostgreSQL.

1. **Clone the repository**

2. **Create your environment file:**
   ```bash
   cp .env.example .env
   ```
   The `.env` file is already configured with sensible defaults for Docker development. You can use it as-is or customize as needed.

3. **Start the services:**
   ```bash
   docker-compose up
   ```

   This will:
   - Start PostgreSQL with automatic health checks
   - Wait for the database to be ready
   - Run database migrations automatically
   - Start the Phoenix server with live reloading

4. **Access the API:**
   - API: `http://localhost:4000`
   - Database: `localhost:5432` (if you need direct access)

**Useful Docker commands:**
```bash
# Start in detached mode (background)
docker-compose up -d

# View logs
docker-compose logs -f app

# Stop all services
docker-compose down

# Rebuild after dependency changes
docker-compose up --build

# Access app shell
docker-compose exec app sh

# Run mix commands
docker-compose exec app mix deps.get
docker-compose exec app mix test
```

### Option 2: Without Docker

1. Install dependencies:
   ```bash
   mix deps.get
   ```

2. Configure your database in `config/dev.exs` or set environment variables:
   ```bash
   export DB_HOST=localhost
   ```

3. Create and migrate your database:
   ```bash
   mix ecto.setup
   ```

4. Start the Phoenix server:
   ```bash
   mix phx.server
   ```

   Or start inside IEx:
   ```bash
   iex -S mix phx.server
   ```

Now you can visit [`localhost:4000`](http://localhost:4000)

## Environment Variables

See `.env.example` for all required environment variables:

- **Database**: `DB_HOST`, `DATABASE_URL`, `POOL_SIZE`
- **Application**: `PORT`, `SECRET_KEY_BASE`, `APP_HOST`, `APP_PORT`
- **AWS S3**: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `BUCKET_NAME`, `REGION`
- **OneSignal**: `ONESIGNAL_ID`, `ONESIGNAL_KEY`
- **Dokploy**: `DOKPLOY_DOMAIN`, `DOKPLOY_PORT`

## API Endpoints

- `POST /api/users/signup` - User registration
- `POST /api/users/signin` - User authentication
- `GET/POST/PUT/DELETE /api/users` - User management (authenticated)
- `GET/POST/PUT/DELETE /api/events` - Event management
- `GET/POST/PUT/DELETE /api/attractions` - Attractions management

## Production Deployment

### With Dokploy

The project includes a `docker-compose.dokploy.yml` file optimized for production deployment with Dokploy.

**Setup:**

1. **Create production environment file:**
   ```bash
   cp .env.prod.example .env.prod
   ```

2. **Edit `.env.prod` with your production values:**
   - Set a strong `SECRET_KEY_BASE` (generate with `mix phx.gen.secret`)
   - Configure production database credentials
   - Add AWS S3 credentials
   - Add OneSignal credentials
   - Set your production domain

3. **Deploy with Dokploy:**
   ```bash
   docker-compose -f docker-compose.dokploy.yml up -d
   ```

**Important Security Notes:**
- Never commit `.env.prod` to version control
- Use strong, unique credentials for production
- Ensure `SECRET_KEY_BASE` is randomly generated
- Keep AWS and OneSignal credentials secure

### Manual Deployment

1. Generate a secret key base:
   ```bash
   mix phx.gen.secret
   ```

2. Set the `SECRET_KEY_BASE` environment variable with the generated value

3. Build a release:
   ```bash
   MIX_ENV=prod mix release
   ```

For more information, check the [Phoenix deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Tech Stack

- **Framework**: Phoenix 1.8.1
- **Language**: Elixir 1.18.4
- **Database**: PostgreSQL with Ecto
- **Authentication**: Guardian (JWT)
- **Storage**: AWS S3
- **Notifications**: OneSignal

## Learn More

- Official Phoenix website: https://www.phoenixframework.org/
- Phoenix guides: https://hexdocs.pm/phoenix/overview.html
- Phoenix docs: https://hexdocs.pm/phoenix
- Elixir forum: https://elixirforum.com/c/phoenix-forum
- Phoenix source: https://github.com/phoenixframework/phoenix
