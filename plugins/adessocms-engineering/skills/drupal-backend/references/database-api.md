# Database API Reference

## Database Connection

```php
// Get connection
$connection = \Drupal::database();

// With DI (preferred)
public function __construct(
  private readonly Connection $database,
) {}
```

---

## Select Queries

### Basic Select

```php
$result = $connection->select('node_field_data', 'n')
  ->fields('n', ['nid', 'title'])
  ->condition('type', 'article')
  ->condition('status', 1)
  ->orderBy('created', 'DESC')
  ->range(0, 10)
  ->execute();

foreach ($result as $record) {
  $nid = $record->nid;
  $title = $record->title;
}
```

### Join

```php
$query = $connection->select('node_field_data', 'n');
$query->join('users_field_data', 'u', 'n.uid = u.uid');
$query->fields('n', ['nid', 'title']);
$query->fields('u', ['name']);
$query->condition('n.status', 1);

$result = $query->execute();
```

### Left Join

```php
$query = $connection->select('node_field_data', 'n');
$query->leftJoin('node__field_tags', 't', 'n.nid = t.entity_id');
```

### Aggregate

```php
$query = $connection->select('node_field_data', 'n');
$query->addExpression('COUNT(nid)', 'count');
$query->condition('type', 'article');
$count = $query->execute()->fetchField();
```

---

## Condition Operators

```php
// Equal (default)
->condition('status', 1)

// Not equal
->condition('status', 0, '<>')

// Greater than
->condition('created', $timestamp, '>')

// LIKE
->condition('title', '%search%', 'LIKE')

// IN
->condition('type', ['article', 'page'], 'IN')

// NOT IN
->condition('nid', [1, 2, 3], 'NOT IN')

// IS NULL
->isNull('field_name')

// IS NOT NULL
->isNotNull('field_name')

// BETWEEN
->condition('created', [$start, $end], 'BETWEEN')
```

### OR Conditions

```php
$orGroup = $query->orConditionGroup()
  ->condition('type', 'article')
  ->condition('type', 'page');

$query->condition($orGroup);
```

---

## Insert Queries

### Single Insert

```php
$connection->insert('my_table')
  ->fields([
    'name' => 'value',
    'created' => \Drupal::time()->getRequestTime(),
  ])
  ->execute();
```

### Multiple Insert

```php
$query = $connection->insert('my_table')
  ->fields(['name', 'value']);

foreach ($items as $item) {
  $query->values([
    'name' => $item['name'],
    'value' => $item['value'],
  ]);
}

$query->execute();
```

---

## Update Queries

```php
$connection->update('my_table')
  ->fields(['status' => 0])
  ->condition('id', $id)
  ->execute();
```

---

## Delete Queries

```php
$connection->delete('my_table')
  ->condition('id', $id)
  ->execute();
```

---

## Merge (Upsert)

```php
$connection->merge('my_table')
  ->key('id', $id)
  ->fields([
    'name' => 'value',
    'updated' => \Drupal::time()->getRequestTime(),
  ])
  ->execute();
```

---

## Transactions

```php
$transaction = $connection->startTransaction();

try {
  $connection->insert('table1')->fields($data1)->execute();
  $connection->insert('table2')->fields($data2)->execute();
}
catch (\Exception $e) {
  $transaction->rollBack();
  throw $e;
}
```

---

## Raw Queries

### Query (parameterized)

```php
$result = $connection->query(
  "SELECT nid, title FROM {node_field_data} WHERE type = :type",
  [':type' => 'article']
);
```

### Static Query

```php
// Only for truly static queries
$result = $connection->query("SELECT COUNT(*) FROM {node}");
```

---

## Schema API

### Create Table

```php
$schema = $connection->schema();

$table = [
  'description' => 'My custom table',
  'fields' => [
    'id' => [
      'type' => 'serial',
      'unsigned' => TRUE,
      'not null' => TRUE,
    ],
    'name' => [
      'type' => 'varchar',
      'length' => 255,
      'not null' => TRUE,
    ],
    'status' => [
      'type' => 'int',
      'size' => 'tiny',
      'default' => 0,
    ],
    'created' => [
      'type' => 'int',
      'not null' => TRUE,
    ],
  ],
  'primary key' => ['id'],
  'indexes' => [
    'status' => ['status'],
  ],
];

$schema->createTable('my_table', $table);
```

### Modify Table

```php
// Add column
$schema->addField('my_table', 'new_field', [
  'type' => 'varchar',
  'length' => 255,
]);

// Add index
$schema->addIndex('my_table', 'new_field', ['new_field']);

// Drop column
$schema->dropField('my_table', 'old_field');
```

---

## Fetch Methods

```php
$result = $query->execute();

// All rows as array
$rows = $result->fetchAll();

// Single row as object
$row = $result->fetch();

// Single row as associative array
$row = $result->fetchAssoc();

// Single field
$value = $result->fetchField();

// All as key => value
$pairs = $result->fetchAllKeyed();

// All as key => object
$indexed = $result->fetchAllAssoc('id');
```

---

## Best Practices

1. **Use entity queries when possible** - Better abstraction
2. **Always use placeholders** - Prevent SQL injection
3. **Use transactions** - For multi-statement operations
4. **Add indexes** - For frequently queried columns
5. **Avoid SELECT *** - Only fetch needed columns
