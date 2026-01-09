# Create Plugin

## Required Reading
Before starting, load:
- `../references/plugin-api.md` - Plugin system fundamentals
- `../references/common-plugins.md` - Block, Field, QueueWorker patterns

---

## Input Gathering

Ask user:
1. **Plugin type**: Block, Field Formatter, Field Widget, QueueWorker, etc.?
2. **Module name**: Which module?
3. **Plugin purpose**: What does it do?
4. **Configuration**: Does it need settings?

---

## Process

### Block Plugin

```bash
ddev drush generate plugin:block
```

Or manually:

```php
<?php

declare(strict_types=1);

namespace Drupal\<module>\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Provides a '<name>' block.
 *
 * @Block(
 *   id = "<module>_<name>",
 *   admin_label = @Translation("<Name>"),
 *   category = @Translation("<Category>")
 * )
 */
final class <Name>Block extends BlockBase implements ContainerFactoryPluginInterface {

  /**
   * {@inheritdoc}
   */
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
    );
  }

  /**
   * {@inheritdoc}
   */
  public function defaultConfiguration(): array {
    return [
      'example_setting' => '',
    ] + parent::defaultConfiguration();
  }

  /**
   * {@inheritdoc}
   */
  public function blockForm($form, FormStateInterface $form_state): array {
    $form['example_setting'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Example'),
      '#default_value' => $this->configuration['example_setting'],
    ];
    return $form;
  }

  /**
   * {@inheritdoc}
   */
  public function blockSubmit($form, FormStateInterface $form_state): void {
    $this->configuration['example_setting'] = $form_state->getValue('example_setting');
  }

  /**
   * {@inheritdoc}
   */
  public function build(): array {
    return [
      '#markup' => $this->t('Block content'),
    ];
  }

}
```

---

### Field Formatter

```bash
ddev drush generate plugin:field:formatter
```

```php
<?php

declare(strict_types=1);

namespace Drupal\<module>\Plugin\Field\FieldFormatter;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Field\FormatterBase;

/**
 * Plugin implementation of the '<name>' formatter.
 *
 * @FieldFormatter(
 *   id = "<module>_<name>",
 *   label = @Translation("<Name>"),
 *   field_types = {"string", "text"}
 * )
 */
final class <Name>Formatter extends FormatterBase {

  /**
   * {@inheritdoc}
   */
  public function viewElements(FieldItemListInterface $items, $langcode): array {
    $elements = [];

    foreach ($items as $delta => $item) {
      $elements[$delta] = [
        '#markup' => $item->value,
      ];
    }

    return $elements;
  }

}
```

---

### Field Widget

```bash
ddev drush generate plugin:field:widget
```

```php
<?php

declare(strict_types=1);

namespace Drupal\<module>\Plugin\Field\FieldWidget;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Field\WidgetBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * Plugin implementation of the '<name>' widget.
 *
 * @FieldWidget(
 *   id = "<module>_<name>",
 *   label = @Translation("<Name>"),
 *   field_types = {"string"}
 * )
 */
final class <Name>Widget extends WidgetBase {

  /**
   * {@inheritdoc}
   */
  public function formElement(
    FieldItemListInterface $items,
    $delta,
    array $element,
    array &$form,
    FormStateInterface $form_state,
  ): array {
    $element['value'] = [
      '#type' => 'textfield',
      '#title' => $this->t('Value'),
      '#default_value' => $items[$delta]->value ?? '',
    ] + $element;

    return $element;
  }

}
```

---

### Queue Worker

```bash
ddev drush generate plugin:queue-worker
```

```php
<?php

declare(strict_types=1);

namespace Drupal\<module>\Plugin\QueueWorker;

use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\Core\Queue\QueueWorkerBase;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Processes <name> queue items.
 *
 * @QueueWorker(
 *   id = "<module>_<name>",
 *   title = @Translation("<Name> Worker"),
 *   cron = {"time" = 60}
 * )
 */
final class <Name>QueueWorker extends QueueWorkerBase implements ContainerFactoryPluginInterface {

  /**
   * {@inheritdoc}
   */
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
    );
  }

  /**
   * {@inheritdoc}
   */
  public function processItem($data): void {
    // Process the queue item.
  }

}
```

---

## Plugin Discovery

| Type | Annotation | Base Class |
|------|------------|------------|
| Block | `@Block` | `BlockBase` |
| Field Formatter | `@FieldFormatter` | `FormatterBase` |
| Field Widget | `@FieldWidget` | `WidgetBase` |
| Queue Worker | `@QueueWorker` | `QueueWorkerBase` |
| Action | `@Action` | `ActionBase` |
| Condition | `@Condition` | `ConditionPluginBase` |

---

## Verification

```bash
# Clear cache (required for plugin discovery)
ddev drush cr

# List plugins of type
ddev drush plugin:list block

# Check PHPCS
ddev exec phpcs --standard=Drupal,DrupalPractice web/modules/custom/<module>/src/Plugin
```

---

## Success Criteria

- [ ] Plugin discovered after cache clear
- [ ] Plugin appears in admin UI (if applicable)
- [ ] Configuration saves correctly
- [ ] PHPCS passes
