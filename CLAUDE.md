# Sidewinder Django Starter Kit
- All Python commands must use `uv run` prefix.
- 如果 CSS 有修改需要运行 `npx @tailwindcss/cli -i ./static_build/css/input.css -o ./static/css/output.css`

### Core Stack
- **Backend**: Django + DRF + django-allauth (email auth)
- **Frontend**: Tailwind CSS + Alpine.js + django-cotton
- **Database**: PostgreSQL
- **Tasks**: Huey + Redis
- **Logging**: django-structlog
- **Analytics**: PostHog
- **Deployment**: github + caprover

### 项目架构
- RESTful API with OpenAPI docs
- Service layer pattern
- Structured logging