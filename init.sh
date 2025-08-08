#!/bin/bash

# Sidewinder Template Setup Script
# This script sets up the development environment for the project

set -e  # Exit on any error

echo "🚀 Setting up Sidewinder Template development environment..."

# ==============================================
# 1. Dependency Installation
# ==============================================

echo "📦 Installing project dependencies..."
uv sync

# ==============================================
# 2. Git Hooks Setup
# ==============================================

echo "📋 Installing pre-commit hooks..."
uv run -- pre-commit install

# ==============================================
# 3. Environment Configuration
# ==============================================

echo "⚙️  Setting up environment configuration..."
if [ ! -f .env ]; then
    cp .env-example .env
    echo "✅ Created .env file from template"
    
    # Generate secure Django secret key
    echo "🔐 Generating secure Django secret key..."
    SECRET_KEY=$(uv run python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    sed -i.bak "s/DJANGO_SECRET_KEY=secretkey/DJANGO_SECRET_KEY=$SECRET_KEY/" .env
    rm -f .env.bak
    
    echo "⚠️  Please edit .env file to configure your environment variables"
    echo "   - Set ADMIN_EMAIL for admin notifications"
    echo "   - Configure database connection if needed"
    echo "   - Add PostHog API key if you want analytics"
else
    echo "ℹ️  .env file already exists, skipping creation"
fi

# ==============================================
# 4. Database Setup
# ==============================================

echo "🗄️  Running database migrations..."
uv run -- manage.py migrate

# ==============================================
# 5. Development Server
# ==============================================

echo "🌐 Starting development server..."
uv run -- manage.py runserver &

# ==============================================
# 6. Superuser Creation (Optional)
# ==============================================

echo "👤 Creating superuser account..."
read -p "Do you want to create a superuser now? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    uv run -- manage.py createsuperuser
else
    echo "ℹ️  You can create a superuser later by running: uv run -- manage.py createsuperuser"
fi

# ==============================================
# Setup Complete
# ==============================================

echo ""
echo "✅ Setup complete! Your development environment is ready."
echo "📖 Next steps:"
echo "   1. Edit .env file with your configuration"
echo "   2. Visit http://127.0.0.1:8000 to access the application"
echo "   3. Visit http://127.0.0.1:8000/admin for Django admin"
echo ""
echo "🔧 Useful commands:"
echo "   - Run tests: uv run -- pytest"
echo "   - Code quality: uv run -- ruff check"
echo "   - Start task queue: uv run -- manage.py run_huey"