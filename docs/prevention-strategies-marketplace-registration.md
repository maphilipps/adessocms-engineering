# Prevention Strategies: Marketplace Plugin Registration

## Problem Statement

New plugins added to a Claude Code marketplace are not automatically discoverable—they must be manually registered in `marketplace.json`. Without this registration, plugins won't appear when users search or browse the marketplace, leading to:

- Incomplete marketplace discovery experience
- Hidden/undiscoverable plugins despite being in the repository
- Manual tracking overhead for plugin authors
- Risk of unregistered plugins in production

## Prevention Strategy 1: Pre-Commit Checklist for New Plugins

### Checklist Template

When creating a new plugin, developers MUST complete this checklist BEFORE committing:

```markdown
## New Plugin Registration Checklist

- [ ] **Plugin directory created** at `/plugins/{plugin-name}/`
- [ ] **Plugin metadata defined** in `/plugins/{plugin-name}/.claude-plugin/plugin.json`
  - [ ] Plugin name matches the directory name (lowercase, hyphenated)
  - [ ] Version set to `0.1.0` (initial version)
  - [ ] Description is clear and complete
  - [ ] Author information included
  - [ ] Keywords/tags defined
- [ ] **Marketplace entry added** to `/.claude-plugin/marketplace.json`
  - [ ] Plugin name added to `plugins[]` array
  - [ ] Description matches plugin.json (optional: can be more marketing-focused)
  - [ ] Version matches plugin.json
  - [ ] Author information matches or references plugin.json
  - [ ] Source path is correct: `./plugins/{plugin-name}`
  - [ ] Tags included for discoverability
- [ ] **Name consistency verified**
  - [ ] Directory name: `{plugin-name}/`
  - [ ] plugin.json `name` field: `{plugin-name}`
  - [ ] marketplace.json `name` field: `{plugin-name}`
  - [ ] All names are identical (case-sensitive)
- [ ] **Both files committed together** in a single commit
  - [ ] Commit message references plugin name: `feat: Add {plugin-name} plugin`
  - [ ] No plugin.json without marketplace.json entry
- [ ] **Documentation created**
  - [ ] `/plugins/{plugin-name}/README.md` exists
  - [ ] Plugin purpose clearly described
  - [ ] Installation instructions included
```

### Implementation Pattern

When creating a new plugin, use this workflow:

```bash
# 1. Create plugin directory structure
mkdir -p plugins/{new-plugin}/.claude-plugin
mkdir -p plugins/{new-plugin}/agents
mkdir -p plugins/{new-plugin}/commands
mkdir -p plugins/{new-plugin}/skills

# 2. Create plugin.json
cat > plugins/{new-plugin}/.claude-plugin/plugin.json << 'EOF'
{
  "name": "{new-plugin}",
  "version": "0.1.0",
  "description": "...",
  "author": {
    "name": "...",
    "email": "..."
  },
  "homepage": "...",
  "keywords": [...]
}
EOF

# 3. Create README.md
cat > plugins/{new-plugin}/README.md << 'EOF'
# {new-plugin}

[Plugin description]

## Installation

/plugins install {new-plugin}

## Components

- Agents: X
- Commands: Y
- Skills: Z
EOF

# 4. Add to marketplace.json (see Strategy 2)

# 5. Commit both files
git add -A
git commit -m "feat: Add {new-plugin} plugin"
```

### Verification Steps

After creating a new plugin:

1. **Check directory exists:** `ls -d plugins/{new-plugin}/`
2. **Verify plugin.json syntax:** `jq . plugins/{new-plugin}/.claude-plugin/plugin.json`
3. **Verify marketplace.json syntax:** `jq . .claude-plugin/marketplace.json`
4. **Verify names match:** All three locations use identical `{new-plugin}` name
5. **Verify source path:** Source in marketplace.json points to correct directory

---

## Prevention Strategy 2: Marketplace Registration Template

### Structured Entry Template

When adding a plugin to `marketplace.json`, use this exact structure:

```json
{
  "name": "{new-plugin}",
  "description": "Clear, discoverable description (50-150 chars)",
  "version": "0.1.0",
  "author": {
    "name": "Author Name",
    "url": "https://github.com/username",
    "email": "author@example.com"
  },
  "homepage": "https://github.com/username/repo",
  "tags": ["tag1", "tag2", "tag3"],
  "source": "./plugins/{new-plugin}"
}
```

### Mandatory Fields Validation

Every marketplace.json entry MUST have:

| Field | Type | Required | Notes |
|-------|------|----------|-------|
| `name` | string | ✓ | Must match directory name exactly |
| `description` | string | ✓ | Searchable, includes key features |
| `version` | string | ✓ | Must match plugin.json version |
| `author` | object | ✓ | At minimum: `name` and `email` |
| `tags` | array | ✓ | 3-5 searchable keywords |
| `source` | string | ✓ | Relative path: `./plugins/{name}` |
| `homepage` | string | ✗ | Recommended for discoverability |

