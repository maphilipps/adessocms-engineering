# Create Migration

## Required Reading
Before starting, load:
- `../references/migration-api.md` - Migrate API fundamentals

---

## Input Gathering

Ask user:
1. **Source**: CSV, JSON, XML, Database, API?
2. **Destination**: Node, Paragraph, User, Taxonomy?
3. **Field mapping**: Source fields → Destination fields
4. **Dependencies**: Does this migration depend on others?

---

## Process

### Step 1: Create Migration Module

```bash
ddev drush generate module

# Name: <project>_migrate
# Enable: yes
```

Add migrate dependency to `<module>.info.yml`:

```yaml
dependencies:
  - drupal:migrate
  - drupal:migrate_plus
  - drupal:migrate_tools
```

### Step 2: Define Migration YAML

Create `config/install/migrate_plus.migration.<migration_id>.yml`:

```yaml
id: <migration_id>
label: '<Label>'
migration_group: <group>
migration_tags:
  - <project>

source:
  plugin: <source_plugin>
  # Source-specific config

process:
  # Field mappings

destination:
  plugin: <destination_plugin>
  # Destination-specific config

migration_dependencies:
  required: []
  optional: []
```

---

## Source Plugins

### CSV Source

```yaml
source:
  plugin: csv
  path: 'public://import/data.csv'
  header_offset: 0
  ids:
    - id
  fields:
    - name: id
      label: 'Unique ID'
    - name: title
      label: 'Title'
    - name: body
      label: 'Body Content'
```

### JSON Source

```yaml
source:
  plugin: url
  data_fetcher_plugin: http
  data_parser_plugin: json
  urls:
    - 'https://api.example.com/data.json'
  item_selector: items
  fields:
    - name: id
      label: 'ID'
      selector: id
    - name: title
      selector: title
  ids:
    id:
      type: integer
```

### Database Source

```yaml
source:
  plugin: d7_node
  node_type: article
```

---

## Process Plugins

### Direct Mapping

```yaml
process:
  title: title
  body/value: body
  body/format:
    plugin: default_value
    default_value: full_html
```

### With Transformation

```yaml
process:
  # Static value
  type:
    plugin: default_value
    default_value: article

  # Conditional
  status:
    plugin: static_map
    source: published
    map:
      'yes': 1
      'no': 0

  # Lookup entity reference
  field_category:
    plugin: migration_lookup
    migration: <taxonomy_migration>
    source: category_id

  # Date conversion
  created:
    plugin: format_date
    source: date
    from_format: 'Y-m-d'
    to_format: 'U'
```

### Entity Reference

```yaml
process:
  field_image:
    plugin: migration_lookup
    migration: <media_migration>
    source: image_id
```

---

## Destination Plugins

### Content Entity

```yaml
destination:
  plugin: entity:node
  default_bundle: article
```

### Paragraph

```yaml
destination:
  plugin: entity_reference_revisions:paragraph
  default_bundle: text
```

### Taxonomy Term

```yaml
destination:
  plugin: entity:taxonomy_term
  default_bundle: tags
```

### User

```yaml
destination:
  plugin: entity:user
```

---

## Migration Groups

Create `config/install/migrate_plus.migration_group.<group>.yml`:

```yaml
id: <group>
label: '<Group Label>'
description: '<Description>'
source_type: '<Source Description>'
shared_configuration:
  source:
    # Shared source config
```

---

## Running Migrations

```bash
# Import
ddev drush migrate:import <migration_id>

# Import all in group
ddev drush migrate:import --group=<group>

# Status
ddev drush migrate:status

# Rollback
ddev drush migrate:rollback <migration_id>

# Reset stuck migration
ddev drush migrate:reset-status <migration_id>
```

---

## Migration Dependencies

```yaml
migration_dependencies:
  required:
    - <taxonomy_migration>  # Must run first
    - <media_migration>
  optional:
    - <related_migration>   # Nice to have
```

**Order of execution:**
1. Taxonomy/reference migrations
2. Media/file migrations
3. Content migrations
4. Relationship migrations

---

## Debugging

```bash
# Verbose output
ddev drush migrate:import <migration_id> -v

# Single item
ddev drush migrate:import <migration_id> --limit=1

# Show messages
ddev drush migrate:messages <migration_id>
```

---

## Verification

```bash
# Check status
ddev drush migrate:status

# Verify content created
ddev drush sqlq "SELECT COUNT(*) FROM node WHERE type='<bundle>'"

# Check for errors
ddev drush migrate:messages <migration_id>
```

---

## Success Criteria

- [ ] Migration defined in config
- [ ] Source data readable
- [ ] Field mappings correct
- [ ] Dependencies ordered properly
- [ ] `migrate:import` completes without errors
- [ ] Destination content correct
