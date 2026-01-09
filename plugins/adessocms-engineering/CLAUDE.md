# Compounding Engineering Plugin Development

## Versioning Requirements

**IMPORTANT**: Every change to this plugin MUST include updates to all three files:

1. **`.claude-plugin/plugin.json`** - Bump version using semver
2. **`CHANGELOG.md`** - Document changes using Keep a Changelog format
3. **`README.md`** - Verify/update component counts and tables

### Version Bumping Rules

- **MAJOR** (1.0.0 → 2.0.0): Breaking changes, major reorganization
- **MINOR** (1.0.0 → 1.1.0): New agents, commands, or skills
- **PATCH** (1.0.0 → 1.0.1): Bug fixes, doc updates, minor improvements

### Pre-Commit Checklist

Before committing ANY changes:

- [ ] Version bumped in `.claude-plugin/plugin.json`
- [ ] CHANGELOG.md updated with changes
- [ ] README.md component counts verified
- [ ] README.md tables accurate (agents, commands, skills)
- [ ] plugin.json description matches current counts

### Directory Structure

```
agents/
├── review/     # Code review agents
├── research/   # Research and analysis agents
├── design/     # Design and UI agents
├── workflow/   # Workflow automation agents
└── docs/       # Documentation agents

commands/
├── workflows/  # Core workflow commands (/refine, /work, /review, /compound)
└── *.md        # Utility commands

skills/
├── adessocms-frontend/  # Meta-Skill: SDC, Tailwind, Twig, Alpine
│   ├── SKILL.md         # Router
│   ├── workflows/       # Build, Convert, Verify
│   └── references/      # Patterns, Anti-patterns
├── drupal-backend/      # Meta-Skill: Entities, Services, Plugins
├── devops/              # Meta-Skill: DDEV, Composer, CI/CD
├── gitlab/              # MR, Pipelines, glab CLI
├── github/              # PR, Actions, gh CLI
└── *.md                 # Other skills (standalone)
```

## Documentation

See `docs/solutions/plugin-versioning-requirements.md` for detailed versioning workflow.

---

## adesso CMS Engineering Workflow (v3.0.0)

### Ralph Loop - Hauptworkflow

```
/acms-refine        # Feature-List erstellen (Interview + Research)
      ↓
/acms-work          # Ralph Loop: Feature für Feature abarbeiten
      ↓
/acms-review        # Parallel Specialist Review
      ↓
/acms-compound      # Learnings extrahieren
```

### Phase 1: /acms-refine

Erstellt `tasks/<task>/feature-list.json` mit atomaren Features:

```json
{
  "features": [
    {
      "id": "F001",
      "title": "Database schema",
      "type": "backend",
      "skill": "drupal-backend",
      "passes": false
    }
  ]
}
```

**Optional Research Agents:**
- `repo-research-analyst` - Codebase Patterns
- `librarian` - Externe Dokumentation
- `design-system-guardian` - UI/Design Tokens

### Phase 2: /acms-work (Ralph Loop)

Arbeitet Features ab mit **einem Feature pro Session**:

1. Lese `feature-list.json`
2. Wähle nächste Feature mit `passes: false`
3. Invoke passenden Skill automatisch
4. Implementiere + Teste
5. Setze `passes: true` + Commit
6. Loop → nächste Feature

**Skill Auto-Invocation basierend auf `feature.skill`:**

| skill | Invokes |
|-------|---------|
| `adessocms-frontend` | SDC, Tailwind, Twig, Alpine.js |
| `drupal-backend` | Entities, Services, Plugins, Config |
| `devops` | DDEV, Composer, CI/CD |
| `gitlab` | glab MR, Pipelines |
| `github` | gh PR, Actions |

### Specialist Usage während Implementation

| Change Type | Specialists |
|-------------|-------------|
| PHP/Module | `drupal-specialist`, `security-sentinel` |
| Twig/Theme | `twig-specialist`, `drupal-theme-specialist` |
| SDC Components | `sdc-specialist` |
| CSS/Tailwind | `tailwind-specialist` |
| Tests | `test-coverage-specialist` |
| Database/Migrations | `data-integrity-guardian` |
| Performance-kritisch | `performance-oracle` |
| **Vor jedem Commit** | `code-simplifier` |

### Phase 3: Nach Implementation

1. `/acms-review` - Parallel Specialist Review
2. `/acms-compound` - Learnings extrahieren
3. Git commit + push

### Meta-Skills (v3.0.0)

**5 konsolidierte Skills mit Domain Expertise Pattern:**

| Meta-Skill | Beschreibung | Dateien |
|------------|--------------|---------|
| `adessocms-frontend` | SDC, Tailwind v4, Twig, Alpine.js | 15 files |
| `drupal-backend` | Entities, Services, Plugins, Config | 20 files |
| `devops` | DDEV, Composer, CI/CD | 9 files |
| `gitlab` | glab CLI, MRs, Pipelines | 8 files |
| `github` | gh CLI, PRs, Actions | 8 files |

