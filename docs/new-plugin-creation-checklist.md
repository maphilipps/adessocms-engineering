# New Plugin Creation Checklist

A step-by-step guide for creating and registering a new plugin in the adessocms marketplace.

## Pre-Creation: Planning

Before you create any files, answer these questions:

- [ ] **What is the plugin name?** (lowercase, hyphenated: e.g., `my-awesome-plugin`)
- [ ] **What is the primary purpose?** (e.g., "Drupal development tools")
- [ ] **Who is the author?** (your name)
- [ ] **What components will it have?**
  - [ ] How many agents?
  - [ ] How many commands?
  - [ ] How many skills?
  - [ ] Any MCP servers?

## Step 1: Create Plugin Directory Structure

```bash
# Set your plugin name
PLUGIN_NAME="my-awesome-plugin"

# Create directories
mkdir -p "plugins/$PLUGIN_NAME/.claude-plugin"
mkdir -p "plugins/$PLUGIN_NAME/agents"
mkdir -p "plugins/$PLUGIN_NAME/commands"
mkdir -p "plugins/$PLUGIN_NAME/skills"
mkdir -p "plugins/$PLUGIN_NAME/docs"

# Verify structure
tree "plugins/$PLUGIN_NAME"
# Expected output:
# plugins/my-awesome-plugin/
# ├── .claude-plugin/
# ├── agents/
# ├── commands/
# ├── docs/
# └── skills/
```

**Checklist:**
- [ ] Directory created: `plugins/{plugin-name}/`
- [ ] Subdirectories created: `agents/`, `commands/`, `skills/`, `docs/`
- [ ] `.claude-plugin/` directory exists

## Step 2: Create plugin.json

Create `.claude-plugin/plugin.json` with all required metadata:

```json
{
  "name": "my-awesome-plugin",
  "version": "0.1.0",
  "description": "Clear description of what this plugin does (50-150 chars).",
  "author": {
    "name": "Your Name",
    "email": "your.email@example.com",
    "url": "https://github.com/yourusername"
  },
  "homepage": "https://github.com/yourusername/my-awesome-plugin",
  "repository": {
    "type": "git",
    "url": "https://github.com/yourusername/my-awesome-plugin.git"
  },
  "license": "MIT",
  "keywords": [
    "ai-powered",
    "primary-domain",
    "capability1",
    "capability2",
    "capability3"
  ]
}
```

**Checklist:**
- [ ] File created: `plugins/{name}/.claude-plugin/plugin.json`
- [ ] `name` field: `{plugin-name}` (lowercase, hyphenated)
- [ ] `version` field: `0.1.0` (initial version)
- [ ] `description` field: Clear, searchable (50-150 chars)
- [ ] `author` object: name, email, URL
- [ ] `keywords` array: 5 searchable tags
- [ ] JSON is valid: `jq . plugins/{name}/.claude-plugin/plugin.json`

## Step 3: Create README.md

Create a comprehensive `README.md` in the plugin root:

```markdown
# {Plugin Name}

{Clear description of what this plugin does.}

## Installation

To install this plugin:

\`\`\`bash
/plugins install {plugin-name}
\`\`\`

## What's Included

| Component | Count |
|-----------|-------|
| Agents | X |
| Commands | Y |
| Skills | Z |

### Agents

- `agent-name-1` - Brief description
- `agent-name-2` - Brief description

### Commands

- `/command-1` - Brief description
- `/command-2` - Brief description

### Skills

- `skill-1` - Brief description
- `skill-2` - Brief description

## Usage

[Examples of how to use the plugin]

## Requirements

- Claude Code CLI
- [Any other requirements]

## Documentation

See [plugin docs](./docs/) for detailed documentation.

## License

MIT
\`\`\`

**Checklist:**
- [ ] File created: `plugins/{name}/README.md`
- [ ] Clear description in header
- [ ] Installation instructions included
- [ ] Components table showing counts
- [ ] Lists of agents, commands, skills with descriptions
- [ ] Usage examples included
- [ ] Requirements documented
- [ ] License specified
```

## Step 4: Create Plugin Content

