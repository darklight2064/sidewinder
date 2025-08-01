# Sidewinder
自用 django starter kit, fork from sidewinder

# todos after init
- [ ] remove geo part
- [ ] add tailwind, prelineui
- [ ] add captain-denifitin, Dockerfile
- [ ] add whitenoise
 tailwind input.css move to static_build
 whitenoise 会 compress all css file, and input.css would make error, so move it
 npx @tailwindcss/cli -i ./static_build/css/input.css -o ./static/css/output.css --watch

# features
> Configured Django on your own server in 10 minutes.

* Use all Django features like GeoDjango
* Use a modern Python dependency manager uv
* Use environment variables instead of juggling multiple configuration files
* Use django-allauth to provide email-based and 3rd party authentication
* Have a custom User model for ultimate flexibility
* Have Django REST Framework at your disposal right from the start, including modern API docs, standardized error responses, and CORS configuration
* Have a Huey task queue for background and periodic tasks
* Have state-of-the-art development tools including auto reloading, debugging and profiling tools, linters and formatters
* Log anything you want with structured logging
* Execute automated tests using the best testing library pytest
* Write test fixtures efficiently using factoryboy and Faker
* End-to-end test your frontend using Playwright
* Deploy to your own VPS in the "It just works" style using Ansible
* Have commands for backups and restores on your VPS
* Not be limited in customization as all important files are exposed and ready to be changed

### Documentation

[Documentation](https://stribny.github.io/sidewinder/)