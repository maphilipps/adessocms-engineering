# SDC Component Patterns

Reference patterns for adesso CMS Single Directory Components.

## Component Schema Examples

### Simple Component with Props

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: Button
description: Button component with variants
status: stable

props:
  type: object
  required:
    - text
  properties:
    text:
      type: string
      title: Button Text
    url:
      type: string
      title: Link URL
    variant:
      type: string
      title: Variant
      enum: [primary, secondary, outline]
      default: primary
    size:
      type: string
      title: Size
      enum: [xs, sm, default, lg]
      default: default
```

### Component with Nested Arrays

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: Navigation Menu
description: Multi-level navigation
status: stable

props:
  type: object
  properties:
    menu_items:
      type: array
      title: Menu Items
      items:
        type: object
        properties:
          title:
            type: string
          url:
            type: string
          in_active_trail:
            type: boolean
            default: false
          below:
            type: array
            description: Submenu items
            items:
              type: object
              properties:
                title:
                  type: string
                url:
                  type: string
                in_active_trail:
                  type: boolean
```

### Component with Slots

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: Card
description: Card with flexible content areas
status: stable

props:
  type: object
  properties:
    variant:
      type: string
      enum: [default, featured, minimal]
      default: default

slots:
  media:
    title: Media
    description: Image or video area
  content:
    title: Content
    description: Main content area
  footer:
    title: Footer
    description: Footer area with actions
