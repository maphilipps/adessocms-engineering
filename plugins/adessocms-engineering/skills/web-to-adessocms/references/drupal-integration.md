# Drupal Integration Guide

How to integrate SDC components with Drupal's data systems.

## Component Include Methods

### Method 1: Direct Include in Template

Best for: Components in existing templates (page.html.twig, node templates)

```twig
{# In page.html.twig #}
{% include 'adesso_cms_theme:site-header' with {
  logo: logo,
  site_name: site_name,
  menu_items: menu_items,
  front_page: front_page,
} %}
```

### Method 2: Template Override for Blocks

Best for: Components replacing Drupal blocks

```twig
{# templates/block/block--system-branding-block.html.twig #}
{% include 'adesso_cms_theme:logo' with {
  logo: content['site_logo']['#uri'],
  site_name: content['site_name']['#markup'],
  front_page: path('<front>'),
} %}
```

### Method 3: Paragraph Type Integration

Best for: Components used as paragraphs in Layout Builder or Paragraphs module

```twig
{# templates/paragraph/paragraph--hero.html.twig #}
{% include 'adesso_cms_theme:hero' with {
  title: content.field_title|render|striptags|trim,
  subtitle: content.field_subtitle|render|striptags|trim,
  image: content.field_image,
  variant: content.field_variant.0['#markup']|default('default'),
  cta_text: content.field_cta_text|render|striptags|trim,
  cta_url: content.field_cta_link.0['#url']|default(''),
} %}
```

## Data Extraction Patterns

### Text Fields

```twig
{# Plain text #}
{{ content.field_title|render|striptags|trim }}

{# With potential HTML #}
{{ content.field_body }}

{# Getting raw value #}
{{ node.field_title.value }}
```

### Link Fields

```twig
{# URL string #}
{{ content.field_link.0['#url']|default('') }}

{# Link title #}
{{ content.field_link.0['#title']|default('') }}

{# Full link object in preprocess #}
$url = $paragraph->field_link->uri;
$title = $paragraph->field_link->title;
```

### Media/Image Fields

```twig
{# Render with image style #}
{{ content.field_image }}

{# Get URL in preprocess #}
$media = $node->field_image->entity;
$file = $media->field_media_image->entity;
$url = $file->createFileUrl();
```

### Reference Fields (Entity Reference)

```twig
{# Render referenced entities #}
{{ content.field_items }}

{# Access in preprocess #}
foreach ($node->field_items as $item) {
  $referenced_entity = $item->entity;
  $title = $referenced_entity->label();
}
```

### Select/List Fields

```twig
{# Get selected value #}
{{ content.field_variant.0['#markup'] }}

{# In preprocess #}
$variant = $node->field_variant->value;
```

## Preprocess Hook Reference

### Available Variables

```php
function adesso_cms_theme_preprocess_HOOK(&$variables) {
  // Theme path
  $theme_path = \Drupal::theme()->getActiveTheme()->getPath();

  // Current user
  $user = \Drupal::currentUser();
  $variables['is_admin'] = $user->hasPermission('administer site configuration');

  // Current route
  $route = \Drupal::routeMatch()->getRouteName();
  $variables['is_front'] = \Drupal::service('path.matcher')->isFrontPage();

  // Request info
  $request = \Drupal::request();
  $variables['base_url'] = $request->getSchemeAndHttpHost();

  // Language
  $language = \Drupal::languageManager()->getCurrentLanguage();
  $variables['current_language'] = $language->getId();
}
```

### Menu Tree Loading

```php
function adesso_cms_theme_preprocess_HOOK(&$variables) {
  $menu_tree = \Drupal::menuTree();

  // Parameters for menu loading
  $parameters = $menu_tree->getCurrentRouteMenuTreeParameters('main');
  $parameters->setMinDepth(1);
  $parameters->setMaxDepth(3); // How deep to load

  // Load tree
  $tree = $menu_tree->load('main', $parameters);

  // Apply standard manipulators
  $manipulators = [
    ['callable' => 'menu.default_tree_manipulators:checkAccess'],
    ['callable' => 'menu.default_tree_manipulators:generateIndexAndSort'],
  ];
  $tree = $menu_tree->transform($tree, $manipulators);

  // Build render array
  $build = $menu_tree->build($tree);

  // Extract items as simple arrays
  $variables['menu_items'] = _theme_extract_menu_items($build['#items'] ?? []);
}

/**
 * Helper to extract menu items recursively.
 */
function _theme_extract_menu_items(array $items): array {
  $result = [];
  foreach ($items as $item) {
    $menu_item = [
      'title' => $item['title'],
      'url' => $item['url']->toString(),
      'in_active_trail' => $item['in_active_trail'] ?? FALSE,
      'is_expanded' => $item['is_expanded'] ?? FALSE,
      'below' => [],
    ];

    if (!empty($item['below'])) {
      $menu_item['below'] = _theme_extract_menu_items($item['below']);
    }

    $result[] = $menu_item;
  }
  return $result;
}
```

### Block Loading

```php
function adesso_cms_theme_preprocess_HOOK(&$variables) {
  // Load a specific block
  $block = \Drupal\block\Entity\Block::load('searchform');
  if ($block) {
    $variables['search_block'] = \Drupal::entityTypeManager()
      ->getViewBuilder('block')
      ->view($block);
  }

  // Load block content entity
  $block_content = \Drupal::entityTypeManager()
    ->getStorage('block_content')
    ->loadByProperties(['info' => 'My Block']);
}
```

### View Loading

```php
function adesso_cms_theme_preprocess_HOOK(&$variables) {
  // Load and render a view
  $view = \Drupal\views\Views::getView('my_view');
  if ($view) {
    $view->setDisplay('block_1');
    $view->preExecute();
    $view->execute();
    $variables['my_view'] = $view->render();
  }
}
```

## Template Override Naming

### Block Templates

```
block--[module]--[delta].html.twig
block--system-branding-block.html.twig
block--system-menu-block--main.html.twig
```

### Paragraph Templates

```
paragraph--[bundle].html.twig
paragraph--hero.html.twig
paragraph--card.html.twig
```

### Node Templates

```
node--[type]--[view-mode].html.twig
node--article--teaser.html.twig
node--page--full.html.twig
```

### Field Templates

```
field--[entity-type]--[field-name]--[bundle].html.twig
field--node--field-image--article.html.twig
```

## Caching Considerations

### Cache Tags in Components

```php
function adesso_cms_theme_preprocess_HOOK(&$variables) {
  // Add cache tags for menu
  $variables['#cache']['tags'][] = 'config:system.menu.main';

  // Add cache contexts
  $variables['#cache']['contexts'][] = 'url.path';
  $variables['#cache']['contexts'][] = 'user.roles';

  // Add max-age
  $variables['#cache']['max-age'] = 3600; // 1 hour
}
```

### Disable Caching for Dynamic Content

```php
// In preprocess
$variables['#cache']['max-age'] = 0;

// Or in Twig
{% set cache = {'max-age': 0} %}
```

## Debugging Tips

### Dump Variables in Twig

```twig
{# Dump all variables #}
{{ dump() }}

{# Dump specific variable #}
{{ dump(menu_items) }}

{# Kint (if enabled) #}
{{ kint(variable) }}
```

### Check What's Available

```twig
{# List all keys #}
{{ dump(_context|keys) }}

{# Check variable type #}
{{ dump(variable|class) }}
```

### Drush Commands

```bash
# Clear cache
ddev drush cr

# Check for errors
ddev drush ws

# Debug theme suggestions
ddev drush theme:debug
```
