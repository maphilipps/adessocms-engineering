# CI/CD Setup Workflow

## GitLab CI/CD

### .gitlab-ci.yml Grundgerüst

```yaml
stages:
  - build
  - test
  - deploy

variables:
  COMPOSER_HOME: .composer
  PHP_VERSION: "8.3"

cache:
  key: ${CI_COMMIT_REF_SLUG}
  paths:
    - vendor/
    - web/core/
    - web/modules/contrib/

# Build Stage
build:
  stage: build
  image: php:${PHP_VERSION}-cli
  script:
    - composer install --no-dev --optimize-autoloader
  artifacts:
    paths:
      - vendor/
      - web/
    expire_in: 1 hour

# Test Stage
phpcs:
  stage: test
  image: php:${PHP_VERSION}-cli
  script:
    - composer install
    - vendor/bin/phpcs --standard=Drupal,DrupalPractice web/modules/custom

phpunit:
  stage: test
  image: php:${PHP_VERSION}-cli
  services:
    - mariadb:10.11
  variables:
    MYSQL_DATABASE: drupal
    MYSQL_ROOT_PASSWORD: root
  script:
    - vendor/bin/phpunit --testsuite=unit

# Deploy Stage
deploy_staging:
  stage: deploy
  script:
    - ssh deploy@staging "cd /var/www && git pull && composer install --no-dev"
    - ssh deploy@staging "cd /var/www && drush updatedb -y && drush cim -y && drush cr"
  only:
    - develop
  environment:
    name: staging

deploy_production:
  stage: deploy
  script:
    - ssh deploy@production "cd /var/www && git pull && composer install --no-dev"
    - ssh deploy@production "cd /var/www && drush updatedb -y && drush cim -y && drush cr"
  only:
    - main
  when: manual
  environment:
    name: production
```

---

## GitHub Actions

### .github/workflows/ci.yml

```yaml
name: CI

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Setup PHP
        uses: shivammathur/setup-php@v2
        with:
          php-version: '8.3'
          extensions: mbstring, xml, mysql

      - name: Cache Composer
        uses: actions/cache@v3
        with:
          path: vendor
          key: composer-${{ hashFiles('composer.lock') }}

      - name: Install dependencies
        run: composer install --prefer-dist

  test:
    needs: build
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: PHPCS
        run: vendor/bin/phpcs --standard=Drupal,DrupalPractice web/modules/custom

      - name: PHPUnit
        run: vendor/bin/phpunit --testsuite=unit
```

---

## Deployment Scripts

### deploy.sh

```bash
#!/bin/bash
set -e

# Variables
SITE_DIR="/var/www/drupal"
DRUSH="$SITE_DIR/vendor/bin/drush"

cd $SITE_DIR

# Maintenance Mode
$DRUSH state:set system.maintenance_mode 1

# Update Code
git pull origin main

# Install Dependencies
composer install --no-dev --optimize-autoloader

# Database Updates
$DRUSH updatedb -y

# Import Config
$DRUSH cim -y

# Clear Cache
$DRUSH cr

# Disable Maintenance
$DRUSH state:set system.maintenance_mode 0

echo "Deployment complete!"
```

---

## Best Practices

1. **Environments trennen**
   - Dev: `composer install` (mit dev dependencies)
   - Prod: `composer install --no-dev`

2. **Config Management**
   - Config Split für Umgebungen
   - Keine Dev-Module in Prod

3. **Rollback Plan**
   - Git Tags für Releases
   - Datenbank-Backup vor Deploy
   - Schnelles Rollback-Script

4. **Secrets Management**
   - CI/CD Variables für Credentials
   - Nie Secrets in Git