```

## Twig Template Patterns

### Basic Structure

```twig
{#
/**
 * @file
 * Component: Component Name
 *
 * Available variables:
 * - prop_name: Description of prop
 */
#}

{# Set defaults for optional props #}
{% set variant = variant|default('default') %}
{% set size = size|default('default') %}

{# Build dynamic classes #}
{% set wrapper_classes = [
  'c-component-name',
  'c-component-name--' ~ variant,
  'c-component-name--' ~ size,
] %}

<div {{ attributes.addClass(wrapper_classes) }}>
  {# Component content #}
</div>
```

### Conditional Rendering

```twig
{# Show element only if content exists #}
{% if title %}
  <h2 class="h-3xl">{{ title }}</h2>
{% endif %}

{# Show different content based on variant #}
{% if variant == 'dark' %}
  <div class="bg-black text-white">
{% else %}
  <div class="bg-white text-neutral-900">
{% endif %}

{# Loop with index #}
{% for item in items %}
  <div class="{{ loop.first ? 'first-item' : '' }} {{ loop.last ? 'last-item' : '' }}">
    {{ item.title }}
  </div>
{% endfor %}
```

### Slot Rendering

```twig
{# Render default slot #}
{{ content }}

{# Render named slots #}
{% if media %}
  <div class="c-card__media">
    {{ media }}
  </div>
{% endif %}

{% if footer %}
  <div class="c-card__footer">
    {{ footer }}
  </div>
{% endif %}
```

### Including Other Components

```twig
{# Include another SDC component #}
{% include 'adesso_cms_theme:button' with {
  text: cta_text,
  url: cta_url,
  variant: 'primary',
} only %}

{# Embed for slots #}
{% embed 'adesso_cms_theme:card' with { variant: 'featured' } %}
  {% block media %}
    <img src="{{ image_url }}" alt="{{ image_alt }}">
  {% endblock %}
  {% block content %}
    <h3>{{ title }}</h3>
    <p>{{ description }}</p>
  {% endblock %}
{% endembed %}
```

## Alpine.js Integration

### Simple Toggle

```twig
<div x-data="{ open: false }">
  <button @click="open = !open"
          :aria-expanded="open">
    Toggle
  </button>
  <div x-show="open"
       x-cloak
       x-transition>
    Content here
  </div>
</div>
```

### Dropdown with Hover (Desktop)

```twig
<div x-data="{ open: false }"
     @mouseenter="open = true"
     @mouseleave="open = false"
     class="relative">
  <button :aria-expanded="open">
    Menu Item
    <svg :class="open ? 'rotate-180' : ''">...</svg>
  </button>
  <div x-show="open"
       x-cloak
       x-transition:enter="transition ease-out duration-200"
       x-transition:enter-start="opacity-0 -translate-y-2"
       x-transition:enter-end="opacity-100 translate-y-0"
       x-transition:leave="transition ease-in duration-150"
       x-transition:leave-start="opacity-100"
       x-transition:leave-end="opacity-0"
       class="absolute left-0 top-full mt-2">
    Dropdown content
  </div>
</div>
```

### Mobile Menu (Slide-in Panel)

```twig
<div x-data="{ mobileMenuOpen: false }">
  {# Trigger #}
  <button @click="mobileMenuOpen = true"
          class="lg:hidden"
          aria-label="Open menu">
    <svg><!-- Hamburger icon --></svg>
  </button>

  {# Backdrop #}
  <div x-show="mobileMenuOpen"
       @click="mobileMenuOpen = false"
       x-transition:enter="transition-opacity ease-out duration-300"
       x-transition:enter-start="opacity-0"
       x-transition:enter-end="opacity-100"
       x-transition:leave="transition-opacity ease-in duration-200"
       x-transition:leave-start="opacity-100"
       x-transition:leave-end="opacity-0"
       class="fixed inset-0 bg-black/60 z-40"
       x-cloak>
  </div>

  {# Panel #}
  <div x-show="mobileMenuOpen"
       @keydown.escape.window="mobileMenuOpen = false"
       x-transition:enter="transition ease-out duration-300"
       x-transition:enter-start="translate-x-full"
       x-transition:enter-end="translate-x-0"
       x-transition:leave="transition ease-in duration-200"
       x-transition:leave-start="translate-x-0"
       x-transition:leave-end="translate-x-full"
       class="fixed top-0 right-0 bottom-0 w-full max-w-sm bg-white z-50"
       x-cloak>

    {# Close button #}
    <button @click="mobileMenuOpen = false"
            aria-label="Close menu">
      <svg><!-- X icon --></svg>
    </button>

    {# Menu content #}
    <nav>
      {% for item in menu_items %}
        <a href="{{ item.url }}"
           @click="mobileMenuOpen = false">
          {{ item.title }}
        </a>
      {% endfor %}
    </nav>
  </div>
</div>
```

### Accordion with Collapse

```twig
<div x-data="{ activeItem: null }">
  {% for item in items %}
    <div class="border-b">
      <button @click="activeItem = activeItem === {{ loop.index }} ? null : {{ loop.index }}"
              :aria-expanded="activeItem === {{ loop.index }}"
              class="w-full text-left py-4 flex justify-between">
        {{ item.title }}
        <svg :class="activeItem === {{ loop.index }} ? 'rotate-180' : ''">
          <!-- Chevron -->
        </svg>
      </button>
      <div x-show="activeItem === {{ loop.index }}"
           x-collapse
           x-cloak>
        <div class="pb-4">
          {{ item.content }}
        </div>
      </div>
    </div>
  {% endfor %}
</div>
```

## Drupal Integration Patterns

### Getting Menu Data in Preprocess

```php
/**
 * Implements hook_preprocess_HOOK().
 */
function adesso_cms_theme_preprocess_site_header(&$variables) {
  // Get main menu
  $menu_tree = \Drupal::menuTree();
  $parameters = $menu_tree->getCurrentRouteMenuTreeParameters('main');
  $parameters->setMinDepth(1);
  $parameters->setMaxDepth(2);

  $tree = $menu_tree->load('main', $parameters);
  $manipulators = [
    ['callable' => 'menu.default_tree_manipulators:checkAccess'],
    ['callable' => 'menu.default_tree_manipulators:generateIndexAndSort'],
  ];
  $tree = $menu_tree->transform($tree, $manipulators);
  $build = $menu_tree->build($tree);

  // Transform to simple array for component
  $variables['menu_items'] = [];
  if (!empty($build['#items'])) {
    foreach ($build['#items'] as $item) {
      $menu_item = [
        'title' => $item['title'],
        'url' => $item['url']->toString(),
        'in_active_trail' => $item['in_active_trail'] ?? FALSE,
        'below' => [],
      ];

      if (!empty($item['below'])) {
        foreach ($item['below'] as $subitem) {
          $menu_item['below'][] = [
            'title' => $subitem['title'],
            'url' => $subitem['url']->toString(),
            'in_active_trail' => $subitem['in_active_trail'] ?? FALSE,
          ];
        }
      }

      $variables['menu_items'][] = $menu_item;
    }
  }
}
```

### Getting Theme Settings

```php
// Logo
$variables['logo'] = theme_get_setting('logo.url');

// Site name and slogan
$config = \Drupal::config('system.site');
$variables['site_name'] = $config->get('name');
$variables['site_slogan'] = $config->get('slogan');

// Front page URL
$variables['front_page'] = Url::fromRoute('<front>')->toString();

// Current path
$variables['current_path'] = \Drupal::service('path.current')->getPath();
```

### Render Arrays in Slots

```php
// Pass render array to slot
$variables['content_slot'] = [
  '#type' => 'processed_text',
  '#text' => $node->body->value,
  '#format' => $node->body->format,
];

// Or markup
$variables['content_slot'] = [
  '#markup' => $some_html,
];
```
