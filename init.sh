#!/bin/bash

# Sidewinder Template Setup Script
# This script sets up the development environment for the project

set -e  # Exit on any error

# Handle command line arguments
FORCE_ENV=false
for arg in "$@"; do
    case $arg in
        --force-env)
            FORCE_ENV=true
            shift
            ;;
        --help|-h)
            echo "Usage: $0 [OPTIONS]"
            echo "Options:"
            echo "  --force-env    Force recreate .env file with new configuration"
            echo "  --help, -h     Show this help message"
            exit 0
            ;;
    esac
done

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
if [ ! -f .env ] || [ "$FORCE_ENV" = true ]; then
    if [ "$FORCE_ENV" = true ]; then
        echo "🔄 Force recreating .env file..."
    else
        echo "✅ Creating .env file from template..."
    fi
    
    cp .env-example .env
    
    # Set project name from directory name
    echo "📝 Setting project name..."
    PROJECT_NAME=$(basename "$(pwd)")
    sed -i.bak "s/^PROJECT_NAME=Sidewinder$/PROJECT_NAME=$PROJECT_NAME/" .env
    
    # Generate secure Django secret key
    echo "🔐 Generating secure Django secret key..."
    SECRET_KEY=$(uv run python -c "from django.core.management.utils import get_random_secret_key; print(get_random_secret_key())")
    sed -i.bak "s/^DJANGO_SECRET_KEY=secretkey$/DJANGO_SECRET_KEY=$SECRET_KEY/" .env
    rm -f .env.bak
    
    echo "⚠️  Please edit .env file to configure your environment variables"
    echo "   - Set ADMIN_EMAIL for admin notifications"
    echo "   - Configure database connection if needed"
    echo "   - Add PostHog API key if you want analytics"
    echo "   - Project name set to: $PROJECT_NAME"
else
    echo "ℹ️  .env file already exists, skipping creation"
    echo "💡 Use './init.sh --force-env' to recreate with new configuration"
fi

# ==============================================
# 4. Database Setup
# ==============================================

echo "🗄️  Running database migrations..."
uv run -- manage.py migrate

# ==============================================
# 5. Superuser Creation (Optional)
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
echo "   2. Start development server: uv run -- manage.py runserver"
echo "   3. Visit http://127.0.0.1:8000 to access the application"
echo "   4. Visit http://127.0.0.1:8000/admin for Django admin"
echo ""
echo "🔧 Useful commands:"
echo "   - Start server: uv run -- manage.py runserver"
echo "   - Run tests: uv run -- pytest"
echo "   - Code quality: uv run -- ruff check"
echo "   - Start task queue: uv run -- manage.py run_huey"
echo "   - Reset .env file: ./init.sh --force-env"