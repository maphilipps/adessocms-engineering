# Plugin API Reference

## Plugin Concept

Plugins are swappable pieces of functionality discovered via annotations or YAML. Each plugin type has:
- **Manager** - Discovers and instantiates plugins
- **Interface** - Contract plugins must implement
- **Base class** - Common functionality
- **Annotation** - Metadata for discovery

---

## Creating a Plugin Type

### Plugin Manager

```php
<?php

namespace Drupal\my_module;

use Drupal\Core\Cache\CacheBackendInterface;
use Drupal\Core\Extension\ModuleHandlerInterface;
use Drupal\Core\Plugin\DefaultPluginManager;

class MyPluginManager extends DefaultPluginManager {

  public function __construct(
    \Traversable $namespaces,
    CacheBackendInterface $cache_backend,
    ModuleHandlerInterface $module_handler,
  ) {
    parent::__construct(
      'Plugin/MyPlugin',              // Subdirectory
      $namespaces,
      $module_handler,
      'Drupal\my_module\MyPluginInterface',  // Interface
      'Drupal\my_module\Annotation\MyPlugin' // Annotation
    );

    $this->setCacheBackend($cache_backend, 'my_plugin_plugins');
  }

}
```

### Annotation

```php
<?php

namespace Drupal\my_module\Annotation;

use Drupal\Component\Annotation\Plugin;

/**
 * @Annotation
 */
class MyPlugin extends Plugin {

  public string $id;
  public string $label;
  public string $description = '';

}
```

### Interface

```php
<?php

namespace Drupal\my_module;

interface MyPluginInterface {

  public function process(): void;

}
```

### Base Class

```php
<?php

namespace Drupal\my_module;

use Drupal\Core\Plugin\PluginBase;

abstract class MyPluginBase extends PluginBase implements MyPluginInterface {

  public function label(): string {
    return $this->pluginDefinition['label'];
  }

}
```

---

## Annotation Discovery

### Plugin Implementation

```php
<?php

namespace Drupal\my_module\Plugin\MyPlugin;

use Drupal\my_module\MyPluginBase;

/**
 * @MyPlugin(
 *   id = "example",
 *   label = @Translation("Example"),
 *   description = @Translation("An example plugin.")
 * )
 */
class Example extends MyPluginBase {

  public function process(): void {
    // Implementation
  }

}
```

---

## YAML Discovery

Alternative to annotations for simpler plugins:

### `<module>.my_plugins.yml`

```yaml
example:
  label: 'Example'
  description: 'An example plugin'
  class: Drupal\my_module\Plugin\MyPlugin\Example
```

---

## Using Plugins

### Get All Definitions

```php
$definitions = \Drupal::service('plugin.manager.my_plugin')->getDefinitions();
```

### Create Instance

```php
$manager = \Drupal::service('plugin.manager.my_plugin');
$plugin = $manager->createInstance('example', ['config' => 'value']);
$plugin->process();
```

---

## Configurable Plugins

### With Configuration Form

```php
use Drupal\Core\Plugin\PluginFormInterface;

class ConfigurablePlugin extends MyPluginBase implements PluginFormInterface {

  public function defaultConfiguration(): array {
    return ['setting' => ''];
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    $form['setting'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Setting'),
      '#default_value' => $this->configuration['setting'],
    ];
    return $form;
  }

  public function validateConfigurationForm(array &$form, FormStateInterface $form_state): void {
    // Validation
  }

  public function submitConfigurationForm(array &$form, FormStateInterface $form_state): void {
    $this->configuration['setting'] = $form_state->getValue('setting');
  }

}
```

---

## Plugin with Dependencies

```php
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;

class DependentPlugin extends MyPluginBase implements ContainerFactoryPluginInterface {

  public function __construct(
    array $configuration,
    $plugin_id,
    $plugin_definition,
    private readonly EntityTypeManagerInterface $entityTypeManager,
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
      $container->get('entity_type.manager'),
    );
  }

}
```

---

## Common Plugin Types

| Type | Manager | Use |
|------|---------|-----|
| Block | `plugin.manager.block` | UI blocks |
| Field Type | `plugin.manager.field.field_type` | Custom fields |
| Field Widget | `plugin.manager.field.widget` | Form widgets |
| Field Formatter | `plugin.manager.field.formatter` | Display formatters |
| Queue Worker | `plugin.manager.queue_worker` | Background jobs |
| Condition | `plugin.manager.condition` | Visibility conditions |
| Action | `plugin.manager.action` | Bulk actions |
| Views Plugin | `plugin.manager.views.*` | Views components |

---

## Plugin Derivatives

For dynamic plugin definitions:

```php
use Drupal\Component\Plugin\Derivative\DeriverBase;

class MyDeriver extends DeriverBase {

  public function getDerivativeDefinitions($base_plugin_definition): array {
    foreach ($this->getData() as $id => $data) {
      $this->derivatives[$id] = [
        'label' => $data['label'],
      ] + $base_plugin_definition;
    }
    return $this->derivatives;
  }

}
```

In annotation:
```php
/**
 * @MyPlugin(
 *   id = "base",
 *   deriver = "Drupal\my_module\Plugin\Derivative\MyDeriver"
 * )
 */
```
