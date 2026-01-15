# Create Entity / Content Type / Bundle

## Required Reading
Before starting, load:
- `../references/entity-api.md` - Entity fundamentals
- `../references/field-api.md` - Field configuration

---

## Input Gathering

Ask user:
1. **Entity type**: Content type, Paragraph type, or custom entity?
2. **Machine name**: (lowercase, underscores)
3. **Label**: Human-readable name
4. **Description**: What it represents
5. **Fields needed**: List of fields to add

---

## Process

### Option A: Content Type (Node)

#### Via Drush (Recommended)

```bash
# Generate content type
ddev drush generate content-type

# Follow prompts for:
# - Machine name
# - Label
# - Description
# - Publishing options
```

#### Via Config

Create `config/sync/node.type.<machine_name>.yml`:

```yaml
langcode: en
status: true
dependencies: {}
name: '<Label>'
type: <machine_name>
description: '<Description>'
help: ''
new_revision: true
preview_mode: 1
display_submitted: true
```

Then import:
```bash
ddev drush cim -y
```

---

### Option B: Paragraph Type

#### Via UI

1. Navigate to `/admin/structure/paragraphs_type/add`
2. Fill in machine name and label
3. Save and add fields

#### Via Config

Create `config/sync/paragraphs.paragraphs_type.<machine_name>.yml`:

```yaml
langcode: en
status: true
dependencies: {}
id: <machine_name>
label: '<Label>'
icon_uuid: null
icon_default: null
description: '<Description>'
behavior_plugins: {}
```

---

### Option C: Custom Entity Type

#### Generate with Drush

```bash
ddev drush generate entity:content
```

Follow prompts for:
- Module name
- Entity type ID
- Entity label
- Base table name
- Revision support
- Admin permission

#### Key Files Generated

```
modules/custom/<module>/
├── src/
│   ├── Entity/
│   │   └── <Entity>.php           # Entity class
│   ├── <Entity>Interface.php       # Interface
│   ├── <Entity>ListBuilder.php     # Admin list
│   └── Form/
│       ├── <Entity>Form.php        # Add/edit form
│       └── <Entity>DeleteForm.php  # Delete confirmation
├── <module>.routing.yml            # Routes
├── <module>.links.menu.yml         # Admin menu
└── <module>.links.action.yml       # Action links
```

---

## Post-Creation

### 1. Add Fields

After entity/bundle exists:

```bash
# Run field workflow
# → workflows/manage-fields.md
```

### 2. Configure Display

```bash
# Form display
/admin/structure/types/manage/<bundle>/form-display

# View display
/admin/structure/types/manage/<bundle>/display
```

### 3. Export Configuration

```bash
ddev drush cex -y
```

### 4. Verify

```bash
# Check config status
ddev drush config:status

# Verify entity exists
ddev drush entity-types
```

---

## Anti-Patterns

❌ **NEVER** create entities without exporting config
❌ **NEVER** use database-level entity creation in production
❌ **NEVER** forget to set appropriate permissions
❌ **NEVER** skip revision support for content entities

---

## Success Criteria

- [ ] Entity/bundle appears in admin UI
- [ ] Configuration exported to `config/sync/`
- [ ] `ddev drush config:status` shows no differences
- [ ] Basic CRUD operations work
