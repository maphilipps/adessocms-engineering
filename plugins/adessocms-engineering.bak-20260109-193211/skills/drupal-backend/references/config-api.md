# Configuration API Reference

## Config Types

### Simple Configuration
Single-file settings: `<module>.settings`

### Configuration Entities
Multiple instances: Views, Image Styles, Content Types

---

## Reading Config

### Simple Config

```php
// Immutable (read-only, recommended)
$config = \Drupal::config('my_module.settings');
$value = $config->get('my_key');
$all = $config->getRawData();

// Editable (for writing)
$config = \Drupal::configFactory()->getEditable('my_module.settings');
```

### With DI

```php
public function __construct(
  private readonly ConfigFactoryInterface $configFactory,
) {}

public function getValue(): string {
  return $this->configFactory->get('my_module.settings')->get('key');
}
```

---

## Writing Config

```php
$config = \Drupal::configFactory()->getEditable('my_module.settings');
$config->set('key', 'value');
$config->set('nested.key', 'nested value');
$config->save();

// Multiple values
$config->setData([
  'key1' => 'value1',
  'key2' => 'value2',
])->save();

// Delete key
$config->clear('key')->save();
```

---

## Config Schema

### `config/schema/<module>.schema.yml`

```yaml
my_module.settings:
  type: config_object
  label: 'My Module Settings'
  mapping:
    enabled:
      type: boolean
      label: 'Enable feature'
    max_items:
      type: integer
      label: 'Maximum items'
    api_key:
      type: string
      label: 'API Key'
    options:
      type: sequence
      label: 'Options'
      sequence:
        type: string
```

### Schema Types

| Type | Description |
|------|-------------|
| `string` | Text value |
| `integer` | Whole number |
| `float` | Decimal number |
| `boolean` | True/false |
| `uri` | URI/URL |
| `email` | Email address |
| `mapping` | Key-value pairs |
| `sequence` | Ordered list |
| `label` | Translatable label |
| `text` | Long translatable text |

---

## Default Config

### `config/install/<module>.<config_name>.yml`

```yaml
# config/install/my_module.settings.yml
enabled: true
max_items: 10
api_key: ''
options: []
```

Installed when module is enabled.

---

## Config Forms

```php
<?php

namespace Drupal\my_module\Form;

use Drupal\Core\Form\ConfigFormBase;
use Drupal\Core\Form\FormStateInterface;

class SettingsForm extends ConfigFormBase {

  protected function getEditableConfigNames(): array {
    return ['my_module.settings'];
  }

  public function getFormId(): string {
    return 'my_module_settings';
  }

  public function buildForm(array $form, FormStateInterface $form_state): array {
    $config = $this->config('my_module.settings');

    $form['enabled'] = [
      '#type' => 'checkbox',
      '#title' => $this->t('Enable feature'),
      '#default_value' => $config->get('enabled'),
    ];

    $form['max_items'] = [
      '#type' => 'number',
      '#title' => $this->t('Maximum items'),
      '#default_value' => $config->get('max_items'),
      '#min' => 1,
    ];

    return parent::buildForm($form, $form_state);
  }

  public function submitForm(array &$form, FormStateInterface $form_state): void {
    $this->config('my_module.settings')
      ->set('enabled', $form_state->getValue('enabled'))
      ->set('max_items', $form_state->getValue('max_items'))
      ->save();

    parent::submitForm($form, $form_state);
  }

}
```

---

## Config Overrides

### settings.php

```php
// Override any config
$config['system.site']['name'] = 'Development Site';
$config['system.logging']['error_level'] = 'verbose';

// Environment-specific
if (getenv('APP_ENV') === 'production') {
  $config['system.performance']['css']['preprocess'] = TRUE;
  $config['system.performance']['js']['preprocess'] = TRUE;
}
```

### Per-Language Overrides

Automatically handled by config translation module.

---

## Config Dependencies

### In YAML

```yaml
# config/install/my_module.my_config.yml
dependencies:
  config:
    - node.type.article
  module:
    - node
```

### Enforced Dependencies

```yaml
dependencies:
  enforced:
    module:
      - my_module  # Deleted when module uninstalled
```

---

## Config Events

```php
use Drupal\Core\Config\ConfigEvents;
use Drupal\Core\Config\ConfigCrudEvent;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class ConfigSubscriber implements EventSubscriberInterface {

  public static function getSubscribedEvents(): array {
    return [
      ConfigEvents::SAVE => 'onConfigSave',
      ConfigEvents::DELETE => 'onConfigDelete',
    ];
  }

  public function onConfigSave(ConfigCrudEvent $event): void {
    if ($event->getConfig()->getName() === 'my_module.settings') {
      // React to save
    }
  }

}
```

---

## Best Practices

1. **Use schema** - Validate config structure
2. **Provide defaults** - Install config with sensible values
3. **Use ConfigFormBase** - For settings forms
4. **Avoid runtime overrides** - Use settings.php sparingly
5. **Document dependencies** - Declare in YAML
