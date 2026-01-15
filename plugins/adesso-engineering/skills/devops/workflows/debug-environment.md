# Debug Environment Workflow

## DDEV Troubleshooting

### Container startet nicht

```bash
# Status prüfen
ddev describe

# Logs ansehen
ddev logs

# Router-Status
ddev poweroff && ddev start

# Docker prüfen
docker ps
docker system prune -f
```

### Port-Konflikte

```bash
# Ports anzeigen
ddev describe | grep -i port

# Ports ändern in .ddev/config.yaml
router_http_port: "8080"
router_https_port: "8443"
```

### Performance-Probleme (macOS)

```yaml
# .ddev/config.yaml
mutagen_enabled: true
```

```bash
# Mutagen Status
ddev mutagen status

# Mutagen Reset
ddev mutagen reset
```

---

## PHP Debugging

### Xdebug aktivieren

```bash
# Aktivieren
ddev xdebug on

# Deaktivieren
ddev xdebug off

# Status
ddev xdebug status
```

### PhpStorm Konfiguration

1. File → Settings → PHP → Debug
2. Xdebug Port: 9003
3. "Listen for PHP Debug Connections" aktivieren
4. Server konfigurieren mit Path Mappings

### VS Code launch.json

```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Listen for Xdebug",
      "type": "php",
      "request": "launch",
      "port": 9003,
      "pathMappings": {
        "/var/www/html": "${workspaceFolder}"
      }
    }
  ]
}
```

---

## Datenbank-Probleme

### Verbindung testen

```bash
# MySQL CLI
ddev mysql

# Query ausführen
ddev drush sqlq "SHOW TABLES"

# Connection Info
ddev describe | grep -i database
```

### Datenbank reparieren

```bash
# Backup erstellen
ddev export-db --file=backup.sql.gz

# Tabellen reparieren
ddev mysql -e "REPAIR TABLE cache_data"

# Neu importieren
ddev import-db --file=backup.sql.gz
```

### Große Datenbank importieren

```bash
# Timeout erhöhen
ddev import-db --file=large-db.sql.gz --progress
```

---

## Composer-Probleme

### Memory Limit

```bash
# Unlimited Memory
ddev exec php -d memory_limit=-1 /usr/local/bin/composer update
```

### Dependency Conflicts

```bash
# Warum wird Package nicht installiert?
ddev composer why-not drupal/module 2.0

# Dependency Tree
ddev composer depends drupal/core
```

### Autoload-Probleme

```bash
# Autoload neu generieren
ddev composer dump-autoload

# Optimiert
ddev composer dump-autoload --optimize
```

---

## Drupal-spezifisch

### White Screen of Death

```bash
# Fehler anzeigen
ddev drush watchdog:show --severity=error

# PHP Errors aktivieren
ddev exec "echo 'ini_set(\"display_errors\", 1);' >> web/sites/default/settings.local.php"
```

### Cache-Probleme

```bash
# Alle Caches leeren
ddev drush cr

# Spezifischen Cache
ddev drush cc render
ddev drush cc views

# Twig Cache
rm -rf web/sites/default/files/php
```

### Config Import Fehler

```bash
# Config Status
ddev drush config:status

# Einzelne Config importieren
ddev drush config:import --partial --source=config/sync

# Config Override prüfen
ddev drush config:get system.site
```

---

## Logging

### Drupal Logs

```bash
# Watchdog
ddev drush watchdog:show

# Live Tail
ddev drush watchdog:tail

# Nur Errors
ddev drush watchdog:show --severity=error
```

### Container Logs

```bash
# Web Container
ddev logs -f

# Alle Container
ddev logs -f --all
```

### PHP Error Log

```bash
ddev exec tail -f /var/log/php-fpm.log
```
