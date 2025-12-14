# Prevention Strategies Summary: Marketplace Plugin Registration

## The Problem

When new plugins are added to the Claude Code marketplace, they are **not automatically discoverable**. A manual registration step in `marketplace.json` is required. Without this:

- Plugins exist in the repository but users cannot find them
- Discovery becomes a manual process, prone to errors
- New plugins may be forgotten or misregistered
- Plugin metadata can become inconsistent across files

## The Solution: 8-Layer Prevention Strategy

This solution implements multiple layers of prevention, from automated validation to documentation standards.

### Layer 1: Automation - Validation Script

**File:** `scripts/validate-marketplace.sh`

- **What it does:** Compares plugin directories vs marketplace.json entries
- **When it runs:** Manual execution, CI/CD, pre-commit hook
- **What it checks:**
  - All plugin directories are registered in marketplace.json
  - All marketplace.json entries have corresponding directories
  - Plugin metadata files (plugin.json) exist and are valid
  - Plugin names are consistent across all files
  - No duplicate entries in marketplace.json

**Usage:**
```bash
./scripts/validate-marketplace.sh
```

### Layer 2: Automation - Pre-Commit Hook

**File:** `.git/hooks/pre-commit`

- **What it does:** Prevents commits with unregistered/misconfigured plugins
- **When it runs:** Automatically before every commit
- **What it prevents:**
  - Committing new plugins without marketplace.json registration
  - Committing inconsistent plugin metadata
  - Committing invalid JSON in marketplace.json

**How it works:**
```bash
# Automatic - you don't need to do anything
git add .
git commit -m "..."  # ← Pre-commit hook runs automatically
```

**Override (if needed):**
```bash
git commit --no-verify  # Bypass hook (use sparingly!)
```

### Layer 3: Human Process - Creation Checklist

**File:** `docs/new-plugin-creation-checklist.md`

- **What it is:** Step-by-step guide for creating new plugins
- **When to use:** Every time you create a plugin
- **What it ensures:**
  - Consistent directory structure
  - All required metadata files created
  - Plugin registration happens at the right time
  - Proper commit structure

**Key steps:**
1. Create plugin directory structure
2. Create plugin.json with all metadata
3. Create README.md
4. Create plugin content (agents, commands, skills)
5. Register in marketplace.json
6. Run validation script
7. Commit both files together
8. Verify discoverability

### Layer 4: Human Process - Code Review

**What:** During PR review for new plugins

**Checklist:**
```markdown
## Plugin Registration Checklist

### Plugin Structure
- [ ] Plugin directory exists at `/plugins/{name}/`
- [ ] `.claude-plugin/plugin.json` file exists and is valid
- [ ] README.md exists with clear description

### Marketplace Registration
- [ ] Entry added to `/.claude-plugin/marketplace.json`
- [ ] Plugin name consistent across all files
- [ ] marketplace.json is valid JSON
- [ ] Source path correct: `./plugins/{name}`

### Metadata
- [ ] Version in plugin.json matches marketplace.json
- [ ] Description present in both files
- [ ] Tags/keywords included for discoverability

### Testing
- [ ] `./scripts/validate-marketplace.sh` passes
- [ ] Plugin can be discovered in marketplace
- [ ] Plugin can be installed successfully
```

### Layer 5: Documentation - Integration with /compound

**When:** Creating documentation for new plugins

**Required section:**
Every `/compound` document for a new plugin must include:

```markdown
## Marketplace Registration

When adding a new plugin to a marketplace, **ALWAYS** register it in `marketplace.json`:

1. Add entry to `plugins[]` array with all required fields
2. Verify plugin name is consistent everywhere
3. Ensure `source` path is correct: `./plugins/{plugin-name}`
4. Validate with: `./scripts/validate-marketplace.sh`
5. Commit both plugin files and marketplace.json together
```

### Layer 6: Standardization - Metadata Format

**What:** Consistent structure across all plugins

**Standard entry in marketplace.json:**
```json
{
  "name": "{lowercase-hyphenated-name}",
  "description": "{50-150 char description with key features}",
  "version": "X.Y.Z",
  "author": {
    "name": "Author Name",
    "url": "https://github.com/username",
    "email": "author@email.com"
  },
  "homepage": "https://github.com/username/repo",
  "tags": ["tag1", "tag2", "tag3", "tag4", "tag5"],
  "source": "./plugins/{name}"
}
```

**Standard description format:**
```
{count} agents, {count} commands, {count} skills - {primary purpose}.

Example:
"29 agents, 21 commands, 17 skills for Drupal, Twig, Tailwind v4, SDC."
```

### Layer 7: Version Synchronization

**What:** Keeping versions consistent across files

**Rule:** After each update, ensure:
```
plugin.json:      { "version": "1.2.3" }
marketplace.json: { "version": "1.2.3" }  ← Must match
CHANGELOG.md:     Updated with 1.2.3 entries
```