### Specialist Agents (17)

**Drupal Core:** `drupal-specialist`, `drupal-theme-specialist`, `paragraphs-specialist`
**Frontend:** `twig-specialist`, `sdc-specialist`, `tailwind-specialist`, `storybook-specialist`
**Quality:** `security-sentinel`, `accessibility-specialist`, `test-coverage-specialist`
**Architecture:** `architecture-strategist`, `performance-oracle`
**Data:** `data-integrity-guardian`, `composer-specialist`
**Design:** `design-system-guardian`, `component-reuse-specialist`

---

## Auto-Invoke Rules (MANDATORY)

### During Implementation (/acms-work)

When `feature-list.json` specifies a skill, Claude MUST invoke it:

```
"skill": "adessocms-frontend" → Skill(skill: "adessocms-frontend")
"skill": "drupal-backend"    → Skill(skill: "drupal-backend")
"skill": "devops"            → Skill(skill: "devops")
"skill": "gitlab"            → Skill(skill: "gitlab")
"skill": "github"            → Skill(skill: "github")
```

### After Implementation: code-simplifier (MANDATORY)

After completing ANY implementation task, Claude MUST automatically invoke
the code-simplifier agent to ensure code is minimal and simple.

**This applies to:**
- After /acms-work completes a feature
- After any significant code changes (5+ lines)
- Before committing changes

**Invoke with:** `Task(subagent_type: "code-simplifier", prompt: "Review and simplify the changes I just made")`

**This is MANDATORY, not optional. No exceptions.**

### During Review (/acms-review)

Invoke specialists based on file types changed:

| File Pattern | Specialists to Invoke |
|--------------|----------------------|
| `.php`, `.module` | `drupal-specialist`, `security-sentinel` |
| `.twig` | `twig-specialist` |
| `*.sdc.yml`, SDC folders | `sdc-specialist` |
| `.tailwind.css`, Tailwind | `tailwind-specialist` |
| Theme files | `drupal-theme-specialist` |
| All changes | `architecture-strategist`, `accessibility-specialist` |

**Launch specialists IN PARALLEL** using multiple Task tool calls in a single message.

---

## MCP Server Management

### Engineering-KB Server

**Location:** `https://mcp.adessocms.de/mcp` (Hetzner: 95.216.208.185)

**Configuration:** `.claude-plugin/plugin.json`
```json
"engineering-kb": {
  "type": "sse",
  "url": "https://mcp.adessocms.de/mcp",
  "headers": {
    "Authorization": "Bearer <API_KEY>"
  }
}
```

### API Key Generation

**When token expires or becomes invalid:**

1. **SSH to server:**
```bash
ssh root@95.216.208.185 -i ~/.ssh/id_rsa
```

2. **Navigate to project:**
```bash
cd /var/www/engineering-kb
```

3. **Generate new key:**
```bash
node -e "
const { nanoid } = require('nanoid');
const { randomBytes, createHash } = require('crypto');
const bcrypt = require('bcryptjs');
const db = require('better-sqlite3')('/var/www/engineering-kb/data/engineering-kb.db');

function createUser(username, password, role) {
  const id = nanoid();
  const now = new Date().toISOString();
  const passwordHash = bcrypt.hashSync(password, 12);
  db.prepare('INSERT INTO users (id, username, password_hash, role, created_at, updated_at) VALUES (?, ?, ?, ?, ?, ?)')
    .run(id, username, passwordHash, role, now, now);
  return db.prepare('SELECT * FROM users WHERE id = ?').get(id);
}

function createApiKey(userId, name, scopes) {
  const id = nanoid();
  const rawKey = 'ekb_' + randomBytes(32).toString('base64url');
  const keyHash = createHash('sha256').update(rawKey).digest('hex');
  const keyPrefix = rawKey.slice(0, 12);
  const now = new Date().toISOString();
  db.prepare('INSERT INTO api_keys (id, name, key_hash, key_prefix, user_id, scopes, expires_at, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?)')
    .run(id, name, keyHash, keyPrefix, userId, JSON.stringify(scopes), null, now);
  return { id, rawKey, keyPrefix, userId };
}

const user = createUser('claude-code', 'temp-password-123', 'admin');
const apiKey = createApiKey(user.id, 'Claude Code Plugin', ['read', 'write', 'admin']);
console.log('NEW API KEY:', apiKey.rawKey);
"
```

4. **Update plugin.json:** Replace the Bearer token with the new key

5. **Test connection:**
```bash
curl -s -H "Authorization: Bearer <NEW_KEY>" -H "Accept: application/json, text/event-stream" \
  -d '{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05"}}' \
  https://mcp.adessocms.de/mcp
```

**Server Status Check:**
```bash
ssh root@95.216.208.185 -i ~/.ssh/id_rsa "pm2 list"
```

**Common Errors:**
- `-32000 Invalid session or missing initialization`: MCP needs proper SSE headers
- `-32001 Invalid API key`: Bearer token is expired or invalid
- Connection refused: PM2 service not running
