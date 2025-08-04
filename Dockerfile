FROM ghcr.io/astral-sh/uv:0.8.4-python3.12-alpine
WORKDIR /usr/src/app
# Copy only dependency-related files first
COPY pyproject.toml uv.lock /usr/src/app/
# Run uv sync with only production dependencies
RUN uv sync --no-group test --no-group dev
# Copy the rest of the project files
COPY . /usr/src/app
EXPOSE 80
CMD ["sh", "-c", ".venv/bin/python manage.py collectstatic --noinput && exec .venv/bin/gunicorn --bind 0.0.0.0:8000 appname.wsgi"]
