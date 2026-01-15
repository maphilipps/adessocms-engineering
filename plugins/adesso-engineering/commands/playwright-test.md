---
name: playwright-test
description: Run Playwright E2E tests and verify frontend functionality with visual feedback
argument-hint: "[test file pattern or empty for all tests]"
---

# /playwright-test - E2E Testing Workflow

Run Playwright tests with visual verification and detailed reporting.

## Prerequisites

Ensure Playwright is set up in the project:
```bash
ddev exec npm install -D @playwright/test
ddev exec npx playwright install chromium
```

## Workflow

### Phase 1: Environment Check

Verify DDEV is running and site is accessible:
```bash
ddev describe | grep -E "^(OK|Name|URL)"
```

### Phase 2: Run Tests

#### All Tests
```bash
ddev exec npx playwright test
```

#### Specific Test File
```bash
ddev exec npx playwright test tests/e2e/contact-form.spec.ts
```

#### Specific Test Pattern
```bash
ddev exec npx playwright test -g "contact form submission"
```

#### With Visual Mode (headed)
```bash
ddev exec npx playwright test --headed
```

### Phase 3: Visual Verification with Chrome MCP

For tests that need visual verification:

```
mcp__claude-in-chrome__tabs_context_mcp()
mcp__claude-in-chrome__navigate(url: "https://mysite.ddev.site/test-page")
mcp__claude-in-chrome__computer(action: "screenshot", tabId: X)
```

### Phase 4: Test Report

Parse and summarize test results:

```markdown
## E2E Test Results

### Summary
- **Total**: X tests
- **Passed**: Y ✅
- **Failed**: Z ❌
- **Skipped**: A ⏭️

### Failed Tests
| Test | File | Error |
|------|------|-------|
| [Test name] | [file:line] | [Error message] |

### Screenshots
[Embedded or linked screenshots from failed tests]

### Performance
| Test | Duration |
|------|----------|
| [Test 1] | 1.2s |
| [Test 2] | 0.8s |
```

### Phase 5: Fix Failing Tests

If tests fail:
1. Analyze failure reason
2. Check if it's a test issue or code issue
3. For code issues → create todo or fix immediately
4. For test issues → update test
5. Re-run to verify

## Test File Structure

Standard Playwright test structure for Drupal:

```typescript
// tests/e2e/contact-form.spec.ts
import { test, expect } from '@playwright/test';

test.describe('Contact Form', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('/contact');
  });

  test('submits successfully with valid data', async ({ page }) => {
    await page.fill('[data-testid="name"]', 'Test User');
    await page.fill('[data-testid="email"]', 'test@example.com');
    await page.fill('[data-testid="message"]', 'Test message');
    await page.click('[data-testid="submit"]');
    
    await expect(page.locator('.success-message')).toBeVisible();
  });

  test('shows validation errors for empty fields', async ({ page }) => {
    await page.click('[data-testid="submit"]');
    
    await expect(page.locator('.error-message')).toBeVisible();
  });
});
```

## Integration with /lfg

In the full workflow:
1. `/work` implements the feature
2. `/review` checks the code
3. `/playwright-test` verifies E2E functionality
4. `/feature-video` records the demo

## Common Test Scenarios

| Scenario | Test Pattern |
|----------|--------------|
| Form submission | Fill fields, submit, verify success |
| Navigation | Click links, verify URL/content change |
| Authentication | Login, verify protected content |
| Error handling | Trigger error, verify message |
| Responsive | Resize viewport, verify layout |
| Accessibility | Run axe-core checks |

## Troubleshooting

### Tests timeout
```bash
# Increase timeout
ddev exec npx playwright test --timeout=60000
```

### Can't connect to site
```bash
# Verify DDEV is running
ddev status
ddev start
```

### Selectors not found
```bash
# Debug mode
ddev exec npx playwright test --debug
```
