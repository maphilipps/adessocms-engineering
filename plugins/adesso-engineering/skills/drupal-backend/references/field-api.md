# Field API Reference

## Field Architecture

```
Field Storage (field.storage.*)
    ↓
Field Instance (field.field.*)
    ↓
Widget (form display)
    ↓
Formatter (view display)
```

---

## Common Field Types

| Type | Class | Use Case |
|------|-------|----------|
| `string` | StringItem | Short text (255) |
| `string_long` | StringLongItem | Long unformatted text |
| `text` | TextItem | Formatted text (255) |
| `text_long` | TextLongItem | Long formatted text |
| `text_with_summary` | TextWithSummaryItem | Body with teaser |
| `boolean` | BooleanItem | Yes/No |
| `integer` | IntegerItem | Whole numbers |
| `decimal` | DecimalItem | Precise decimals |
| `float` | FloatItem | Floating point |
| `email` | EmailItem | Email addresses |
| `link` | LinkItem | URLs |
| `entity_reference` | EntityReferenceItem | Related entities |
| `entity_reference_revisions` | EntityReferenceRevisionsItem | Paragraphs |
| `image` | ImageItem | Images |
| `file` | FileItem | Files |
| `datetime` | DateTimeItem | Date/time |
| `daterange` | DateRangeItem | Date range |

---

## Field Values

### Get Values

```php
// Simple field
$value = $entity->get('field_name')->value;

// Entity reference
$referenced_entity = $entity->get('field_ref')->entity;
$target_id = $entity->get('field_ref')->target_id;

// Multi-value
foreach ($entity->get('field_tags') as $item) {
  $term = $item->entity;
}

// Image
$uri = $entity->get('field_image')->entity->getFileUri();
$alt = $entity->get('field_image')->alt;

// Link
$url = $entity->get('field_link')->uri;
$title = $entity->get('field_link')->title;
```

### Set Values

```php
// Simple
$entity->set('field_name', 'value');

// Complex
$entity->set('field_body', [
  'value' => '<p>Content</p>',
  'format' => 'full_html',
]);

// Entity reference
$entity->set('field_ref', ['target_id' => 123]);

// Multi-value
$entity->set('field_tags', [
  ['target_id' => 1],
  ['target_id' => 2],
]);
```

---

## Field Definitions

### Programmatic Field Creation

```php
use Drupal\field\Entity\FieldStorageConfig;
use Drupal\field\Entity\FieldConfig;

// Storage (shared across bundles)
FieldStorageConfig::create([
  'field_name' => 'field_example',
  'entity_type' => 'node',
  'type' => 'string',
  'cardinality' => 1,
])->save();

// Instance (per bundle)
FieldConfig::create([
  'field_name' => 'field_example',
  'entity_type' => 'node',
  'bundle' => 'article',
  'label' => 'Example',
  'required' => FALSE,
])->save();
```

---

## Field Formatters

### Common Formatters

| Field Type | Formatter | Output |
|------------|-----------|--------|
| `string` | `string` | Plain text |
| `text_long` | `text_default` | Filtered HTML |
| `entity_reference` | `entity_reference_label` | Linked label |
| `entity_reference` | `entity_reference_entity_view` | Rendered entity |
| `image` | `image` | Image tag |
| `image` | `image_url` | URL only |
| `link` | `link` | Clickable link |
| `datetime` | `datetime_default` | Formatted date |

---

## Field Widgets

### Common Widgets

| Field Type | Widget | UI |
|------------|--------|-----|
| `string` | `string_textfield` | Text input |
| `text_long` | `text_textarea` | Textarea |
| `boolean` | `boolean_checkbox` | Checkbox |
| `entity_reference` | `entity_reference_autocomplete` | Autocomplete |
| `entity_reference` | `options_select` | Dropdown |
| `image` | `image_image` | File upload with preview |
| `datetime` | `datetime_default` | Date picker |

---

## Field Display Configuration

### Form Display

```php
// Get form display
$form_display = \Drupal::entityTypeManager()
  ->getStorage('entity_form_display')
  ->load('node.article.default');

// Set component
$form_display->setComponent('field_name', [
  'type' => 'string_textfield',
  'weight' => 10,
  'settings' => [],
])->save();
```

### View Display

```php
// Get view display
$view_display = \Drupal::entityTypeManager()
  ->getStorage('entity_view_display')
  ->load('node.article.default');

// Set component
$view_display->setComponent('field_name', [
  'type' => 'string',
  'weight' => 10,
  'label' => 'above',
  'settings' => [],
])->save();
```

---

## Base Fields vs Bundle Fields

### Base Field (in entity class)

```php
public static function baseFieldDefinitions(EntityTypeInterface $entity_type) {
  $fields['title'] = BaseFieldDefinition::create('string')
    ->setLabel(t('Title'))
    ->setRequired(TRUE)
    ->setDisplayOptions('form', [
      'type' => 'string_textfield',
      'weight' => 0,
    ]);

  return $fields;
}
```

### Bundle Field (config entity)

Created via UI or config YAML (see workflows).

---

## Best Practices

1. **Use appropriate field types** - Don't store numbers as strings
2. **Set cardinality correctly** - 1 for single, -1 for unlimited
3. **Configure displays** - Don't rely on defaults
4. **Use entity references** - Not storing IDs in text fields
5. **Consider translations** - Mark translatable fields
