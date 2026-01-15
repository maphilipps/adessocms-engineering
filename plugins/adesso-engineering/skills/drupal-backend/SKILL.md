---
name: drupal-backend
description: |
  Build Drupal backend functionality - Entities, Fields, Services, Plugins, Configuration, Migrations.
  Automatically invoked when feature.skill = "drupal-backend" in Ralph Loop.
---

<essential_principles>
## How Drupal Backend Works

### 1. DDEV-First Development

**ALL commands run inside DDEV:**

```bash
ddev drush <command>        # Drush commands
ddev exec <command>         # Any command
ddev composer <command>     # Composer
ddev ssh                    # Shell access
```

**NEVER run commands outside DDEV for Drupal work.**

### 2. Configuration Management

All configuration must be exportable:

```bash
# Export after changes
ddev drush cex -y

# Import on deploy
ddev drush cim -y

# Check diff
ddev drush config:status
```

**Config location:** `config/sync/` (default) or custom split directories.

### 3. Entity API Hierarchy

```
Content Entity (node, paragraph, user)
    ↓
Bundle (content type, paragraph type)
    ↓
Fields (field storage + field instance)
    ↓
Display Settings (form + view modes)
```

### 4. Service-First Architecture

Use dependency injection, not global functions:

```php
// CORRECT
public function __construct(
  private EntityTypeManagerInterface $entityTypeManager,
  private ModuleHandlerInterface $moduleHandler,
) {}

// WRONG
$entity_type_manager = \Drupal::entityTypeManager();
```

### 5. Safe Config Operations

**NEVER import without inspection:**

```bash
# 1. Check what will change
ddev drush config:status

# 2. Review specific changes
ddev drush config:diff <config-name>

# 3. Import if safe
ddev drush cim -y
```
</essential_principles>

<intake>
**What would you like to do?**

1. Create a content type or entity
2. Add/modify fields
3. Create a custom service
4. Create a plugin (Block, Field, etc.)
5. Handle configuration (export/import/split)
6. Update contrib modules
7. Write a migration
8. Something else

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "entity", "content type", "bundle" | `workflows/create-entity.md` |
| 2, "field", "add field", "modify field" | `workflows/manage-fields.md` |
| 3, "service", "custom service" | `workflows/create-service.md` |
| 4, "plugin", "block", "formatter" | `workflows/create-plugin.md` |
| 5, "config", "export", "import", "split" | `workflows/config-management.md` |
| 6, "update", "contrib", "module" | `workflows/contrib-management.md` |
| 7, "migration", "migrate" | `workflows/create-migration.md` |
| 8, other | Clarify, then select workflow |

**After reading the workflow, follow it exactly.**
</routing>

<verification_loop>
## After Every Change

```bash
# 1. Export config
ddev drush cex -y

# 2. Clear cache
ddev drush cr

# 3. Verify
ddev drush config:status   # Should show "No differences"

# 4. Code standards
ddev exec phpcs --standard=Drupal,DrupalPractice web/modules/custom/<module>
```

Report to user:
- "Config exported: ✓"
- "Cache cleared: ✓"
- "Config status: In sync"
- "PHPCS: ✓ (or N issues found)"
</verification_loop>

<reference_index>
## Domain Knowledge

All in `references/`:

**Core APIs:**
- entity-api.md - Entity types, bundles, CRUD operations
- field-api.md - Field storage, instances, formatters, widgets
- service-container.md - Dependency injection, service definitions

**Plugins:**
- plugin-api.md - Plugin types, annotations, discovery
- common-plugins.md - Block, Field Formatter/Widget, QueueWorker

**Configuration:**
- config-api.md - Config entities, simple config, overrides
- config-split.md - Environment-specific configuration
- config-troubleshooting.md - Common config issues and fixes

**Data:**
- database-api.md - Database abstraction, queries, transactions
- migration-api.md - ETL with Migrate API

**Best Practices:**
- coding-standards.md - Drupal coding standards
- security.md - Security best practices (OWASP, sanitization)
</reference_index>

<workflows_index>
## Workflows

All in `workflows/`:

| File | Purpose |
|------|---------|
| create-entity.md | New content type, paragraph type, custom entity |
| manage-fields.md | Add, modify, delete fields |
| create-service.md | Custom service with DI |
| create-plugin.md | Block, Field Formatter/Widget, etc. |
| config-management.md | Export, import, split, troubleshoot |
| contrib-management.md | Update, patch, secure modules |
| create-migration.md | Migrate content from external sources |
</workflows_index>

<mcp_tools>
## Available MCP Tools

**Drupal MCP (if configured):**
- Content operations via MCP
- Field configuration
- Entity queries

**Context7:**
- `mcp__context7__resolve-library-id` - Find Drupal docs
- `mcp__context7__query-docs` - Query Drupal documentation

**Always prefer:**
1. Drupal MCP tools
2. `ddev drush` commands
3. Direct database queries (last resort)
</mcp_tools>
