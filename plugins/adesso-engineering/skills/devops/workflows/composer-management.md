# Composer Management Workflow

## Dependencies hinzufügen

```bash
# Contrib Module
ddev composer require drupal/admin_toolbar

# Dev-Only
ddev composer require --dev drupal/devel

# Spezifische Version
ddev composer require drupal/paragraphs:^1.17

# Mit allen Dependencies updaten
ddev composer require drupal/token --with-all-dependencies
```

---

## Dependencies aktualisieren

### Einzelnes Package

```bash
# Nur das Package
ddev composer update drupal/core-recommended

# Mit Dependencies
ddev composer update drupal/core-recommended --with-all-dependencies
```

### Drupal Core Update

```bash
# Core + alle Drupal Packages
ddev composer update "drupal/core-*" --with-all-dependencies

# Nach Update
ddev drush updatedb -y
ddev drush cr
ddev drush cex -y
```

### Alle Packages

```bash
# Alle updaten
ddev composer update

# Nur Minor/Patch
ddev composer update --prefer-stable
```

---

## Patches anwenden

### composer.json

```json
{
  "extra": {
    "patches": {
      "drupal/paragraphs": {
        "Fix duplicate issue": "https://drupal.org/files/issues/fix-123.patch"
      }
    },
    "enable-patching": true
  }
}
```

### Patch anwenden

```bash
# Nach Hinzufügen
ddev composer update drupal/paragraphs
```

### Lokaler Patch

```json
{
  "patches": {
    "drupal/module": {
      "Description": "patches/module-fix.patch"
    }
  }
}
```

---

## Security Check

```bash
# Vulnerabilities prüfen
ddev composer audit

# Outdated Packages
ddev composer outdated --direct

# Drupal Security Updates
ddev drush pm:security
```

---

## Troubleshooting

### Memory Limit

```bash
# In DDEV
ddev exec php -d memory_limit=-1 /usr/local/bin/composer update
```

### Lock File Conflict

```bash
# Lock neu generieren
ddev composer update --lock
```

### Cache leeren

```bash
ddev composer clear-cache
```

---

## Best Practices

1. **Version Constraints**
   - `^1.0` für Semver-kompatible Packages
   - `~1.0` für striktere Kontrolle
   - Nie `*` oder `dev-main` in Produktion

2. **Lock File**
   - Immer committen
   - `composer install` nutzt Lock
   - `composer update` aktualisiert Lock

3. **Audit regelmäßig**
   - Vor jedem Release
   - Security Updates priorisieren
