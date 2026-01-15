# Common Plugin Patterns

## Block Plugin

### Full Example

```php
<?php

namespace Drupal\my_module\Plugin\Block;

use Drupal\Core\Block\BlockBase;
use Drupal\Core\Cache\Cache;
use Drupal\Core\Entity\EntityTypeManagerInterface;
use Drupal\Core\Form\FormStateInterface;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * Provides a 'Featured Content' block.
 *
 * @Block(
 *   id = "my_module_featured_content",
 *   admin_label = @Translation("Featured Content"),
 *   category = @Translation("Content")
 * )
 */
final class FeaturedContentBlock extends BlockBase implements ContainerFactoryPluginInterface {

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

  public function defaultConfiguration(): array {
    return [
      'count' => 3,
      'content_type' => 'article',
    ];
  }

  public function blockForm($form, FormStateInterface $form_state): array {
    $form['count'] = [
      '#type' => 'number',
      '#title' => $this->t('Number of items'),
      '#default_value' => $this->configuration['count'],
      '#min' => 1,
      '#max' => 10,
    ];

    return $form;
  }

  public function blockSubmit($form, FormStateInterface $form_state): void {
    $this->configuration['count'] = $form_state->getValue('count');
  }

  public function build(): array {
    $storage = $this->entityTypeManager->getStorage('node');
    $nids = $storage->getQuery()
      ->accessCheck(TRUE)
      ->condition('type', $this->configuration['content_type'])
      ->condition('status', 1)
      ->sort('created', 'DESC')
      ->range(0, $this->configuration['count'])
      ->execute();

    $nodes = $storage->loadMultiple($nids);

    return [
      '#theme' => 'item_list',
      '#items' => array_map(fn($node) => $node->toLink(), $nodes),
      '#cache' => [
        'tags' => ['node_list'],
        'contexts' => ['user.permissions'],
      ],
    ];
  }

  public function getCacheTags(): array {
    return Cache::mergeTags(parent::getCacheTags(), ['node_list']);
  }

  public function getCacheContexts(): array {
    return Cache::mergeContexts(parent::getCacheContexts(), ['user.permissions']);
  }

}
```

---

## Field Formatter

### Example: Custom Link Formatter

```php
<?php

namespace Drupal\my_module\Plugin\Field\FieldFormatter;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Field\FormatterBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @FieldFormatter(
 *   id = "my_module_styled_link",
 *   label = @Translation("Styled Link"),
 *   field_types = {"link"}
 * )
 */
final class StyledLinkFormatter extends FormatterBase {

  public static function defaultSettings(): array {
    return [
      'class' => 'btn btn-primary',
    ] + parent::defaultSettings();
  }

  public function settingsForm(array $form, FormStateInterface $form_state): array {
    $form['class'] = [
      '#type' => 'textfield',
      '#title' => $this->t('CSS Class'),
      '#default_value' => $this->getSetting('class'),
    ];
    return $form;
  }

  public function settingsSummary(): array {
    return [$this->t('Class: @class', ['@class' => $this->getSetting('class')])];
  }

  public function viewElements(FieldItemListInterface $items, $langcode): array {
    $elements = [];

    foreach ($items as $delta => $item) {
      $elements[$delta] = [
        '#type' => 'link',
        '#title' => $item->title ?: $item->uri,
        '#url' => $item->getUrl(),
        '#attributes' => [
          'class' => explode(' ', $this->getSetting('class')),
        ],
      ];
    }

    return $elements;
  }

}
```

---

## Field Widget

### Example: Color Picker Widget

```php
<?php

namespace Drupal\my_module\Plugin\Field\FieldWidget;

use Drupal\Core\Field\FieldItemListInterface;
use Drupal\Core\Field\WidgetBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @FieldWidget(
 *   id = "my_module_color_picker",
 *   label = @Translation("Color Picker"),
 *   field_types = {"string"}
 * )
 */
final class ColorPickerWidget extends WidgetBase {

  public function formElement(
    FieldItemListInterface $items,
    $delta,
    array $element,
    array &$form,
    FormStateInterface $form_state,
  ): array {
    $element['value'] = [
      '#type' => 'color',
      '#title' => $element['#title'],
      '#default_value' => $items[$delta]->value ?? '#000000',
      '#description' => $element['#description'],
      '#required' => $element['#required'],
    ];

    return $element;
  }

}
```

---

## Queue Worker

### Example: Email Queue

```php
<?php

namespace Drupal\my_module\Plugin\QueueWorker;

use Drupal\Core\Mail\MailManagerInterface;
use Drupal\Core\Plugin\ContainerFactoryPluginInterface;
use Drupal\Core\Queue\QueueWorkerBase;
use Drupal\Core\Queue\SuspendQueueException;
use Symfony\Component\DependencyInjection\ContainerInterface;

/**
 * @QueueWorker(
 *   id = "my_module_email_queue",
 *   title = @Translation("Email Queue"),
 *   cron = {"time" = 30}
 * )
 */
final class EmailQueueWorker extends QueueWorkerBase implements ContainerFactoryPluginInterface {

  public function __construct(
    array $configuration,
    $plugin_id,
    $plugin_definition,
    private readonly MailManagerInterface $mailManager,
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
      $container->get('plugin.manager.mail'),
    );
  }

  public function processItem($data): void {
    $result = $this->mailManager->mail(
      'my_module',
      'notification',
      $data['to'],
      $data['langcode'],
      $data['params'],
    );

    if (!$result['result']) {
      // Throw to requeue
      throw new \Exception('Mail sending failed');
    }
  }

}
```

### Adding to Queue

```php
$queue = \Drupal::queue('my_module_email_queue');
$queue->createItem([
  'to' => 'user@example.com',
  'langcode' => 'en',
  'params' => ['subject' => 'Hello', 'body' => 'Content'],
]);
```

---

## Condition Plugin

### Example: User Role Condition

```php
<?php

namespace Drupal\my_module\Plugin\Condition;

use Drupal\Core\Condition\ConditionPluginBase;
use Drupal\Core\Form\FormStateInterface;

/**
 * @Condition(
 *   id = "my_module_has_role",
 *   label = @Translation("User has role")
 * )
 */
final class HasRoleCondition extends ConditionPluginBase {

  public function defaultConfiguration(): array {
    return ['roles' => []] + parent::defaultConfiguration();
  }

  public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
    $form['roles'] = [
      '#type' => 'checkboxes',
      '#title' => $this->t('Roles'),
      '#options' => user_role_names(TRUE),
      '#default_value' => $this->configuration['roles'],
    ];
    return parent::buildConfigurationForm($form, $form_state);
  }

  public function submitConfigurationForm(array &$form, FormStateInterface $form_state): void {
    $this->configuration['roles'] = array_filter($form_state->getValue('roles'));
    parent::submitConfigurationForm($form, $form_state);
  }

  public function evaluate(): bool {
    if (empty($this->configuration['roles'])) {
      return TRUE;
    }

    $user = \Drupal::currentUser();
    return (bool) array_intersect($this->configuration['roles'], $user->getRoles());
  }

  public function summary(): string {
    return $this->t('User has role: @roles', [
      '@roles' => implode(', ', $this->configuration['roles']),
    ]);
  }

}
```
