# Environment Setup Reference

## settings.php Struktur

```
web/sites/default/
├── settings.php          # Haupt-Settings (versioniert)
├── settings.local.php    # Lokale Overrides (nicht versioniert)
└── services.yml          # Service-Konfiguration
```

---

## settings.php Pattern

```php
<?php
// settings.php (in Git)

// Standard Drupal Settings
$databases = [];
$settings['hash_salt'] = getenv('HASH_SALT') ?: 'default-for-dev';
$settings['config_sync_directory'] = '../config/sync';

// Performance Settings (Produktion)
$settings['cache']['bins']['render'] = 'cache.backend.redis';
$settings['cache']['bins']['page'] = 'cache.backend.redis';

// Trusted Host Patterns
$settings['trusted_host_patterns'] = [
  '^.+\.ddev\.site$',
  '^example\.com$',
  '^www\.example\.com$',
];

// Environment Detection
$env = getenv('ENVIRONMENT') ?: 'local';

// Environment-spezifische Settings
if (file_exists($app_root . '/' . $site_path . '/settings.' . $env . '.php')) {
  include $app_root . '/' . $site_path . '/settings.' . $env . '.php';
}

// Lokale Settings (immer zuletzt)
if (file_exists($app_root . '/' . $site_path . '/settings.local.php')) {
  include $app_root . '/' . $site_path . '/settings.local.php';
}
```

---

## settings.local.php (Entwicklung)

```php
<?php
// settings.local.php (NICHT in Git)

// Caching deaktivieren
$settings['cache']['bins']['render'] = 'cache.backend.null';
$settings['cache']['bins']['page'] = 'cache.backend.null';
$settings['cache']['bins']['dynamic_page_cache'] = 'cache.backend.null';

// Twig Debugging
$settings['container_yamls'][] = DRUPAL_ROOT . '/sites/development.services.yml';

// Error Reporting
$config['system.logging']['error_level'] = 'verbose';

// CSS/JS Aggregation aus
$config['system.performance']['css']['preprocess'] = FALSE;
$config['system.performance']['js']['preprocess'] = FALSE;
```

---

## development.services.yml

```yaml
# web/sites/development.services.yml
parameters:
  http.response.debug_cacheability_headers: true
  twig.config:
    debug: true
    auto_reload: true
    cache: false
services:
  cache.backend.null:
    class: Drupal\Core\Cache\NullBackendFactory
```

---

## DDEV settings.ddev.php

```php
<?php
// Automatisch von DDEV erstellt
$host = "db";
$port = 3306;
$driver = "mysql";
$database = "db";
$username = "db";
$password = "db";

$databases['default']['default'] = [
  'database' => $database,
  'username' => $username,
  'password' => $password,
  'host' => $host,
  'port' => $port,
  'driver' => $driver,
  'prefix' => '',
];

$settings['hash_salt'] = 'ddev-hash-salt';
$settings['trusted_host_patterns'] = ['.*'];

// DDEV-spezifisch
$settings['skip_permissions_hardening'] = TRUE;
```

---

## Environment Variables

### .env Pattern

```bash
# .env (nicht in Git)
ENVIRONMENT=local
HASH_SALT=random-string-here
DATABASE_URL=mysql://db:db@db:3306/db

# API Keys
SENDGRID_API_KEY=xxx
SOLR_HOST=solr
```

### In PHP laden

```php
// In settings.php
$settings['hash_salt'] = getenv('HASH_SALT');
```

---

## Config Split Setup

### Module installieren

```bash
ddev composer require drupal/config_split
ddev drush en config_split -y
```

### config_split.config_split.local.yml

```yaml
id: local
label: Local Development
folder: ../config/splits/local
status: true
weight: 0
graylist: {  }
graylist_dependents: true
graylist_skip_equal: true
complete_list:
  - devel.settings
  - devel.toolbar.settings
  - system.logging
conditional_list: {  }
```

### Aktivierung per Environment

```php
// settings.local.php
$config['config_split.config_split.local']['status'] = TRUE;
$config['config_split.config_split.production']['status'] = FALSE;

// settings.production.php
$config['config_split.config_split.local']['status'] = FALSE;
$config['config_split.config_split.production']['status'] = TRUE;
```

---

## Drush Alias

```yaml
# drush/sites/self.site.yml
local:
  root: /var/www/html/web
  uri: https://project.ddev.site

staging:
  host: staging.example.com
  user: deploy
  root: /var/www/drupal/web
  uri: https://staging.example.com

production:
  host: example.com
  user: deploy
  root: /var/www/drupal/web
  uri: https://www.example.com
```

### Nutzung

```bash
ddev drush @staging status
ddev drush sql:sync @production @self
```
