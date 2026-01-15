# Config Split Reference

## Overview

Config Split allows environment-specific configuration. Development modules stay in dev, performance settings stay in prod.

---

## Setup

### Install Module

```bash
ddev composer require drupal/config_split
ddev drush en config_split -y
```

### Directory Structure

```
config/
├── sync/                       # Shared config
│   ├── system.site.yml
│   ├── config_split.config_split.dev.yml
│   └── config_split.config_split.prod.yml
└── split/
    ├── dev/                    # Dev-only
    │   ├── devel.settings.yml
    │   └── system.logging.yml
    └── prod/                   # Prod-only
        └── system.performance.yml
```

---

## Creating Splits

### Development Split

```yaml
# config/sync/config_split.config_split.dev.yml
uuid: <generated>
langcode: en
status: true
dependencies: {}
id: dev
label: Development
folder: ../config/split/dev
module:
  devel: 0
  stage_file_proxy: 0
  webprofiler: 0
theme: {}
blacklist:
  - devel.settings
  - stage_file_proxy.settings
  - system.logging
graylist: []
weight: 0
```

### Production Split

```yaml
# config/sync/config_split.config_split.prod.yml
uuid: <generated>
langcode: en
status: false
dependencies: {}
id: prod
label: Production
folder: ../config/split/prod
module: {}
theme: {}
blacklist:
  - system.performance
graylist: []
weight: 0
```

---

## Activation

### In settings.php

```php
// settings.local.php (not in repo)
$config['config_split.config_split.dev']['status'] = TRUE;
$config['config_split.config_split.prod']['status'] = FALSE;

// Or based on environment
switch (getenv('APP_ENV')) {
  case 'development':
    $config['config_split.config_split.dev']['status'] = TRUE;
    $config['config_split.config_split.prod']['status'] = FALSE;
    break;

  case 'production':
    $config['config_split.config_split.dev']['status'] = FALSE;
    $config['config_split.config_split.prod']['status'] = TRUE;
    break;
}
```

---

## Blacklist vs Graylist

### Blacklist
Complete config items that are environment-specific:

```yaml
blacklist:
  - devel.settings              # Entire config
  - system.logging              # Entire config
```

### Graylist
Config that exists everywhere but with different values:

```yaml
graylist:
  - system.performance          # Different values per env
```

---

## Workflow

### Export

```bash
# Export respects active splits
ddev drush cex -y
```

Config goes to:
- Common config → `config/sync/`
- Blacklisted config → `config/split/<split>/`

### Import

```bash
# Import respects active splits
ddev drush cim -y
```

---

## Multiple Environments

### Three-Way Split

```
config/
├── sync/                       # All environments
└── split/
    ├── dev/                    # Local development
    ├── stage/                  # Staging
    └── prod/                   # Production
```

### settings.php

```php
$environment = getenv('APP_ENV') ?: 'development';

$splits = ['dev', 'stage', 'prod'];
foreach ($splits as $split) {
  $config["config_split.config_split.$split"]['status'] = ($split === $environment);
}
```

---

## Common Split Items

### Development

```yaml
module:
  devel: 0
  stage_file_proxy: 0
  webprofiler: 0
  views_ui: 0
  field_ui: 0
blacklist:
  - devel.settings
  - stage_file_proxy.settings
  - system.logging
```

### Production

```yaml
blacklist:
  - system.performance
  - google_analytics.settings
  - recaptcha.settings
```

---

## Troubleshooting

### Split Not Working

1. Check split status:
```bash
ddev drush config:get config_split.config_split.dev status
```

2. Verify settings.php override:
```php
// Ensure this runs AFTER config is loaded
$config['config_split.config_split.dev']['status'] = TRUE;
```

### Config in Wrong Location

```bash
# Move config manually
mv config/sync/devel.settings.yml config/split/dev/

# Re-export
ddev drush cex -y
```

### Conflicts

If same config in multiple splits, weight determines priority (higher = later = wins).

---

## Best Practices

1. **Keep splits minimal** - Only truly environment-specific config
2. **Use graylist sparingly** - Creates merge complexity
3. **Test imports** - Before deploying to production
4. **Document splits** - README explaining what's where
5. **Version control splits** - Include split directories in git
