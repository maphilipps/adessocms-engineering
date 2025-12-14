---
module: Development Workflow
date: 2025-12-14
problem_type: developer_experience
component: tooling
symptoms:
  - New plugin files committed but plugin not discoverable via /plugin install
  - Plugin had valid .claude-plugin/plugin.json but installation failed
  - Plugin existed in filesystem but wasn't registered in marketplace
root_cause: missing_workflow_step
resolution_type: documentation_update
severity: high
tags: [plugin-installation, marketplace-registry, developer-workflow]
---

# Plugin Marketplace Registration - Missing Workflow Step

## Problem Summary

A new Claude Code plugin (`adessocms-marketing`) was developed, committed, and pushed to the repository, but could not be installed using the `/plugin install` command. The plugin files existed in the correct location with valid configuration, yet it was not discoverable by the plugin system.

## Symptoms Observed

1. Plugin files present at `/plugins/adessocms-marketing/`
2. Valid `.claude-plugin/plugin.json` configuration file
3. `/plugin install` command did not discover the plugin
4. No error messages indicating what was wrong
5. Plugin remained invisible to the plugin system

## Root Cause Analysis

The marketplace has a centralized plugin registry at `.claude-plugin/marketplace.json` that lists all available plugins in the marketplace. New plugins must be registered in this manifest file to be discoverable and installable.

Without an entry in `marketplace.json`, the plugin system cannot locate or install the plugin, regardless of whether all other configuration files are valid.

## Investigation Process

1. **Verified git status** - Confirmed files were committed and pushed
2. **Compared configurations** - Examined `adessocms-engineering` plugin's `.claude-plugin/plugin.json` structure against the new plugin
3. **Analyzed working vs broken** - Found that the working plugin appeared in `/plugin list` output
4. **Discovered marketplace registry** - Located `.claude-plugin/marketplace.json` at marketplace root
5. **Identified missing entry** - Confirmed new plugin was not listed in the registry

## Solution Applied

Added the new plugin entry to `.claude-plugin/marketplace.json`:

```json
{
  "name": "adessocms-marketing",
  "description": "Marketing content and campaign management tools for adesso CMS",
  "version": "0.1.0",
  "author": {
    "name": "adesso SE",
    "email": "support@adesso.de"
  },
  "tags": ["marketing", "content", "campaigns"],
  "source": "./plugins/adessocms-marketing"
}
```

## Key Learnings

### Plugin Installation Workflow

For plugins to be discoverable and installable in a Claude Code marketplace:

1. **Create plugin directory** with standard structure under `plugins/`
2. **Create `.claude-plugin/plugin.json`** with plugin metadata
3. **Register in marketplace registry** by adding entry to `.claude-plugin/marketplace.json`
4. **Commit all files** to version control
5. **Push to remote** for availability in CI/CD

The third step is critical and easy to overlook.

### Marketplace Architecture

- `.claude-plugin/marketplace.json` - Central registry listing all available plugins
- `plugins/[plugin-name]/` - Individual plugin directory
- `plugins/[plugin-name]/.claude-plugin/plugin.json` - Plugin configuration
- Each plugin entry requires: `name`, `version`, `description`, `source`

## Prevention Checklist for Future Plugin Development

- [ ] Create plugin in `plugins/[plugin-name]/` directory
- [ ] Create `.claude-plugin/plugin.json` with valid metadata
- [ ] **Add entry to `.claude-plugin/marketplace.json`** before committing
- [ ] Verify entry follows existing plugin format
- [ ] Test `/plugin install` in development before pushing
- [ ] Commit and push all changes
- [ ] Verify plugin appears in `/plugin list` in fresh Claude Code session

## Related Commands

- `/plugin list` - List all available plugins
- `/plugin install [name]` - Install a specific plugin
- `/plugin remove [name]` - Remove an installed plugin
- `/plugin update [name]` - Update to latest version

## Notes

This workflow step should be documented prominently in:
- Plugin development guide
- Marketplace setup documentation
- Pre-commit checklist for plugin contributors

The issue occurred because the workflow step of marketplace registration was not explicitly documented as a requirement, making it easy to miss during plugin development.
