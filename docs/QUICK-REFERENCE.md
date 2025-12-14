# Quick Reference: Plugin Registration Prevention

## TL;DR

When creating a new plugin:

1. Create directory: `plugins/{name}/`
2. Create `plugins/{name}/.claude-plugin/plugin.json`
3. Create `plugins/{name}/README.md`
4. Add entry to `/.claude-plugin/marketplace.json`
5. **Verify names match everywhere** (directory, plugin.json, marketplace.json)
6. Run: `./scripts/validate-marketplace.sh`
7. Commit both files together: `plugins/{name}/` + `marketplace.json`

## Name Consistency Check

Before committing, ensure the plugin name is **identical** in all three places:

```bash
# Directory name
ls plugins/{plugin-name}/

# plugin.json name
grep '"name"' plugins/{plugin-name}/.claude-plugin/plugin.json

# marketplace.json name
grep '"name".*{plugin-name}' ./.claude-plugin/marketplace.json
```

**All three must match exactly (case-sensitive, lowercase, hyphenated).**

## Validation Command

```bash
# Before committing
./scripts/validate-marketplace.sh

# Should output: ✓ All validations passed!
```

## Files to Create

```
plugins/{plugin-name}/
├── .claude-plugin/
│   └── plugin.json          ← REQUIRED
├── agents/
│   └── *.md                 ← At least one
├── commands/
│   └── *.md                 ← At least one
├── skills/
│   └── *.md                 ← Optional
├── docs/
│   └── *.md                 ← Recommended
└── README.md                ← REQUIRED
```

## Marketplace Entry Template

Add to `/.claude-plugin/marketplace.json` plugins array:

```json
{
  "name": "{lowercase-hyphenated}",
  "description": "{50-150 chars with key features}",
  "version": "0.1.0",
  "author": {
    "name": "Your Name",
    "url": "https://github.com/username",
    "email": "author@email.com"
  },
  "homepage": "https://github.com/username/{plugin-name}",
  "tags": ["tag1", "tag2", "tag3", "tag4", "tag5"],
  "source": "./plugins/{plugin-name}"
}
```

## Commit Command

```bash
# Stage both files
git add plugins/{plugin-name}/
git add ./.claude-plugin/marketplace.json

# Commit together
git commit -m "feat: Add {plugin-name} plugin

- {X} agents, {Y} commands, {Z} skills
- Register in marketplace for discoverability
- Complete documentation included"

# Verify
git log -1
```

## Troubleshooting

| Error | Fix |
|-------|-----|
| "Unregistered plugin" | Add entry to marketplace.json |
| "Name mismatch" | Check directory name vs plugin.json vs marketplace.json |
| "Missing plugin.json" | Create `.claude-plugin/plugin.json` |
| "Invalid JSON" | Run `jq . ./.claude-plugin/marketplace.json` |
| "Missing README.md" | Create plugin README.md |

## Quick Links

- **Full Creation Guide:** [New Plugin Creation Checklist](new-plugin-creation-checklist.md)
- **Prevention Strategies:** [Prevention Strategies Guide](prevention-strategies-marketplace-registration.md)
- **Full Summary:** [Prevention Summary](PREVENTION-SUMMARY.md)

## Validation Checks

The `./scripts/validate-marketplace.sh` script verifies:

- ✓ marketplace.json is valid JSON
- ✓ All plugin directories are registered
- ✓ All marketplace entries have directories
- ✓ Plugin.json files exist and are valid
- ✓ Plugin names match across all files
- ✓ No duplicate names in marketplace.json

## Pre-Commit Hook

The `.git/hooks/pre-commit` hook automatically:

- Runs validation script before each commit
- Prevents commits with registration errors
- Can be bypassed with: `git commit --no-verify`

## Version Synchronization

Keep versions consistent:

```json
plugin.json:      "version": "1.2.3"
marketplace.json: "version": "1.2.3"  ← MUST MATCH
CHANGELOG.md:     Updated with 1.2.3 entries
```

## Common Patterns

### Initial plugin version
```json
"version": "0.1.0"
```

### Component count in description
```
"description": "29 agents, 21 commands, 17 skills for Drupal, Twig, Tailwind v4, SDC."
```

### Tag selection
Use 5 tags: primary domain + 3-4 capabilities
```json
"tags": ["drupal", "ai-powered", "code-review", "automation", "drupal-11"]
```

### Directory naming
- Use lowercase
- Use hyphens (not underscores or spaces)
- Keep concise but descriptive
- Example: `my-awesome-plugin` (not `MyAwesomePlugin` or `my_awesome_plugin`)

## Files That Control Everything

| File | Purpose |
|------|---------|
| `plugins/{name}/.claude-plugin/plugin.json` | Plugin metadata |
| `/.claude-plugin/marketplace.json` | Marketplace registry |
| `plugins/{name}/README.md` | User documentation |
| `scripts/validate-marketplace.sh` | Validation automation |
| `.git/hooks/pre-commit` | Prevents bad commits |

## Success Indicators

You're done when:

✓ Validation script passes
✓ No errors from pre-commit hook
✓ Plugin appears in marketplace list
✓ Plugin can be installed
✓ All metadata is consistent

## Contact & Issues

For prevention strategy improvements or issues:
1. Check relevant documentation
2. Run `./scripts/validate-marketplace.sh` for diagnostics
3. Review error messages carefully
4. Refer to full prevention guide for detailed solutions

---

**Remember:** Plugin registration is a **critical step**. Always validate before committing!
