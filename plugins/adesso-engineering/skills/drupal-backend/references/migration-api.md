# Migration API Reference

## Migrate Architecture

```
Source → Process → Destination
  ↓         ↓          ↓
Extract   Transform   Load
```

---

## Source Plugins

### CSV Source

```yaml
source:
  plugin: csv
  path: 'public://import/data.csv'
  header_offset: 0  # Row with headers (0-indexed)
  ids:
    - id  # Unique identifier column
  fields:
    - name: id
      label: 'ID'
    - name: title
      label: 'Title'
```

### JSON Source

```yaml
source:
  plugin: url
  data_fetcher_plugin: http
  data_parser_plugin: json
  urls:
    - 'https://api.example.com/data'
  item_selector: data/items  # JSONPath to items
  fields:
    - name: id
      selector: id
    - name: title
      selector: attributes/title
  ids:
    id:
      type: integer
```

### XML Source

```yaml
source:
  plugin: url
  data_fetcher_plugin: http
  data_parser_plugin: xml
  urls:
    - 'https://example.com/feed.xml'
  item_selector: /root/item
  fields:
    - name: id
      selector: '@id'
    - name: title
      selector: title
```

### Database Source (D7)

```yaml
source:
  plugin: d7_node
  node_type: article
```

### SQL Source

```yaml
source:
  plugin: embedded_data
  data_rows:
    - { id: 1, title: 'First' }
    - { id: 2, title: 'Second' }
  ids:
    id:
      type: integer
```

---

## Process Plugins

### Direct Copy

```yaml
process:
  title: title  # source → destination
```

### Get (Extract from array)

```yaml
process:
  title:
    plugin: get
    source: data/title
```

### Default Value

```yaml
process:
  type:
    plugin: default_value
    default_value: article
```

### Static Map

```yaml
process:
  status:
    plugin: static_map
    source: published
    map:
      'yes': 1
      'no': 0
    default_value: 0
```

### Migration Lookup

```yaml
process:
  field_author:
    plugin: migration_lookup
    migration: users
    source: author_id
```

### Sub Process

```yaml
process:
  field_tags:
    plugin: sub_process
    source: tags
    process:
      target_id:
        plugin: migration_lookup
        migration: tags
        source: id
```

### Concat

```yaml
process:
  name:
    plugin: concat
    source:
      - first_name
      - last_name
    delimiter: ' '
```

### Format Date

```yaml
process:
  created:
    plugin: format_date
    source: date
    from_format: 'Y-m-d\TH:i:s'
    to_format: 'U'  # Unix timestamp
```

### Callback

```yaml
process:
  body:
    plugin: callback
    callable: strip_tags
    source: html_body
```

### Skip Row

```yaml
process:
  _skip:
    plugin: skip_on_empty
    source: title
    method: row
```

### Multiple Plugins (Pipeline)

```yaml
process:
  body/value:
    - plugin: get
      source: content
    - plugin: callback
      callable: strip_tags
    - plugin: substr
      start: 0
      length: 255
```

---

## Destination Plugins

### Node

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

### User

```yaml
destination:
  plugin: entity:user
```

### Taxonomy Term

```yaml
destination:
  plugin: entity:taxonomy_term
  default_bundle: tags
```

### Media

```yaml
destination:
  plugin: entity:media
  default_bundle: image
```

### File

```yaml
destination:
  plugin: entity:file
```

---

## Migration Groups

```yaml
# migrate_plus.migration_group.my_group.yml
id: my_group
label: 'My Migration Group'
description: 'Migrations for my project'
source_type: 'External API'
shared_configuration:
  source:
    constants:
      base_url: 'https://api.example.com'
```

---

## Migration Dependencies

```yaml
migration_dependencies:
  required:
    - users        # Must complete first
    - taxonomy
  optional:
    - related_content  # Nice to have
```

---

## Drush Commands

```bash
# Status
ddev drush migrate:status

# Import
ddev drush migrate:import <migration_id>
ddev drush migrate:import --group=<group>
ddev drush migrate:import --all

# Options
ddev drush migrate:import <id> --limit=10
ddev drush migrate:import <id> --update
ddev drush migrate:import <id> --sync

# Rollback
ddev drush migrate:rollback <migration_id>
ddev drush migrate:rollback --group=<group>

# Reset
ddev drush migrate:reset-status <migration_id>

# Messages
ddev drush migrate:messages <migration_id>
```

---

## Debugging

### Verbose Output

```bash
ddev drush migrate:import <id> -vvv
```

### Single Item

```bash
ddev drush migrate:import <id> --limit=1
```

### Check Source

```bash
ddev drush php:eval "
  \$manager = \Drupal::service('plugin.manager.migration');
  \$migration = \$manager->createInstance('<id>');
  \$source = \$migration->getSourcePlugin();
  \$source->rewind();
  print_r(\$source->current()->getSource());
"
```

---

## Best Practices

1. **Start with data analysis** - Understand source before mapping
2. **Migrate references first** - Users, taxonomy, then content
3. **Use groups** - Organize related migrations
4. **Test incrementally** - Small batches first
5. **Handle failures** - Check messages after each run
