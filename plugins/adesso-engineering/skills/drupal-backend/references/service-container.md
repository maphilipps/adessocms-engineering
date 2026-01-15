# Service Container & Dependency Injection

## Core Concept

Services are objects managed by Drupal's service container. Use dependency injection to get services—never call `\Drupal::*` in classes that support DI.

---

## Defining Services

### In `<module>.services.yml`

```yaml
services:
  <module>.my_service:
    class: Drupal\<module>\MyService
    arguments:
      - '@entity_type.manager'
      - '@database'
      - '@logger.factory'
```

---

## Common Services

| Service ID | Interface | Purpose |
|------------|-----------|---------|
| `entity_type.manager` | `EntityTypeManagerInterface` | Entity operations |
| `current_user` | `AccountProxyInterface` | Current user |
| `database` | `Connection` | Database |
| `config.factory` | `ConfigFactoryInterface` | Configuration |
| `logger.factory` | `LoggerChannelFactoryInterface` | Logging |
| `cache.default` | `CacheBackendInterface` | Caching |
| `module_handler` | `ModuleHandlerInterface` | Module operations |
| `event_dispatcher` | `EventDispatcherInterface` | Events |
| `request_stack` | `RequestStack` | HTTP request |
| `messenger` | `MessengerInterface` | User messages |
| `language_manager` | `LanguageManagerInterface` | Languages |
| `path.current` | `CurrentPathStack` | Current path |
| `path_alias.manager` | `AliasManagerInterface` | Path aliases |
| `token` | `Token` | Token replacement |
| `file_system` | `FileSystemInterface` | File operations |

---

## Injection Patterns

### In Services

```php
<?php

namespace Drupal\my_module;

use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\Core\Logger\LoggerChannelFactoryInterface;

final class MyService {

  public function __construct(
    private readonly EntityTypeManagerInterface $entityTypeManager,
    private readonly LoggerChannelFactoryInterface $loggerFactory,
  ) {}

  public function doSomething(): void {
    $storage = $this->entityTypeManager->getStorage('node');
    $this->loggerFactory->get('my_module')->info('Did something');
  }

}
```

### In Controllers

```php
<?php

namespace Drupal\my_module\Controller;

use Drupal\Core\Controller\ControllerBase;
use Drupal\my_module\MyService;
use Symfony\Component\DependencyInjection\ContainerInterface;

final class MyController extends ControllerBase {

  public function __construct(
    private readonly MyService $myService,
  ) {}

  public static function create(ContainerInterface $container): self {
    return new self(
      $container->get('my_module.my_service'),
    );
  }

  public function content(): array {
    return ['#markup' => 'Hello'];
  }

}
```

### In Forms

```php
<?php

namespace Drupal\my_module\Form;

use Drupal\Core\Form\FormBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\my_module\MyService;
use Symfony\Component\DependencyInjection\ContainerInterface;

final class MyForm extends FormBase {

  protected MyService $myService;

  public static function create(ContainerInterface $container): self {
    $instance = parent::create($container);
    $instance->myService = $container->get('my_module.my_service');
    return $instance;
  }

  // ...
}
```

### In Plugins

```php
<?php

namespace Drupal\my_module\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\my_module\MyService;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * @Block(id = "my_block", admin_label = @Translation("My Block"))
 */
final class MyBlock extends BlockBase implements ContainerFactoryPluginInterface {

  public function __construct(
    array $configuration,
    $plugin_id,
    $plugin_definition,
    private readonly MyService $myService,
  ) {
    parent::__construct($configuration, $plugin_id, $plugin_definition);
  }

  public static function create(
    ContainerInterface $container,
    array $configuration,
    $plugin_id,
    $plugin_definition,
  ): self {
    return new self(
      $configuration,
      $plugin_id,
      $plugin_definition,
      $container->get('my_module.my_service'),
    );
  }

  public function build(): array {
    return ['#markup' => 'Block content'];
  }

}
```

---

## Service Tags

### Event Subscriber

```yaml
services:
  my_module.event_subscriber:
    class: Drupal\my_module\EventSubscriber\MySubscriber
    tags:
      - { name: event_subscriber }
```

### Route Subscriber

```yaml
services:
  my_module.route_subscriber:
    class: Drupal\my_module\Routing\RouteSubscriber
    tags:
      - { name: event_subscriber }
```

### Access Check

```yaml
services:
  my_module.access_checker:
    class: Drupal\my_module\Access\MyAccessCheck
    tags:
      - { name: access_check, applies_to: _my_access_check }
```

---

## Service Decoration

```yaml
services:
  my_module.decorated_service:
    class: Drupal\my_module\DecoratedService
    decorates: original_service
    arguments:
      - '@.inner'  # Original service
```

---

## Anti-Patterns

### ❌ Wrong: Static Calls in Classes

```php
// WRONG
public function doSomething() {
  $entity = \Drupal::entityTypeManager()->getStorage('node')->load(1);
}
```

### ✅ Correct: Injected Dependencies

```php
// CORRECT
public function __construct(
  private readonly EntityTypeManagerInterface $entityTypeManager,
) {}

public function doSomething() {
  $entity = $this->entityTypeManager->getStorage('node')->load(1);
}
```

---

## When Static Calls Are OK

1. **`.module` files** - Hooks don't support DI
2. **`.theme` files** - Preprocess functions
3. **One-off scripts** - Drush commands without container
4. **Procedural code** - Legacy code being migrated