### marketplace.json Structure Rules

```json
{
  "name": "adessocms-marketplace",
  "owner": { "name": "...", "url": "..." },
  "metadata": {
    "description": "...",
    "version": "X.X.X"
  },
  "plugins": [
    { /* plugin entry 1 */ },
    { /* plugin entry 2 */ },
    { /* plugin entry N */ }
  ]
}
```

**RULES:**
- All plugins in `plugins[]` array
- Plugins sorted alphabetically by name
- Entries must be valid JSON
- No duplicate plugin names
- All source paths must exist in filesystem

---

## Prevention Strategy 3: Automated Validation Script

### Overview

A shell script that compares registered plugins vs. actual plugin directories, catching discrepancies before commit.

### Script: `scripts/validate-marketplace.sh`

```bash
#!/bin/bash

set -e

MARKETPLACE_FILE="./.claude-plugin/marketplace.json"
PLUGINS_DIR="./plugins"
ERRORS=0

echo "Validating marketplace plugin registration..."
echo "================================================"

# Check if marketplace.json exists
if [[ ! -f "$MARKETPLACE_FILE" ]]; then
  echo "ERROR: marketplace.json not found at $MARKETPLACE_FILE"
  exit 1
fi

# Get all registered plugin names from marketplace.json
REGISTERED_PLUGINS=$(jq -r '.plugins[].name' "$MARKETPLACE_FILE" 2>/dev/null || true)

# Get all actual plugin directories
ACTUAL_PLUGINS=$(find "$PLUGINS_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null | sort)

echo
echo "Registered plugins in marketplace.json:"
echo "$REGISTERED_PLUGINS" | nl
echo

echo "Actual plugin directories:"
echo "$ACTUAL_PLUGINS" | nl
echo

# Check for unregistered plugins (directories without marketplace.json entry)
echo "Checking for unregistered plugins..."
for plugin_dir in $ACTUAL_PLUGINS; do
  if ! echo "$REGISTERED_PLUGINS" | grep -q "^${plugin_dir}$"; then
    echo "  ⚠️  UNREGISTERED: $plugin_dir"
    echo "     Location: $PLUGINS_DIR/$plugin_dir"
    echo "     Action: Add entry to marketplace.json"
    ((ERRORS++))
  else
    echo "  ✓ $plugin_dir"
  fi
done

echo

# Check for orphaned entries (marketplace.json entries without directories)
echo "Checking for orphaned marketplace entries..."
for plugin_name in $REGISTERED_PLUGINS; do
  if [[ ! -d "$PLUGINS_DIR/$plugin_name" ]]; then
    echo "  ⚠️  ORPHANED: $plugin_name"
    echo "     Action: Remove from marketplace.json or create plugin directory"
    ((ERRORS++))
  fi
done

echo

# Validate each registered plugin has required files
echo "Validating plugin metadata files..."
for plugin_name in $REGISTERED_PLUGINS; do
  plugin_path="$PLUGINS_DIR/$plugin_name"
  plugin_json="$plugin_path/.claude-plugin/plugin.json"
  readme="$plugin_path/README.md"

  if [[ ! -f "$plugin_json" ]]; then
    echo "  ✗ $plugin_name: Missing plugin.json"
    ((ERRORS++))
  else
    # Verify name consistency
    json_name=$(jq -r '.name' "$plugin_json" 2>/dev/null)
    if [[ "$json_name" != "$plugin_name" ]]; then
      echo "  ✗ $plugin_name: Name mismatch in plugin.json (shows: $json_name)"
      ((ERRORS++))
    else
      echo "  ✓ $plugin_name (metadata OK)"
    fi
  fi

  if [[ ! -f "$readme" ]]; then
    echo "  ⚠️  $plugin_name: Missing README.md (recommended)"
  fi
done

echo
echo "================================================"

if [[ $ERRORS -eq 0 ]]; then
  echo "✓ All plugins properly registered!"
  exit 0
else
  echo "✗ Found $ERRORS issue(s) that must be fixed before commit"
  exit 1
fi
```

### Usage

```bash
# Manual validation
./scripts/validate-marketplace.sh

# As part of CI/CD
if ! ./scripts/validate-marketplace.sh; then
  echo "Validation failed. Fix issues before pushing."
  exit 1
fi
```

### Validation Checks Performed

1. ✓ marketplace.json file exists and is valid JSON
2. ✓ All plugin directories in `/plugins` are registered in marketplace.json
3. ✓ No orphaned entries in marketplace.json without corresponding directories
4. ✓ Each registered plugin has a `plugin.json` file
5. ✓ Plugin names are consistent across files (directory, plugin.json, marketplace.json)
6. ✓ Each plugin has a README.md (recommended)

