# Security Best Practices

## OWASP Top 10 for Drupal

### 1. Injection

**SQL Injection Prevention:**
```php
// WRONG - Direct variable in query
$result = $connection->query("SELECT * FROM users WHERE name = '$name'");

// CORRECT - Parameterized query
$result = $connection->query("SELECT * FROM {users} WHERE name = :name", [
  ':name' => $name,
]);

// CORRECT - Entity Query (safest)
$uids = \Drupal::entityQuery('user')
  ->accessCheck(TRUE)
  ->condition('name', $name)
  ->execute();
```

**XSS Prevention:**
```php
// In render arrays (auto-escaped)
$build['content'] = ['#markup' => $user_input]; // ✅ Safe

// In Twig (auto-escaped)
{{ user_input }} // ✅ Safe

// Dangerous - raw output
{{ user_input|raw }} // ⚠️ Only for sanitized HTML
```

### 2. Broken Authentication

```php
// Use Drupal's authentication
$user = User::load(\Drupal::currentUser()->id());

// Check permissions
if ($user->hasPermission('administer nodes')) {
  // Allowed
}

// Password handling - never store plaintext
$password_service = \Drupal::service('password');
$hashed = $password_service->hash($plain_password);
$valid = $password_service->check($plain_password, $hashed);
```

### 3. Sensitive Data Exposure

```php
// Never log sensitive data
$this->logger->info('User logged in: @user', ['@user' => $username]);
// NOT: $this->logger->info('Login: @user @pass', ['@pass' => $password]);

// Mask sensitive config
$config['api_key'] = '***hidden***'; // In logs/debug
```

---

## Input Sanitization

### Form API (Automatic)

```php
$form['name'] = [
  '#type' => 'textfield',
  '#title' => $this->t('Name'),
  '#maxlength' => 255,
  '#required' => TRUE,
];
// Form API sanitizes input automatically
```

### Manual Sanitization

```php
use Drupal\Component\Utility\Html;
use Drupal\Component\Utility\Xss;

// HTML entities
$safe = Html::escape($user_input);

// Filter admin XSS
$safe = Xss::filterAdmin($html);

// Filter with allowed tags
$safe = Xss::filter($html, ['a', 'em', 'strong']);

// Plain text
$safe = strip_tags($user_input);
```

---

## Output Handling

### In Twig

```twig
{# Auto-escaped #}
{{ variable }}

{# Render array (safe) #}
{{ content.field_body }}

{# URL encoding #}
<a href="{{ url|e('url') }}">Link</a>

{# Never trust user input in attributes #}
{# WRONG: <a href="{{ user_url }}"> #}
{# CORRECT: Use Link::fromUri with validation #}
```

### In PHP

```php
// Render array with Markup
use Drupal\Core\Render\Markup;

$build['safe'] = [
  '#markup' => $this->t('Hello @name', ['@name' => $name]),
];

// For pre-sanitized HTML only
$build['html'] = [
  '#markup' => Markup::create($sanitized_html),
];
```

---

## Access Control

### Route Access

```yaml
# my_module.routing.yml
my_module.admin:
  path: '/admin/my-module'
  defaults:
    _controller: '\Drupal\my_module\Controller\AdminController::content'
  requirements:
    _permission: 'administer my module'
```

### Entity Access

```php
// Always check access
if ($node->access('view')) {
  // Can view
}

// In entity queries
$query = \Drupal::entityQuery('node')
  ->accessCheck(TRUE)  // REQUIRED!
  ->condition('status', 1);
```

### Custom Access Check

```php
<?php

namespace Drupal\my_module\Access;

use Drupal\Core\Access\AccessResult;
use Drupal\Core\Routing\Access\AccessInterface;
use Drupal\Core\Session\AccountInterface;

class MyAccessCheck implements AccessInterface {

  public function access(AccountInterface $account): AccessResult {
    return AccessResult::allowedIf(
      $account->hasPermission('my permission')
    );
  }

}
```

---

## CSRF Protection

### Form API (Automatic)

Form API automatically adds CSRF tokens. Never bypass with `'#token' => FALSE`.

### Links with Actions

```php
use Drupal\Core\Url;

// Add CSRF token to action links
$url = Url::fromRoute('my_module.action', ['id' => $id]);
$url->setOption('query', [
  'token' => \Drupal::csrfToken()->get('my_module_action_' . $id),
]);
```

### Verify Token

```php
$token = $request->query->get('token');
if (!\Drupal::csrfToken()->validate($token, 'my_module_action_' . $id)) {
  throw new AccessDeniedHttpException();
}
```

---

## File Upload Security

```php
$form['file'] = [
  '#type' => 'managed_file',
  '#title' => $this->t('Upload'),
  '#upload_validators' => [
    'file_validate_extensions' => ['pdf doc docx'],
    'file_validate_size' => [25 * 1024 * 1024], // 25MB
  ],
  '#upload_location' => 'private://uploads/', // Use private for sensitive
];
```

---

## Security Advisories

### Monitor

```bash
# Check for security updates
ddev composer audit
ddev drush pm:security
```

### Response Times

| Severity | Response |
|----------|----------|
| Critical | Immediate |
| Highly Critical | 24 hours |
| Moderately Critical | 1 week |
| Less Critical | Next release |

---

## Security Checklist

- [ ] All user input sanitized
- [ ] Entity queries have `accessCheck(TRUE)`
- [ ] Permissions checked on sensitive operations
- [ ] CSRF tokens on state-changing links
- [ ] File uploads validated and in appropriate directories
- [ ] Sensitive data not logged
- [ ] Security updates applied
- [ ] Error messages don't reveal system info