Now create your agents, commands, and skills:

### Agents

Create agent files in `plugins/{name}/agents/`:

```bash
# Example agent structure
cat > "plugins/$PLUGIN_NAME/agents/my-agent.md" << 'EOF'
# My Agent

Agent description and behavior.

## Capabilities

- Capability 1
- Capability 2

## When to Use

Use this agent when...

## Example Prompt

"@my-agent review this code for X"
EOF
```

**Checklist:**
- [ ] Create `agents/*.md` files as needed
- [ ] Each agent has clear purpose and description
- [ ] Agent count matches README.md

### Commands

Create command files in `plugins/{name}/commands/`:

```bash
# Example command structure
cat > "plugins/$PLUGIN_NAME/commands/my-command.md" << 'EOF'
# /my-command

Brief description of what this command does.

## Usage

/my-command [options]

## Options

- `--option1`: Description
- `--option2`: Description

## Example

/my-command --option1 value
EOF
```

**Checklist:**
- [ ] Create `commands/*.md` files as needed
- [ ] Each command clearly documented
- [ ] Command count matches README.md

### Skills

Create skill files in `plugins/{name}/skills/`:

```bash
# Example skill structure (can reference Context7 MCP for patterns)
cat > "plugins/$PLUGIN_NAME/skills/my-skill.md" << 'EOF'
# My Skill

Skill description and when to use it.

## Topics Covered

- Topic 1
- Topic 2

## Common Patterns

[Common code patterns and examples]

## Resources

[Links to documentation]
EOF
```

**Checklist:**
- [ ] Create `skills/*.md` files as needed
- [ ] Each skill has practical examples
- [ ] Skill count matches README.md

## Step 5: Validate plugin.json

Before registering in marketplace, validate the JSON:

```bash
# Validate JSON syntax
jq . plugins/{plugin-name}/.claude-plugin/plugin.json

# Verify required fields
jq '{name, version, description, author}' plugins/{plugin-name}/.claude-plugin/plugin.json
```

**Checklist:**
- [ ] JSON is valid (jq . succeeds)
- [ ] All required fields present
- [ ] Name is lowercase and hyphenated

## Step 6: Register in marketplace.json

Add an entry to `/.claude-plugin/marketplace.json`:

```json
{
  "name": "{plugin-name}",
  "description": "{description from plugin.json}",
  "version": "0.1.0",
  "author": {
    "name": "Your Name",
    "url": "https://github.com/yourusername",
    "email": "your.email@example.com"
  },
  "homepage": "https://github.com/yourusername/{plugin-name}",
  "tags": ["primary-domain", "capability1", "capability2", "capability3", "capability4"],
  "source": "./plugins/{plugin-name}"
}
```

**Checklist:**
- [ ] Entry added to `/.claude-plugin/marketplace.json`
- [ ] `name` field matches plugin directory name
- [ ] `version` matches `plugin.json` version
- [ ] `description` matches `plugin.json` description
- [ ] `source` path is correct: `./plugins/{plugin-name}`
- [ ] All fields present: name, description, version, author, tags, source
- [ ] marketplace.json is still valid JSON

## Step 7: Validate Marketplace Registration

Run the validation script to ensure everything is correct:

```bash
# Run validation
./scripts/validate-marketplace.sh

# Expected output:
# ✓ All validations passed!
```

If validation fails, the script will tell you exactly what's wrong. Fix issues and re-run.

**Checklist:**
- [ ] Validation script runs successfully
- [ ] No errors reported
- [ ] No unregistered plugins
- [ ] Plugin names consistent everywhere

## Step 8: Create Documentation

Create comprehensive documentation in `plugins/{name}/docs/`:

```bash
# Create docs directory structure
mkdir -p "plugins/$PLUGIN_NAME/docs"

# Create index
cat > "plugins/$PLUGIN_NAME/docs/README.md" << 'EOF'
# {Plugin Name} Documentation

## Topics

- [Getting Started](./getting-started.md)
- [Agents Guide](./agents.md)
- [Commands Reference](./commands.md)
- [Skills Library](./skills.md)

EOF
```