---

## Prevention Strategy 4: Git Pre-Commit Hook

### Overview

A git hook that runs automatically before commits, preventing unregistered plugins from being committed.

### Hook File: `.git/hooks/pre-commit`

```bash
#!/bin/bash

# Marketplace Plugin Registration Validator
# Prevents commits with unregistered plugins

MARKETPLACE_FILE="./.claude-plugin/marketplace.json"
PLUGINS_DIR="./plugins"

# Only run this hook if we're working with plugins
if [[ ! -d "$PLUGINS_DIR" ]]; then
  exit 0
fi

# Check if validation script exists
VALIDATE_SCRIPT="./scripts/validate-marketplace.sh"
if [[ ! -f "$VALIDATE_SCRIPT" ]]; then
  exit 0
fi

# Run validation
echo "Running marketplace registration validation..."
if ! bash "$VALIDATE_SCRIPT"; then
  echo ""
  echo "❌ Pre-commit hook failed: Unregistered plugins detected"
  echo ""
  echo "To fix:"
  echo "  1. Add the plugin to ./.claude-plugin/marketplace.json"
  echo "  2. Ensure plugin.json exists and names match"
  echo "  3. Run: ./scripts/validate-marketplace.sh"
  echo "  4. Try commit again"
  echo ""
  echo "If you want to skip this hook: git commit --no-verify"
  echo ""
  exit 1
fi

exit 0
```

### Hook Installation

```bash
# 1. Create hooks directory if needed
mkdir -p .git/hooks

# 2. Copy/create the pre-commit hook
cp .git/hooks/pre-commit .git/hooks/pre-commit.bak  # backup
# [Copy hook script above to .git/hooks/pre-commit]

# 3. Make executable
chmod +x .git/hooks/pre-commit

# 4. Test it
git add .
git commit -m "test: testing pre-commit hook"  # Should pass or fail appropriately
```

### Hook Bypass (Emergency Only)

```bash
# Skip hook for this commit
git commit --no-verify

# Disable hook temporarily
chmod -x .git/hooks/pre-commit

# Re-enable hook
chmod +x .git/hooks/pre-commit
```

---

## Prevention Strategy 5: Documentation Pattern for /compound Workflow

### When Creating `/compound` Documentation for New Plugins

Every time a plugin is documented via `/compound`, include this required section:

#### Required: Marketplace Registration Step

```markdown
## Marketplace Registration

When adding a new plugin to a marketplace, **ALWAYS** register it in the marketplace's `marketplace.json`:

1. **Identify marketplace root** (location of `/.claude-plugin/marketplace.json`)
2. **Add entry to `plugins[]` array:**

```json
{
  "name": "{plugin-name}",
  "description": "...",
  "version": "0.1.0",
  "author": { "name": "...", "email": "..." },
  "tags": [...],
  "source": "./plugins/{plugin-name}"
}
```

3. **Verify consistency:**
   - Directory name: `/plugins/{plugin-name}/`
   - plugin.json `name`: `{plugin-name}`
   - marketplace.json `name`: `{plugin-name}`

4. **Commit both files together:**
   ```bash
   git add plugins/{plugin-name}/.claude-plugin/plugin.json
   git add .claude-plugin/marketplace.json
   git commit -m "feat: Register {plugin-name} plugin in marketplace"
   ```

5. **Validate with script:**
   ```bash
   ./scripts/validate-marketplace.sh
   ```
```

### Integration with /compound Workflow

When using `/acms-compound` or similar documentation commands:

```markdown
## When creating new plugins:

**BEFORE** compounding documentation:
- [ ] Plugin directory created with `.claude-plugin/plugin.json`
- [ ] Plugin registered in marketplace.json
- [ ] Scripts/validate-marketplace.sh passes

**AFTER** compounding documentation:
- [ ] Include "Marketplace Registration" section in the document
- [ ] Link to this prevention strategies document
- [ ] Update plugin README with marketplace registration info
```

---

## Prevention Strategy 6: Code Review Checklist

### Code Review Template for Plugin PRs

When reviewing any PR that adds or modifies plugins:

