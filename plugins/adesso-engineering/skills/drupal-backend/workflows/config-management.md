# Configuration Management

## Required Reading
Before starting, load:
- `../references/config-api.md` - Config fundamentals
- `../references/config-split.md` - Environment splits
- `../references/config-troubleshooting.md` - Common issues

---

## Input Gathering

Ask user:
1. **Operation**: Export, Import, or Troubleshoot?
2. **Scope**: All config or specific items?
3. **Environment**: Development, staging, or production?

---

## Safe Config Export

### Step 1: Check Current Status

```bash
ddev drush config:status
```

Output meanings:
- `Only in sync dir` - Config exists in files but not database
- `Only in DB` - Config exists in database but not files
- `Different` - Config differs between DB and files

### Step 2: Export

```bash
# Export all
ddev drush cex -y

# Export specific
ddev drush config:export --destination=config/sync -y
```

### Step 3: Review Changes

```bash
# Git diff to see changes
git diff config/sync/

# Or specific file
git diff config/sync/<config_name>.yml
```

---

## Safe Config Import

### ⚠️ CRITICAL: Never Blind Import

### Step 1: Check What Will Change

```bash
ddev drush config:status
```

### Step 2: Review Specific Differences

```bash
# See diff for a config item
ddev drush config:diff <config_name>
```

### Step 3: Partial Import (Safer)

```bash
# Import single config
ddev drush config:import --source=config/sync --partial -y

# Import specific item
ddev drush config:set <config_name> <key> <value>
```

### Step 4: Full Import (After Review)

```bash
ddev drush cim -y
```

---

## Config Split

### Setup

```yaml
# config/sync/config_split.config_split.dev.yml
status: true
id: dev
label: Development
folder: ../config/split/dev
module: []
theme: []
graylist: []
blacklist:
  - devel.settings
  - system.logging
```

### Directory Structure

```
config/
├── sync/                    # Shared config
│   └── config_split.config_split.dev.yml
└── split/
    ├── dev/                 # Dev-only config
    │   └── devel.settings.yml
    └── prod/                # Prod-only config
        └── system.performance.yml
```

### Export with Split

```bash
# Export and auto-split
ddev drush cex -y
```

### Import with Split

```bash
# Import respects current split status
ddev drush cim -y
```

---

## Troubleshooting

### UUID Conflicts

**Problem:** "Entities exist with a conflicting UUID"

**Solution:**
```bash
# Find the UUID
ddev drush config:get <config_name> uuid

# Delete the conflicting entity
ddev drush entity:delete <entity_type> <id>

# Or update the UUID in config file
```

### Module Dependencies

**Problem:** Config references non-existent module

**Solution:**
```bash
# Check module status
ddev drush pm:list | grep <module>

# Enable missing module
ddev drush en <module> -y

# Then import
ddev drush cim -y
```

### Entity Dependencies

**Problem:** "The referenced entity (field_storage_config) does not exist"

**Solution:**
```bash
# Import in correct order
ddev drush cim --partial -y
ddev drush cim -y  # Retry full import
```

---

## Ignoring Config

### settings.php

```php
// Ignore site-specific config
$settings['config_exclude_modules'] = ['devel', 'stage_file_proxy'];
```

### Config Ignore Module

```yaml
# config/sync/config_ignore.settings.yml
ignored_config_entities:
  - system.site
  - core.extension
```

---

## Best Practices

1. **Always review before import** - Check `config:status`
2. **Commit after export** - Don't leave uncommitted config
3. **Use Config Split** - Separate environment-specific config
4. **Document overrides** - Comment why config is ignored
5. **Test imports** - Verify on staging before production

---

## Verification

```bash
# After any operation
ddev drush config:status

# Expected output for clean state:
# No differences between DB and sync directory
```

---

## Success Criteria

- [ ] `config:status` shows no unexpected differences
- [ ] Config changes are committed to git
- [ ] Config split working for environment-specific items
- [ ] No UUID or dependency conflicts
