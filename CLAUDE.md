All Python commands in this project must be run via uv using the form uv run <command>.

## Development Commands

### Testing
- `uv run -- pytest` - Run all tests (excludes UI tests by default)
- `uv run -- pytest -m ui` - Run UI/end-to-end tests only
- `uv run -- pytest tests/core/api/` - Run API-specific tests
- `uv run -- pytest tests/core/ui/` - Run UI tests with Playwright
- `uv run -- pytest --cov` - Run tests with coverage report

### Code Quality
- `uv run -- ruff check` - Lint code with Ruff (includes import sorting)
- `uv run -- ruff format` - Format code with Ruff
- `uv run -- pre-commit run --all-files` - Run all pre-commit hooks

### Frontend Development
- `npx @tailwindcss/cli -i ./static_build/css/input.css -o ./static/css/output.css --watch` - Build Tailwind CSS in watch mode
- `pnpm i preline` - Install Preline UI components
- `pnpm install` - Install Node.js dependencies

### Background Tasks
- `uv run -- manage.py run_huey` - Start Huey task queue consumers
- `uv run -- manage.py runcommand` - Test PostHog integration command

### Documentation
- `uv run -- mkdocs serve` - Start live-reloading documentation server
- `uv run -- mkdocs build` - Build documentation site

### Docker Development
- `docker-compose up -d` - Start Redis and Mailhog services
- `docker-compose down` - Stop development services

## Architecture Overview

### Django Project Structure
This is a Django starter kit with modern development tools and practices:

- **appname/** - Main Django project directory (renameable)
  - **core/** - Primary Django app with user management, API, and core functionality
  - **settings.py** - Environment-based configuration with django-environ
  - **urls.py** - URL routing with API, admin, auth, and core routes
  - **wsgi.py/asgi.py** - WSGI/ASGI application entry points

### Key Applications and Features

#### Core App (`appname/core/`)
- **Models**: Custom `User` model extending `AbstractUser`, `UserProfile`, `UserFeedback`, `BaseModel` with timestamps
- **Authentication**: Django-allauth with email-based authentication, custom forms, and terms acceptance
- **API**: Django REST Framework with Token authentication, OpenAPI schema via drf-spectacular
- **Services**: Structured service classes (e.g., `EmailService`)
- **Background Tasks**: Huey integration for periodic and async tasks
- **Templates**: Django templates with django-cotton component system

#### Authentication System
- Email-based authentication with django-allauth
- Custom User model with email as username
- Terms acceptance tracking in UserProfile
- Token authentication for API access
- Custom login/signup forms with terms acceptance

#### API Structure
- RESTful API with DRF and standardized error handling
- OpenAPI schema at `/api/schema/` with Redoc documentation at `/api/redoc/`
- Token-based authentication for protected endpoints
- CORS configuration for API endpoints

### Frontend Architecture
- **Tailwind CSS** v4 for styling with Preline UI components
- **Alpine.js** for JavaScript interactivity
- **Django Templates** with django-cotton component system
- **Static files** served via WhiteNoise with compression

### Database and Models
- **Custom User Model**: Email-based authentication with extended profile
- **BaseModel**: Abstract base class with created_at/updated_at timestamps
- **Environment-based**: Uses django-environ for flexible database configuration
- **Migrations**: Standard Django migration system

### Task Queue System
- **Huey**: Redis-based task queue with consumer support
- **Periodic Tasks**: Example daily user report task
- **Development Mode**: Can bypass Redis in development with `HUEY_DEV=True`

### Logging and Monitoring
- **Structured Logging**: Django-structlog with JSON and formatted output
- **Development Tools**: Debug toolbar, Django Silk profiling, rich tracebacks
- **PostHog Integration**: Event tracking and user analytics with middleware support
- **Multiple Formatters**: JSON, plain console, and key-value log formats

### Email System
- **SMTP Configuration**: Environment-based email settings
- **Development**: Console backend in development, SMTP in production
- **Email Service**: Structured email sending service class
- **Templates**: Custom email templates for various user interactions

### Testing Architecture
- **Pytest**: Primary testing framework with Django integration
- **Factory Boy**: Test fixtures and data generation
- **Playwright**: End-to-end UI testing with `-m ui` marker
- **Coverage**: Code coverage reporting with pytest-cov
- **Test Organization**: Separate directories for API, UI, and view tests

### Deployment System
- **Ansible**: Infrastructure as code for VPS deployment
- **Docker**: Containerization support with captain-definition for CapRover
- **Services**: Redis, PostgreSQL, Caddy, and application services
- **Backups**: Database and media backup/restore commands
- **Environment**: Production-ready with SSL, security headers, and static file handling

### Development Tools
- **uv**: Modern Python dependency management
- **Ruff**: Fast Python linter and formatter
- **Pre-commit**: Git hooks for code quality
- **IPython**: Enhanced shell with Django model auto-imports
- **Django Extensions**: Additional management commands and utilities

### Configuration Management
- **Environment Variables**: All configuration via .env files using django-environ
- **Debug/Production**: Conditional settings for different environments
- **Security**: SSL settings, CORS, CSRF, and security headers
- **Static Files**: WhiteNoise for static file serving with compression

### Key Patterns
- **Service Layer**: Business logic in service classes (e.g., `EmailService`)
- **Base Models**: Timestamps and common fields via `BaseModel`
- **Custom Forms**: Extended authentication forms with terms acceptance
- **Task Decorators**: Huey tasks with proper decorators and locking
- **Context Processors**: Global settings available in templates