```markdown
## Plugin Registration Checklist

### Plugin Structure
- [ ] Plugin has directory at `/plugins/{plugin-name}/`
- [ ] Plugin has `.claude-plugin/plugin.json` file
- [ ] plugin.json is valid JSON with required fields
- [ ] Plugin has README.md with clear description

### Marketplace Registration
- [ ] Entry added to `/.claude-plugin/marketplace.json`
- [ ] Plugin name consistent across:
  - [ ] Directory: `/plugins/{name}/`
  - [ ] plugin.json: `"name": "{name}"`
  - [ ] marketplace.json: `"name": "{name}"`
- [ ] marketplace.json entry is valid JSON
- [ ] marketplace.json still valid after changes
- [ ] Source path correct: `"./plugins/{name}"`

### Metadata Consistency
- [ ] Version in plugin.json matches marketplace.json
- [ ] Description is present in both files
- [ ] Author information is consistent
- [ ] Tags/keywords appropriate and searchable

### Testing
- [ ] Validation script passes: `./scripts/validate-marketplace.sh`
- [ ] Plugin can be discovered in marketplace
- [ ] Plugin can be installed successfully

### Documentation
- [ ] Plugin README is complete and clear
- [ ] Installation instructions included
- [ ] Component counts documented (agents, commands, skills)
```

---

## Prevention Strategy 7: Marketplace Metadata Standards

### Standardized Description Format

Make descriptions consistent and discoverable:

```
{component-count} agents, {command-count} commands, {skill-count} skills - {primary-use-case}.

Examples:
- "29 agents, 21 commands, 17 skills for Drupal, Twig, Tailwind v4, SDC, and frontend excellence."
- "7 commands, 19 agents, 5 skills - from company research through conversion optimization."
```

### Tag Strategy

Tags should be:
- **Lowercase, hyphenated** (e.g., `drupal-11`, not `Drupal 11`)
- **Specific, searchable** (e.g., `twig` not `template`)
- **Include primary domain** (e.g., `drupal`, `marketing`, `design`)
- **Include capabilities** (e.g., `ai-powered`, `code-review`, `automation`)
- **3-5 tags per plugin** (optimal for discoverability)

Example tags:
```json
"tags": [
  "drupal",
  "drupal-11",
  "ai-powered",
  "code-review",
  "workflow-automation"
]
```

### Homepage/Repository Standards

Always include:
- **homepage:** URL where users can learn more (typically GitHub repo)
- **repository:** Full git repository URL (if different from homepage)

---

## Prevention Strategy 8: Version Synchronization

### Version Management Rules

Keep versions synchronized across files:

```
plugin.json:          { "version": "1.2.3" }
marketplace.json:     { "version": "1.2.3" }  ← Must always match
CHANGELOG.md:         Updated with version 1.2.3 entries
```

### Version Bump Checklist

When releasing a new plugin version:

- [ ] Update `/plugins/{plugin}/.claude-plugin/plugin.json` → new version
- [ ] Update `/.claude-plugin/marketplace.json` → same version
- [ ] Update `/plugins/{plugin}/CHANGELOG.md` → document changes
- [ ] Commit with message: `chore: Bump {plugin-name} to X.Y.Z`
- [ ] Tag release: `git tag {plugin-name}-vX.Y.Z`

---

## Implementation Roadmap

### Phase 1: Foundation (Weeks 1-2)
1. Create validation script: `scripts/validate-marketplace.sh`
2. Create this prevention strategies document
3. Update plugin creation template in project docs

### Phase 2: Automation (Weeks 2-3)
1. Install pre-commit hook in `.git/hooks/pre-commit`
2. Test hook with sample plugin creation
3. Document hook in README.md

### Phase 3: Process Integration (Week 3-4)
1. Update `/compound` workflow documentation
2. Add code review checklist to PR template
3. Create plugin creation guide linking to all strategies

### Phase 4: Ongoing (Continuous)
1. Run validation script in CI/CD pipeline
2. Review against checklist during code reviews
3. Update strategies based on new issues discovered

---

## Quick Reference Checklist

### For Plugin Creators

```bash
# Before creating plugin
□ Read: plugin creation guide + this prevention strategies doc

# While creating plugin
□ Create directory: /plugins/{name}/
□ Create plugin.json in /{plugin}/.claude-plugin/
□ Create README.md in /{plugin}/
□ Add entry to /.claude-plugin/marketplace.json
□ Verify names match everywhere
□ Run: ./scripts/validate-marketplace.sh

# Before committing
□ Pre-commit hook passes
□ Both plugin.json + marketplace.json files staged
□ Commit message references plugin name
□ Push and verify in marketplace
```

### For Code Reviewers

```bash
□ Check plugin structure exists
□ Verify marketplace.json entry created
□ Validate names consistent across files
□ Run: ./scripts/validate-marketplace.sh
□ Check metadata is complete
□ Verify version synchronization
```

---

## Conclusion

This comprehensive prevention strategy addresses the root cause of unregistered plugins through:

1. **Human process** (checklists, templates, workflows)
2. **Automation** (validation script, pre-commit hook)
3. **Documentation** (clear standards, integration points)
4. **Code review** (systematic checks during PR review)
5. **Ongoing maintenance** (version sync, metadata standards)

By implementing these strategies in order, plugin registration becomes an **automatic, verified part of the plugin creation workflow** rather than an optional manual step.
