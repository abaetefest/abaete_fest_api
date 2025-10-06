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

- Elixir 1.16+ and Erlang/OTP
- PostgreSQL 16+
- (Optional) Docker and Docker Compose

## Local Development Setup

### Option 1: With Docker (Recommended)

1. Clone the repository
2. Copy the environment file and configure it:
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. Start the services with Docker Compose:
   ```bash
   docker-compose up
   ```

The API will be available at `http://localhost:4000`

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

The project includes a `docker-compose.dokploy.yml` file for easy deployment with Dokploy:

```bash
docker-compose -f docker-compose.dokploy.yml up -d
```

Make sure to set all required environment variables in your Dokploy configuration.

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

- **Framework**: Phoenix 1.7.21
- **Language**: Elixir 1.16+
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
