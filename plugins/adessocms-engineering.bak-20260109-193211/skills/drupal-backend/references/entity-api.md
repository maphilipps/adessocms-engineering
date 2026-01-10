# Entity API Reference

## Entity Types

### Content Entities (Fieldable)
- **Node** - Main content
- **Paragraph** - Reusable content blocks
- **Media** - Media assets
- **User** - User accounts
- **Taxonomy Term** - Categorization

### Configuration Entities
- **View** - Views configuration
- **Block** - Block placement
- **Image Style** - Image processing
- **Field Storage/Instance** - Field definitions

---

## Entity Type Manager

```php
// Get service
$entityTypeManager = \Drupal::entityTypeManager();

// Get storage
$storage = $entityTypeManager->getStorage('node');

// Get definition
$definition = $entityTypeManager->getDefinition('node');
```

---

## CRUD Operations

### Create

```php
$node = Node::create([
  'type' => 'article',
  'title' => 'My Title',
  'body' => [
    'value' => '<p>Body content</p>',
    'format' => 'full_html',
  ],
]);
$node->save();
```

### Read

```php
// Load single
$node = Node::load($nid);

// Load multiple
$nodes = Node::loadMultiple([1, 2, 3]);

// Query
$nids = \Drupal::entityQuery('node')
  ->condition('type', 'article')
  ->condition('status', 1)
  ->accessCheck(TRUE)
  ->execute();
```

### Update

```php
$node = Node::load($nid);
$node->set('title', 'New Title');
$node->save();
```

### Delete

```php
$node = Node::load($nid);
$node->delete();

// Multiple
$storage = \Drupal::entityTypeManager()->getStorage('node');
$nodes = $storage->loadMultiple($nids);
$storage->delete($nodes);
```

---

## Entity Query

```php
$query = \Drupal::entityQuery('node')
  ->accessCheck(TRUE)  // REQUIRED in Drupal 10+
  ->condition('type', 'article')
  ->condition('status', 1)
  ->condition('field_tags', 5)  // Entity reference
  ->condition('created', strtotime('-30 days'), '>=')
  ->sort('created', 'DESC')
  ->range(0, 10);

$nids = $query->execute();
```

### Condition Operators

| Operator | Description |
|----------|-------------|
| `=` | Equal (default) |
| `<>` | Not equal |
| `>` | Greater than |
| `>=` | Greater or equal |
| `<` | Less than |
| `<=` | Less or equal |
| `IN` | In array |
| `NOT IN` | Not in array |
| `LIKE` | Pattern match |
| `CONTAINS` | Contains string |
| `STARTS_WITH` | Starts with |
| `ENDS_WITH` | Ends with |
| `BETWEEN` | Between values |

---

## Entity Access

```php
// Check access
if ($node->access('view')) {
  // User can view
}

// With account
if ($node->access('update', $account)) {
  // Account can update
}

// Operations: view, update, delete, create
```

---

## Entity Translation

```php
// Get translation
if ($node->hasTranslation('de')) {
  $node_de = $node->getTranslation('de');
}

// Add translation
$node->addTranslation('de', [
  'title' => 'German Title',
]);
$node->save();
```

---

## Entity Revisions

```php
// Create new revision
$node->setNewRevision(TRUE);
$node->setRevisionLogMessage('Updated content');
$node->setRevisionUserId($current_user->id());
$node->save();

// Load specific revision
$node = $storage->loadRevision($revision_id);

// Get all revision IDs
$vids = $storage->revisionIds($node);
```

---

## Best Practices

1. **Always use accessCheck(TRUE)** in entity queries
2. **Use dependency injection** for EntityTypeManager
3. **Batch large operations** to avoid memory issues
4. **Handle translations** properly
5. **Set revision metadata** when saving revisions