**Workflow:**
```bash
# Update version in both files
# Update CHANGELOG.md
git add plugins/{name}/.claude-plugin/plugin.json
git add ./.claude-plugin/marketplace.json
git add plugins/{name}/CHANGELOG.md
git commit -m "chore: Bump {name} to X.Y.Z"
```

### Layer 8: Integration Points

**Where validation happens:**

1. **Local development:** Pre-commit hook catches issues before commit
2. **Code review:** Reviewers use checklist to verify
3. **CI/CD pipeline:** Validation script can be added to build
4. **Documentation:** New plugins are documented with registration info

## Implementation Timeline

### Phase 1: Foundation (Done)
- [x] Create validation script: `scripts/validate-marketplace.sh`
- [x] Create prevention strategies document
- [x] Create new plugin creation guide
- [x] Create this summary document

### Phase 2: Automation (Ready to Deploy)
- [ ] Install pre-commit hook in `.git/hooks/pre-commit`
- [ ] Test hook with sample commits
- [ ] Document hook in README.md

### Phase 3: Process Integration
- [ ] Update `/compound` workflow to include marketplace registration
- [ ] Add code review checklist to PR template
- [ ] Create plugin creation guide for team

### Phase 4: Ongoing
- [ ] Run validation in CI/CD pipeline
- [ ] Use checklist during code reviews
- [ ] Update strategies based on issues discovered

## Key Files

| File | Purpose |
|------|---------|
| `scripts/validate-marketplace.sh` | Automated validation script |
| `.git/hooks/pre-commit` | Pre-commit hook that prevents bad commits |
| `docs/prevention-strategies-marketplace-registration.md` | Comprehensive prevention strategy guide |
| `docs/new-plugin-creation-checklist.md` | Step-by-step plugin creation guide |
| `docs/PREVENTION-SUMMARY.md` | This file - quick reference |

## Quick Start

### For Plugin Creators

1. **Creating a new plugin:**
   - Follow: `docs/new-plugin-creation-checklist.md`
   - Run: `./scripts/validate-marketplace.sh` before committing
   - Commit both plugin files and marketplace.json together

2. **If validation fails:**
   - Read the error message carefully
   - Most common issues are name mismatches
   - Run validation script again to verify fix

### For Code Reviewers

1. **Reviewing a plugin PR:**
   - Use the code review checklist from this document
   - Run: `./scripts/validate-marketplace.sh` on the branch
   - Verify plugin can be installed

2. **If issues found:**
   - Request changes to fix unregistered/misconfigured plugins
   - Require validation script to pass before merge

### For CI/CD Integration

```bash
#!/bin/bash
# Add to CI/CD pipeline

echo "Validating marketplace plugins..."
if ! ./scripts/validate-marketplace.sh; then
  echo "Validation failed - marketplace is misconfigured"
  exit 1
fi

echo "All marketplace validations passed!"
```

## Common Issues & Solutions

### "Unregistered plugin" error

**Cause:** Plugin directory exists but marketplace.json entry is missing

**Fix:**
1. Add entry to `/.claude-plugin/marketplace.json`
2. Ensure `source` path is correct
3. Run validation script

### "Name mismatch" error

**Cause:** Plugin name differs across files

**Fix:**
1. Check directory name: `/plugins/{name}/`
2. Check plugin.json: `"name": "{name}"`
3. Check marketplace.json: `"name": "{name}"`
4. Make all three identical (case-sensitive)

### "Invalid JSON" error

**Cause:** Syntax error in plugin.json or marketplace.json

**Fix:**
```bash
# Check syntax
jq . ./.claude-plugin/marketplace.json
# Fix reported issues
# Re-run validation
```

## Benefits

This multi-layer strategy provides:

1. **Automation:** Script catches errors automatically
2. **Prevention:** Pre-commit hook prevents bad commits
3. **Consistency:** Standardized metadata format across all plugins
4. **Discoverability:** Proper registration ensures users can find plugins
5. **Maintainability:** Clear documentation for ongoing updates
6. **Confidence:** Multiple checkpoints catch issues early

## Success Metrics

You'll know this is working when:

- ✓ All new plugins are properly registered on first attempt
- ✓ No unregistered plugins exist in the repository
- ✓ Plugin metadata is consistent across files
- ✓ Plugin discoverability works as expected
- ✓ Code reviews include marketplace registration checks
- ✓ Pre-commit hook catches and prevents registration errors

## References

- Full prevention strategies: `docs/prevention-strategies-marketplace-registration.md`
- Plugin creation guide: `docs/new-plugin-creation-checklist.md`
- Validation script: `scripts/validate-marketplace.sh`
- Pre-commit hook: `.git/hooks/pre-commit`
