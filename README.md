自用 django starter kit, fork from [sidewinder](https://stribny.github.io/sidewinder/)

> Configured Django on your own server in 10 minutes.

# features
* Have a Huey task queue for background and periodic tasks
* Have state-of-the-art development tools including auto reloading, debugging and profiling tools, linters and formatters
* Log anything you want with structured logging
* Execute automated tests using the best testing library pytest
* Write test fixtures efficiently using factoryboy and Faker
* End-to-end test your frontend using Playwright
* Have commands for backups and restores on your VPS

# 使用流程
1. [ ] github 直接用 template, 然后 git clone
2. [ ] run init.sh，初始化一切
3. [ ] bash init.sh --force-env 会覆盖 .env

# 重要的文件
- CLAUDE.md

# log
- [x] remove geo part
- [x] add tailwind, preline
    - pnpm i preline
- [x] add captain-denifitin, Dockerfile
- [x] add whitenoise
 tailwind input.css move to static_build
 whitenoise 会 compress all css file, and input.css would make error, so move it
 npx @tailwindcss/cli -i ./static_build/css/input.css -o ./static/css/output.css --watch

- [x] alpine.js
- [x] django-cotton
 - all under cotton dir
- [x] add PostHog
