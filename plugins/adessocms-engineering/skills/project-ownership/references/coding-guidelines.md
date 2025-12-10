# Coding Guidelines for adesso CMS

## PHP (Drupal Modules)

### Standards
- Follow Drupal coding standards: https://www.drupal.org/docs/develop/standards
- Use PHPCS with Drupal/DrupalPractice sniffs
- PHPStan level 6 minimum

### Commands
```bash
ddev phpcs web/modules/custom
ddev phpcbf web/modules/custom  # Auto-fix
ddev phpstan
```

### Key Rules
1. Use dependency injection, not `\Drupal::service()`
2. Type hints for all parameters and return values
3. DocBlocks for all public methods
4. No deprecated API usage
5. Security: Always sanitize output, validate input

## JavaScript

### Standards
- ESLint with Drupal configuration
- ES6+ syntax
- Drupal behaviors pattern

### Commands
```bash
ddev eslint
```

### Key Rules
1. Use `Drupal.behaviors` for initialization
2. Use `once()` to prevent duplicate attachment
3. No global variables (wrap in IIFE or module)
4. Prefer `const` and `let` over `var`
5. Use async/await for promises

### Example
```javascript
(function (Drupal) {
  'use strict';

  Drupal.behaviors.myBehavior = {
    attach(context) {
      once('my-behavior', '.selector', context).forEach((el) => {
        // Initialize
      });
    },
  };
})(Drupal);
```

## CSS / Tailwind

### Standards
- Stylelint with standard config
- Tailwind CSS v4 conventions
- BEM for custom classes

### Commands
```bash
ddev stylelint
```

### Key Rules
1. Prefer Tailwind utilities in templates
2. Use `@apply` sparingly
3. Custom properties for theming
4. Mobile-first responsive design
5. No `!important`

### Tailwind v4 Syntax
```css
@import "tailwindcss";

/* Custom utilities */
@layer utilities {
  .custom-utility {
    /* styles */
  }
}
```

## Twig Templates

### Standards
- Drupal Twig coding standards
- Security: escape all variables
- Performance: minimal logic in templates

### Key Rules
1. Always escape: `{{ variable }}` (auto-escaped)
2. Raw only when necessary: `{{ variable|raw }}`
3. Set defaults at top of template
4. Use `attributes` object for classes
5. Comment complex logic

### Example
```twig
{# Set defaults #}
{% set title = title ?? '' %}
{% set classes = [
  'c-component',
  variant ? 'c-component--' ~ variant,
] %}

<div {{ attributes.addClass(classes) }}>
  {% if title %}
    <h2 class="c-component__title">{{ title }}</h2>
  {% endif %}
  {{ content }}
</div>
```

## YAML (Config/Schema)

### Standards
- 2-space indentation
- No trailing whitespace
- Consistent quoting

### Key Rules
1. Use lowercase keys with underscores
2. Quote strings with special characters
3. Validate schema before committing

## Git Workflow

### Branch Naming
- `feature/DS-XXX-short-description`
- `bugfix/DS-XXX-short-description`
- `hotfix/critical-fix`

### Commit Messages
```
[DS-XXX] Type: Short description

Longer description if needed.

- Detail 1
- Detail 2
```

Types: `feat`, `fix`, `refactor`, `docs`, `style`, `test`, `chore`

### Pre-commit Checks
Before committing:
```bash
ddev theme qa:validate  # Lint + Test
ddev phpcs
ddev phpstan
```

## Performance Guidelines

### Caching
1. Use cache tags on render arrays
2. Set appropriate cache contexts
3. Leverage BigPipe for below-fold content

### Assets
1. Lazy load images
2. Use image styles
3. Minimize JS in critical path
4. Let Vite handle bundling

### Queries
1. Avoid N+1 queries
2. Use entity query, not raw SQL
3. Preload referenced entities

## Security Guidelines

### Input Validation
1. Use Form API validation
2. Validate all user input
3. Use typed data where possible

### Output Sanitization
1. Twig auto-escapes by default
2. Use `#markup` for safe HTML
3. Never `|raw` untrusted content

### Access Control
1. Check permissions in controllers
2. Use access handlers on routes
3. Verify entity access before operations

## Accessibility (WCAG 2.1 AA)

### Requirements
1. Semantic HTML
2. Keyboard navigation
3. Focus management
4. Color contrast (4.5:1 text, 3:1 UI)
5. Screen reader support

### Testing
1. Keyboard-only navigation
2. Screen reader testing (VoiceOver/NVDA)
3. Color contrast checker
4. axe DevTools

## Testing Requirements

### Unit Tests
- Business logic
- Utility functions
- Data transformations

### Kernel Tests
- Database operations
- Service integration
- Entity operations

### Functional Tests
- User workflows
- Form submissions
- Access control

### Storybook Tests
- Visual regression
- Component interaction
- Accessibility

### E2E (Playwright)
- Critical user journeys
- Cross-browser
- Mobile responsive