**Checklist:**
- [ ] Documentation created in `docs/` folder
- [ ] Getting started guide included
- [ ] Examples provided
- [ ] Troubleshooting section included

## Step 9: Commit Changes

Commit both the plugin and marketplace entry together:

```bash
# Stage all plugin files
git add "plugins/$PLUGIN_NAME/"

# Stage marketplace entry
git add "./.claude-plugin/marketplace.json"

# Create commit with descriptive message
git commit -m "feat: Add {plugin-name} plugin to marketplace

- Create plugin directory with {X} agents, {Y} commands, {Z} skills
- Register in marketplace.json for discoverability
- Include complete documentation and README"

# Verify commit
git log -1
```

**Checklist:**
- [ ] Plugin directory added: `plugins/{plugin-name}/`
- [ ] marketplace.json updated
- [ ] Both files in same commit
- [ ] Commit message references plugin name
- [ ] Commit message explains what was added

## Step 10: Verify Discoverability

After committing, verify the plugin is discoverable:

```bash
# Check if plugin appears in marketplace list
/plugins list

# Search for plugin
/plugins search {plugin-name}

# View plugin details
/plugins view {plugin-name}

# Install the plugin
/plugins install {plugin-name}
```

**Checklist:**
- [ ] Plugin appears in marketplace list
- [ ] Search finds the plugin
- [ ] Plugin can be viewed
- [ ] Plugin can be installed successfully

## Quick Reference

### Name Consistency

Make sure the name is **identical** in all three places:

```
Directory:       plugins/{plugin-name}/
plugin.json:     "name": "{plugin-name}"
marketplace.json: "name": "{plugin-name}"
```

### File Checklist

Before committing, ensure these files exist:

```
plugins/{plugin-name}/
├── .claude-plugin/
│   └── plugin.json              ← REQUIRED
├── agents/
│   └── *.md                     ← At least one
├── commands/
│   └── *.md                     ← At least one
├── skills/
│   └── *.md                     ← Optional but recommended
├── docs/
│   └── *.md                     ← Recommended
└── README.md                    ← REQUIRED
```

### Validation Commands

```bash
# Run marketplace validation
./scripts/validate-marketplace.sh

# Validate plugin.json JSON
jq . plugins/{plugin-name}/.claude-plugin/plugin.json

# Validate marketplace.json JSON
jq . ./.claude-plugin/marketplace.json

# Check file structure
tree plugins/{plugin-name}/
```

## Troubleshooting

### "Unregistered plugin" error

**Problem:** Plugin directory exists but doesn't appear in marketplace

**Solution:**
1. Check entry in `./.claude-plugin/marketplace.json`
2. Verify `name` field matches directory name
3. Verify `source` path is correct: `./plugins/{name}`
4. Run: `./scripts/validate-marketplace.sh`

### "Name mismatch" error

**Problem:** Plugin validation fails with name mismatch

**Solution:**
1. Directory name: `plugins/{plugin-name}/`
2. plugin.json `name`: `{plugin-name}`
3. marketplace.json `name`: `{plugin-name}`
4. All must be **identical** (case-sensitive)

### "Missing files" error

**Problem:** Plugin.json or README.md not found

**Solution:**
```bash
# Create missing files
touch plugins/{plugin-name}/.claude-plugin/plugin.json
touch plugins/{plugin-name}/README.md

# Add content and commit
git add plugins/{plugin-name}/
git commit -m "fix: Add missing plugin metadata"
```

### Marketplace.json syntax error

**Problem:** JSON validation fails

**Solution:**
```bash
# Check for syntax errors
jq . ./.claude-plugin/marketplace.json

# View the error context
cat ./.claude-plugin/marketplace.json | tail -20

# Use a JSON formatter
jq '.' ./.claude-plugin/marketplace.json > /tmp/formatted.json
# Compare the formatted version
```

## Success!

Once validation passes and the plugin is committed:

✓ Plugin is registered in marketplace
✓ Plugin is discoverable via search
✓ Users can install the plugin
✓ All metadata is consistent
✓ Documentation is complete

You're done! The plugin is ready for users to discover and install.
