# Drupal Coding Standards Reference

## PHPCS Setup

```bash
# Install standards
ddev composer require --dev drupal/coder
ddev composer require --dev squizlabs/php_codesniffer

# Check code
ddev exec phpcs --standard=Drupal,DrupalPractice web/modules/custom/<module>

# Fix automatically
ddev exec phpcbf --standard=Drupal,DrupalPractice web/modules/custom/<module>
```

---

## PHP Standards

### Class Structure

```php
<?php

declare(strict_types=1);

namespace Drupal\my_module;

use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\Core\StringTranslation\StringTranslationTrait;

/**
 * Service description goes here.
 *
 * Longer description if needed, explaining what the
 * service does and how it should be used.
 */
final class MyService {

  use StringTranslationTrait;

  /**
   * Constructs a MyService object.
   *
   * @param \Drupal\Core\Entity\EntityTypeManagerInterface $entityTypeManager
   *   The entity type manager.
   */
  public function __construct(
    private readonly EntityTypeManagerInterface $entityTypeManager,
  ) {}

  /**
   * Loads a node by ID.
   *
   * @param int $nid
   *   The node ID.
   *
   * @return \Drupal\node\NodeInterface|null
   *   The node entity, or NULL if not found.
   */
  public function loadNode(int $nid): ?NodeInterface {
    return $this->entityTypeManager->getStorage('node')->load($nid);
  }

}
```

### Naming Conventions

| Element | Convention | Example |
|---------|------------|---------|
| Class | PascalCase | `MyCustomService` |
| Method | camelCase | `loadNode()` |
| Variable | snake_case | `$node_ids` |
| Constant | UPPER_SNAKE | `MY_CONSTANT` |
| Function | snake_case | `my_module_function()` |
| Hook | snake_case | `my_module_node_insert()` |
| Property | camelCase | `$entityTypeManager` |

---

## DocBlocks

### Class DocBlock

```php
/**
 * Provides a service for handling nodes.
 *
 * This service encapsulates common node operations
 * used throughout the module.
 */
class NodeService {
```

### Method DocBlock

```php
/**
 * Loads nodes by type.
 *
 * @param string $type
 *   The node type machine name.
 * @param int $limit
 *   (optional) Maximum number of nodes to return. Defaults to 10.
 *
 * @return \Drupal\node\NodeInterface[]
 *   An array of node entities.
 *
 * @throws \InvalidArgumentException
 *   If the node type doesn't exist.
 */
public function loadByType(string $type, int $limit = 10): array {
```

### Property DocBlock

```php
/**
 * The entity type manager.
 *
 * @var \Drupal\Core\Entity\EntityTypeManagerInterface
 */
protected EntityTypeManagerInterface $entityTypeManager;
```

---

## Array Syntax

### Short Array Syntax

```php
// CORRECT
$array = [
  'key' => 'value',
  'nested' => [
    'a' => 1,
    'b' => 2,
  ],
];

// WRONG
$array = array(
  'key' => 'value',
);
```

### Trailing Commas

```php
// CORRECT - trailing comma for multi-line
$array = [
  'one',
  'two',
  'three',
];

// CORRECT - no trailing comma for single line
$array = ['one', 'two', 'three'];
```

---

## Control Structures

### If/Else

```php
// Correct spacing
if ($condition) {
  // Code.
}
elseif ($other) {
  // Code.
}
else {
  // Code.
}

// Early return preferred
public function process($item): void {
  if (!$item) {
    return;
  }

  // Main logic here.
}
```

### Switch

```php
switch ($value) {
  case 'one':
    doSomething();
    break;

  case 'two':
    doSomethingElse();
    break;

  default:
    handleDefault();
}
```

### Ternary

```php
// Short, single line OK
$result = $condition ? $value1 : $value2;

// Longer - use if/else instead
```

---

## Type Declarations

### PHP 8+ Style

```php
// Constructor property promotion
public function __construct(
  private readonly EntityTypeManagerInterface $entityTypeManager,
  private readonly LoggerChannelFactoryInterface $loggerFactory,
) {}

// Return types
public function load(int $id): ?EntityInterface {
  return $this->storage->load($id);
}

// Nullable types
public function setOwner(?UserInterface $user): void {
  $this->owner = $user;
}

// Union types
public function getValue(): int|string {
  return $this->value;
}
```

---

## Translations

### t() Function

```php
// Simple
$message = $this->t('Hello world');

// With placeholders
$message = $this->t('Hello @name', ['@name' => $username]);

// Placeholder types
// @ - plain text (auto-escaped)
// % - emphasized (wrapped in <em>)
// :count - for plurals
```

### Plural

```php
$message = $this->formatPlural(
  $count,
  '1 item',
  '@count items'
);
```

---

## Module Structure

```
my_module/
├── my_module.info.yml
├── my_module.module
├── my_module.install
├── my_module.services.yml
├── my_module.routing.yml
├── my_module.permissions.yml
├── my_module.links.menu.yml
├── config/
│   ├── install/
│   └── schema/
├── src/
│   ├── Controller/
│   ├── Form/
│   ├── Plugin/
│   └── Service/
├── templates/
└── tests/
```

---

## Common Issues

### Line Length
- Max 80 characters for code
- Can exceed for strings that shouldn't be broken

### Spacing
- 2 spaces for indentation
- No trailing whitespace
- Single blank line between methods

### Empty Lines
```php
// One blank line between methods
public function methodOne(): void {
  // Code.
}

public function methodTwo(): void {
  // Code.
}
```

---

## Verification

```bash
# Check standards
ddev exec phpcs --standard=Drupal,DrupalPractice \
  web/modules/custom/<module>/src

# Fix issues
ddev exec phpcbf --standard=Drupal,DrupalPractice \
  web/modules/custom/<module>/src

# Check specific sniffs
ddev exec phpcs --sniffs=Drupal.Commenting.DocComment \
  web/modules/custom/<module>
```
