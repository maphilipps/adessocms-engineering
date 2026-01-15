# Contrib Module Management

## Required Reading
Before starting, load:
- `../references/security.md` - Security update practices

---

## Input Gathering

Ask user:
1. **Operation**: Add, Update, or Remove module?
2. **Module name**: Drupal.org machine name
3. **Urgency**: Security update or feature update?

---

## Adding a Module

### Step 1: Check Compatibility

```bash
# Check Drupal version
ddev drush status drupal-version

# Check module requirements on drupal.org
# or via Composer
ddev composer show drupal/<module> --available
```

### Step 2: Require via Composer

```bash
# Add module
ddev composer require drupal/<module>

# With specific version
ddev composer require drupal/<module>:^2.0
```

### Step 3: Enable Module

```bash
ddev drush en <module> -y
```

### Step 4: Export Config

```bash
ddev drush cex -y
```

---

## Updating Modules

### Step 1: Check for Updates

```bash
# All outdated
ddev composer outdated --direct

# Security updates only
ddev composer audit
```

### Step 2: Review Update

```bash
# Check what will change
ddev composer update drupal/<module> --dry-run
```

### Step 3: Update

```bash
# Single module
ddev composer update drupal/<module> --with-all-dependencies

# All Drupal modules
ddev composer update 'drupal/*' --with-all-dependencies
```

### Step 4: Run Updates

```bash
# Database updates
ddev drush updb -y

# Export config changes
ddev drush cex -y

# Clear cache
ddev drush cr
```

### Step 5: Test

- Verify module functionality
- Run automated tests if available
- Check for console errors

---

## Removing a Module

### Step 1: Uninstall First

```bash
# Uninstall (removes config, data)
ddev drush pm:uninstall <module> -y
```

### Step 2: Remove via Composer

```bash
ddev composer remove drupal/<module>
```

### Step 3: Export Config

```bash
ddev drush cex -y
```

---

## Applying Patches

### Method 1: composer-patches Plugin

```json
// composer.json
{
  "extra": {
    "patches": {
      "drupal/<module>": {
        "Description of patch": "https://www.drupal.org/files/issues/2024-01/patch-name.patch"
      }
    }
  }
}
```

Apply:
```bash
ddev composer update drupal/<module>
```

### Method 2: cweagans/composer-patches

```bash
ddev composer require cweagans/composer-patches
```

```json
// composer.json
{
  "extra": {
    "enable-patching": true,
    "patches": {
      "drupal/<module>": {
        "Issue description": "path/to/patch.patch"
      }
    }
  }
}
```

---

## Security Updates

### Step 1: Check for Advisories

```bash
# Composer audit
ddev composer audit

# Drupal security advisories
ddev drush pm:security
```

### Step 2: Prioritize by Severity

| Rating | Action |
|--------|--------|
| Critical | Update immediately |
| Highly Critical | Update within 24 hours |
| Moderately Critical | Update within 1 week |
| Less Critical | Update with next release |

### Step 3: Update and Test

```bash
# Update specific module
ddev composer update drupal/<module> --with-all-dependencies

# Run updates
ddev drush updb -y

# Test critical functionality
```

---

## Drupal 11 Compatibility

### Check Compatibility

```bash
# Upgrade Status module
ddev drush en upgrade_status -y
ddev drush upgrade_status:analyze
```

### Common Issues

| Issue | Solution |
|-------|----------|
| Deprecated API | Check issue queue for D11 patch |
| No D11 release | Check dev version or fork |
| Abandoned module | Find alternative or maintain fork |

---

## Version Constraints

### Constraint Syntax

| Constraint | Meaning |
|------------|---------|
| `^2.0` | ≥2.0.0 and <3.0.0 |
| `~2.1` | ≥2.1.0 and <2.2.0 |
| `2.*` | ≥2.0.0 and <3.0.0 |
| `>=2.0 <3.0` | Explicit range |

### Best Practice

```bash
# Use caret for semver-compliant modules
ddev composer require drupal/module:^2.0
```

---

## Verification

```bash
# Check module status
ddev drush pm:list --status=enabled

# Check for security issues
ddev composer audit

# Verify no update errors
ddev drush updb --no-post-updates -y

# Export config
ddev drush cex -y
```

---

## Success Criteria

- [ ] Module enabled/updated/removed successfully
- [ ] Database updates run without errors
- [ ] Configuration exported
- [ ] No security advisories for installed modules
- [ ] Functionality tested and working
