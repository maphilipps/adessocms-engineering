# Create Custom Service

## Required Reading
Before starting, load:
- `../references/service-container.md` - Dependency injection
- `../references/coding-standards.md` - Drupal standards

---

## Input Gathering

Ask user:
1. **Module name**: Which module should contain the service?
2. **Service purpose**: What does it do?
3. **Dependencies**: What services does it need?
4. **Public or internal**: Exposed to other modules or internal use?

---

## Process

### Step 1: Generate Service

```bash
ddev drush generate service:custom
```

Follow prompts for:
- Module
- Service name
- Class name
- Inject services

### Step 2: Manual Creation

#### Service Class

Create `src/<ServiceName>.php`:

```php
<?php

declare(strict_types=1);

namespace Drupal\<module>;

use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;
use Drupal\Core\StringTranslation\StringTranslationTrait;

/**
 * Service description.
 */
final class <ServiceName> {

  use StringTranslationTrait;

  /**
   * Constructs the service.
   *
   * @param \Drupal\Core\Entity\EntityTypeManagerInterface $entityTypeManager
   *   The entity type manager.
   * @param \Drupal\Core\Logger\LoggerChannelFactoryInterface $loggerFactory
   *   The logger factory.
   */
  public function __construct(
    private readonly EntityTypeManagerInterface $entityTypeManager,
    private readonly LoggerChannelFactoryInterface $loggerFactory,
  ) {}

  /**
   * Example method.
   *
   * @param int $id
   *   The entity ID.
   *
   * @return \Drupal\Core\Entity\EntityInterface|null
   *   The entity or NULL.
   */
  public function loadEntity(int $id): ?EntityInterface {
    return $this->entityTypeManager
      ->getStorage('node')
      ->load($id);
  }

}
```

#### Service Definition

In `<module>.services.yml`:

```yaml
services:
  <module>.<service_name>:
    class: Drupal\<module>\<ServiceName>
    arguments:
      - '@entity_type.manager'
      - '@logger.factory'
```

---

## Common Dependencies

| Service | Purpose |
|---------|---------|
| `@entity_type.manager` | CRUD operations on entities |
| `@database` | Direct database access |
| `@cache.default` | Caching |
| `@logger.factory` | Logging |
| `@current_user` | Current user account |
| `@request_stack` | HTTP request |
| `@module_handler` | Module operations |
| `@event_dispatcher` | Event system |
| `@messenger` | User messages |
| `@config.factory` | Configuration |
| `@language_manager` | Language handling |

---

## Service Types

### Factory Service

```yaml
services:
  <module>.my_factory:
    class: Drupal\<module>\MyFactory
    arguments:
      - '@entity_type.manager'

  <module>.my_object:
    class: Drupal\<module>\MyObject
    factory: ['@<module>.my_factory', 'create']
```

### Tagged Service

```yaml
services:
  <module>.my_subscriber:
    class: Drupal\<module>\EventSubscriber\MySubscriber
    tags:
      - { name: event_subscriber }
```

### Lazy Service

```yaml
services:
  <module>.heavy_service:
    class: Drupal\<module>\HeavyService
    lazy: true
```

---

## Using the Service

### In Controller

```php
public static function create(ContainerInterface $container) {
  return new static(
    $container->get('<module>.<service_name>')
  );
}
```

### In Form

```php
public static function create(ContainerInterface $container) {
  $instance = parent::create($container);
  $instance->myService = $container->get('<module>.<service_name>');
  return $instance;
}
```

### In Preprocess (Avoid if possible)

```php
function <module>_preprocess_node(&$variables) {
  $service = \Drupal::service('<module>.<service_name>');
}
```

---

## Verification

```bash
# Rebuild cache
ddev drush cr

# Check service exists
ddev drush devel:services | grep <module>

# Test instantiation
ddev drush php:eval "print_r(\Drupal::service('<module>.<service_name>'));"
```

---

## Anti-Patterns

❌ **NEVER** use `\Drupal::service()` in classes that support DI
❌ **NEVER** inject the container directly
❌ **NEVER** create services with hard dependencies on other modules without checking
❌ **NEVER** skip docblocks for constructor arguments

---

## Success Criteria

- [ ] Service appears in `ddev drush devel:services`
- [ ] Dependencies properly injected
- [ ] Methods documented with proper PHPDoc
- [ ] PHPCS passes with no errors
