---
title: "Claude Code Marketplace Plugin Registration"
created: 2025-12-14
category: integration-issues
tags:
  - plugin-installation
  - marketplace-registry
  - developer-workflow
  - claude-code
severity: high
component: tooling/plugin-system
symptoms:
  - Plugin files committed but not discoverable
  - Valid plugin.json ignored by CLI
  - Plugin exists in filesystem but won't install
root_cause: Plugin not registered in marketplace.json
solution_summary: Add plugin entry to marketplace's .claude-plugin/marketplace.json
---

# Claude Code Marketplace Plugin Registration

## Problem

A new Claude Code plugin was committed and pushed to a marketplace repository, but couldn't be installed via the CLI. The plugin directory existed with a valid `.claude-plugin/plugin.json`, yet the plugin wasn't discoverable.

## Symptoms

- `git status` shows plugin files are committed
- Plugin directory exists: `plugins/[plugin-name]/`
- Plugin has valid `.claude-plugin/plugin.json`
- `/plugin install [plugin-name]` fails or doesn't find the plugin
- Plugin doesn't appear in marketplace listing

## Root Cause

The plugin was not registered in the marketplace's `marketplace.json` file.

**Key insight:** A marketplace has TWO configuration files:
1. **Per-plugin:** `plugins/[name]/.claude-plugin/plugin.json` - Plugin metadata
2. **Marketplace registry:** `.claude-plugin/marketplace.json` - Catalog of all available plugins

Even if a plugin exists in the repository, it **must be declared** in `marketplace.json` to be discoverable.

## Solution

### 1. Locate marketplace.json

```
~/.claude/plugins/marketplaces/[marketplace-name]/.claude-plugin/marketplace.json
```

### 2. Understand the structure

```json
{
  "name": "marketplace-name",
  "owner": {
    "name": "Owner Name",
    "url": "https://github.com/username"
  },
  "metadata": {
    "description": "Marketplace description",
    "version": "1.0.0"
  },
  "plugins": [
    {
      "name": "plugin-name",
      "description": "What this plugin does",
      "version": "x.y.z",
      "author": {...},
      "tags": ["tag1", "tag2"],
      "source": "./plugins/plugin-name"
    }
  ]
}
```

### 3. Add the new plugin entry

```json
{
  "name": "your-plugin-name",
  "description": "Clear description for marketplace listing",
  "version": "1.0.0",
  "author": {
    "name": "Your Name",
    "email": "your.email@example.com"
  },
  "tags": ["relevant", "searchable", "tags"],
  "source": "./plugins/your-plugin-name"
}
```

**Critical requirements:**

| Field | Requirement |
|-------|-------------|
| `name` | Must match directory name AND plugin.json name |
| `version` | Should match plugin.json version |
| `source` | Relative path from marketplace root |

### 4. Commit both files together

```bash
git add .claude-plugin/marketplace.json
git add plugins/your-plugin-name/
git commit -m "feat: Add your-plugin-name to marketplace"
git push
```

### 5. Update local marketplace (user side)

```
/plugin marketplace update [marketplace-name]
```

## Working Example

From `adessocms-marketplace/.claude-plugin/marketplace.json`:

```json
{
  "name": "adessocms-marketplace",
  "plugins": [
    {
      "name": "adessocms-engineering",
      "description": "AI-powered Drupal 11 development tools...",
      "version": "1.11.0",
      "source": "./plugins/adessocms-engineering"
    },
    {
      "name": "adessocms-marketing",
      "description": "Marketing-Analyse für Unternehmen...",
      "version": "0.1.0",
      "source": "./plugins/adessocms-marketing"
    }
  ]
}
```

## Prevention Checklist

When creating a new plugin:

- [ ] Create plugin directory: `plugins/[name]/`
- [ ] Create `.claude-plugin/plugin.json` with valid metadata
- [ ] **Add entry to marketplace's `.claude-plugin/marketplace.json`**
- [ ] Ensure `name` matches in both files
- [ ] Ensure `version` matches in both files
- [ ] Commit plugin files AND marketplace.json together
- [ ] Push and verify installation works

## Troubleshooting

| Problem | Solution |
|---------|----------|
| Plugin still not visible | Run `/plugin marketplace update [name]` |
| JSON syntax error | Validate marketplace.json with `jq . < marketplace.json` |
| Version mismatch error | Sync version between plugin.json and marketplace.json |
| Plugin shows but won't install | Check plugin.json has all required fields |

## Key Takeaway

The marketplace registry (`marketplace.json`) is the **source of truth** for plugin discoverability. Without an entry in this file, plugins won't be found regardless of whether they exist in the repository.

## Related

- Plugin development: `.claude-plugin/plugin.json` structure
- Marketplace management: `/plugin marketplace` commands
- CLAUDE.md versioning requirements
