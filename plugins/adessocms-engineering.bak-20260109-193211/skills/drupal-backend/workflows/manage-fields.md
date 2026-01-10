# Manage Fields

## Required Reading
Before starting, load:
- `../references/field-api.md` - Field types, storage, instances
- `../references/config-api.md` - Config export/import

---

## Input Gathering

Ask user:
1. **Operation**: Add, modify, or delete field?
2. **Entity type**: Node, Paragraph, etc.
3. **Bundle**: Specific content type or paragraph type
4. **Field details**: Name, type, cardinality, required?

---

## Process

### Add New Field

#### Step 1: Check if Field Storage Exists

```bash
ddev drush config:get field.storage.<entity_type>.<field_name> 2>/dev/null || echo "Field storage does not exist"
```

#### Step 2: Create Field Storage (if needed)

Via UI: `/admin/structure/types/manage/<bundle>/fields/add-field`

Or via config `field.storage.<entity_type>.<field_name>.yml`:

```yaml
langcode: en
status: true
dependencies:
  module:
    - <entity_module>
id: <entity_type>.<field_name>
field_name: <field_name>
entity_type: <entity_type>
type: <field_type>
settings: {}
module: core
locked: false
cardinality: 1  # -1 for unlimited
translatable: true
```

#### Step 3: Create Field Instance

Config `field.field.<entity_type>.<bundle>.<field_name>.yml`:

```yaml
langcode: en
status: true
dependencies:
  config:
    - field.storage.<entity_type>.<field_name>
    - <entity_type>.type.<bundle>
id: <entity_type>.<bundle>.<field_name>
field_name: <field_name>
entity_type: <entity_type>
bundle: <bundle>
label: '<Label>'
description: '<Help text>'
required: false
translatable: true
default_value: []
default_value_callback: ''
settings: {}
field_type: <field_type>
```

#### Step 4: Configure Form Display

`core.entity_form_display.<entity_type>.<bundle>.default.yml`:

Add field to `content` section:
```yaml
content:
  <field_name>:
    type: <widget_type>
    weight: 10
    region: content
    settings: {}
    third_party_settings: {}
```

#### Step 5: Configure View Display

`core.entity_view_display.<entity_type>.<bundle>.default.yml`:

Add field to `content` section:
```yaml
content:
  <field_name>:
    type: <formatter_type>
    weight: 10
    region: content
    label: above  # above, inline, hidden, visually_hidden
    settings: {}
    third_party_settings: {}
```

---

### Common Field Types

| Type | Machine Name | Use For |
|------|--------------|---------|
| Plain text | `string` | Short text (255 chars) |
| Long text | `text_long` | Body text without summary |
| Formatted text | `text_with_summary` | Body with teaser |
| Boolean | `boolean` | Yes/No toggle |
| Integer | `integer` | Whole numbers |
| Decimal | `decimal` | Precise numbers |
| Email | `email` | Email addresses |
| Link | `link` | URLs |
| Entity reference | `entity_reference` | Related content |
| Image | `image` | Images with alt/title |
| File | `file` | File uploads |

---

### Modify Existing Field

#### Change Field Settings

```bash
# View current config
ddev drush config:get field.field.<entity_type>.<bundle>.<field_name> --format=yaml

# Edit and re-import
ddev drush cim --source=config/sync -y
```

#### Change Cardinality

⚠️ **Warning**: Reducing cardinality can cause data loss!

```bash
# Check existing data
ddev drush sqlq "SELECT COUNT(*) FROM <entity_type>__<field_name> GROUP BY entity_id HAVING COUNT(*) > 1"
```

---

### Delete Field

#### Step 1: Remove Field Instance

```bash
# Mark for deletion
ddev drush field:delete <entity_type>.<bundle>.<field_name>
```

#### Step 2: Run Cron (or manual purge)

```bash
ddev drush cron
# or
ddev drush field-purge-batch 100
```

#### Step 3: Export Config

```bash
ddev drush cex -y
```

---

## Verification

```bash
# Check field exists
ddev drush field:info <entity_type> | grep <field_name>

# Verify config
ddev drush config:status

# Test in UI
# Navigate to entity add/edit form
```

---

## Anti-Patterns

❌ **NEVER** delete field storage with data without backup
❌ **NEVER** change field type on existing fields (create new field instead)
❌ **NEVER** reduce cardinality without checking existing data
❌ **NEVER** forget to configure display settings

---

## Success Criteria

- [ ] Field appears on entity form
- [ ] Field displays on entity view
- [ ] Configuration exported
- [ ] `ddev drush config:status` shows in sync
