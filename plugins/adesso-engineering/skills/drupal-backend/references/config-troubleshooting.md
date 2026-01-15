# Config Troubleshooting Reference

## Common Errors & Solutions

### "Entities exist with a conflicting UUID"

**Cause:** Entity in database has different UUID than config file.

**Solution:**
```bash
# Find database UUID
ddev drush sqlq "SELECT uuid FROM config WHERE name = '<config_name>'"

# Option 1: Update config file UUID
# Edit the YAML file to match database UUID

# Option 2: Delete database config (destructive)
ddev drush cdel <config_name>
ddev drush cim -y
```

---

### "The referenced entity (X) does not exist"

**Cause:** Config depends on entity that doesn't exist.

**Solutions:**
```bash
# Find missing dependency
ddev drush config:get <config_name> dependencies

# Option 1: Import in correct order
ddev drush cim --partial -y
ddev drush cim -y

# Option 2: Remove dependency from config file
# Edit YAML, remove from dependencies section
```

---

### "Configuration objects have unexpected keys"

**Cause:** Schema mismatch or invalid keys.

**Solution:**
```bash
# Check schema
ddev drush config:inspect <config_name>

# Remove unexpected keys from YAML
# Or update schema if key is valid
```

---

### "Cannot import X because it is provided by module Y"

**Cause:** Core/contrib config in sync directory.

**Solution:**
```bash
# Remove from sync, let module provide it
rm config/sync/<config_name>.yml
ddev drush cim -y
```

---

### Config Not Applying

**Cause:** Settings.php override or cache.

**Check:**
```bash
# See active value
ddev drush config:get <config_name> <key>

# Check for overrides
ddev drush config:get <config_name> --include-overridden

# Clear cache
ddev drush cr
```

---

## Diagnostic Commands

### Config Status

```bash
# Overview of differences
ddev drush config:status

# Detailed output
ddev drush config:status --format=list
```

### View Diff

```bash
# See specific differences
ddev drush config:diff <config_name>
```

### Export Single Item

```bash
# View what would be exported
ddev drush config:get <config_name> --format=yaml
```

### List All Config

```bash
# All config names
ddev drush config:list

# Filtered
ddev drush config:list | grep <pattern>
```

---

## Reset Strategies

### Full Reset to Files

⚠️ **Destructive** - loses database-only config

```bash
ddev drush config:import --source=config/sync -y
```

### Full Reset to Database

```bash
ddev drush config:export --destination=config/sync -y
```

### Single Item Reset

```bash
# To file version
ddev drush config:import --partial --source=config/sync -y

# To database version
ddev drush config:export <config_name> --destination=config/sync
```

---

## Prevention Strategies

### Before Deployment

```bash
# Always check status first
ddev drush config:status

# Review differences
ddev drush config:diff system.site

# Test import on staging
```

### During Development

```bash
# Export frequently
ddev drush cex -y

# Commit config changes
git add config/
git commit -m "Config: description"
```

### Environment Sync

```bash
# Pull database from production
ddev pull <provider>

# Import local config
ddev drush cim -y

# Verify
ddev drush config:status
```

---

## UUID Management

### Find UUID

```bash
# In file
head -5 config/sync/<config_name>.yml

# In database
ddev drush sqlq "SELECT uuid FROM config WHERE name = '<config_name>'"
```

### Regenerate UUID

```bash
# Generate new UUID
ddev drush php:eval "print \Drupal::service('uuid')->generate();"

# Update file with new UUID
```

---

## Module Dependency Issues

### Module Not Enabled

```bash
# Error: X depends on module Y

# Enable module first
ddev drush en <module> -y
ddev drush cim -y
```

### Module Removed

```bash
# If module was removed but config remains
ddev drush cdel <config_name>

# Or remove from core.extension manually
# Then import
```

---

## Database Investigation

### Check Config Table

```bash
# See all config
ddev drush sqlq "SELECT name FROM config ORDER BY name"

# Check specific
ddev drush sqlq "SELECT data FROM config WHERE name = '<config_name>'"
```

### Check Key-Value Store

```bash
# Config overrides stored here
ddev drush sqlq "SELECT * FROM key_value WHERE collection = 'config.overrides'"
```
