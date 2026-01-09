# Composer Patterns Reference

## Version Constraints

| Constraint | Meaning | Example |
|------------|---------|---------|
| `^1.2.3` | >=1.2.3 <2.0.0 | Semver-kompatibel |
| `~1.2.3` | >=1.2.3 <1.3.0 | Nur Patch-Updates |
| `1.2.*` | >=1.2.0 <1.3.0 | Wildcard |
| `>=1.2.3` | >=1.2.3 | Minimum |
| `1.2.3` | Exakt 1.2.3 | Pinned |

**Best Practice:** `^` für die meisten Packages nutzen.

---

## Drupal-spezifische Patterns

### composer.json Struktur

```json
{
  "name": "drupal/recommended-project",
  "type": "project",
  "require": {
    "drupal/core-recommended": "^10.3",
    "drupal/core-composer-scaffold": "^10.3",
    "drush/drush": "^12"
  },
  "require-dev": {
    "drupal/coder": "^8.3",
    "drupal/devel": "^5"
  },
  "extra": {
    "drupal-scaffold": {
      "locations": {
        "web-root": "web/"
      }
    },
    "installer-paths": {
      "web/core": ["type:drupal-core"],
      "web/modules/contrib/{$name}": ["type:drupal-module"],
      "web/themes/contrib/{$name}": ["type:drupal-theme"],
      "web/profiles/contrib/{$name}": ["type:drupal-profile"]
    }
  }
}
```

---

## Patching

### composer-patches Setup

```json
{
  "require": {
    "cweagans/composer-patches": "^1.7"
  },
  "extra": {
    "enable-patching": true,
    "patches": {
      "drupal/module_name": {
        "Issue #12345 - Description": "https://www.drupal.org/files/issues/patch.patch"
      }
    }
  }
}
```

### Lokale Patches

```json
{
  "patches": {
    "drupal/module": {
      "Custom fix": "patches/module-custom-fix.patch"
    }
  }
}
```

### Patch erstellen

```bash
# Von Git Diff
git diff > patches/fix.patch

# Von Drupal.org
# Download und in patches/ speichern
```

---

## Scripts

```json
{
  "scripts": {
    "post-install-cmd": [
      "drush cr"
    ],
    "phpcs": "phpcs --standard=Drupal,DrupalPractice web/modules/custom",
    "phpcbf": "phpcbf --standard=Drupal,DrupalPractice web/modules/custom",
    "test": "phpunit --testsuite=unit"
  }
}
```

---

## Repositories

### Private Packages

```json
{
  "repositories": [
    {
      "type": "composer",
      "url": "https://packages.example.com"
    }
  ]
}
```

### Git Repository

```json
{
  "repositories": [
    {
      "type": "vcs",
      "url": "git@github.com:org/private-module.git"
    }
  ]
}
```

### Lokales Package

```json
{
  "repositories": [
    {
      "type": "path",
      "url": "../local-module"
    }
  ]
}
```

---

## Commands Quick Reference

```bash
# Install
composer install                    # Install from lock
composer install --no-dev          # Production

# Require
composer require drupal/module     # Add package
composer require --dev drupal/devel  # Dev only

# Update
composer update                    # Update all
composer update drupal/module      # Update one
composer update --with-all-dependencies  # With deps

# Remove
composer remove drupal/module      # Remove package

# Info
composer show                      # All packages
composer show drupal/module        # Package info
composer outdated                  # Outdated packages
composer audit                     # Security check

# Debug
composer why drupal/module         # Why installed?
composer why-not drupal/module 2.0 # Why not version?
composer diagnose                  # System check
```

---

## Troubleshooting

### Memory Limit

```bash
php -d memory_limit=-1 /usr/local/bin/composer update
```

### Clear Cache

```bash
composer clear-cache
```

### Regenerate Lock

```bash
rm composer.lock
composer install
```

### Autoload Issues

```bash
composer dump-autoload
composer dump-autoload --optimize  # Production
```
