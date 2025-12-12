---
name: acms-lint
description: |
  Use this agent when you need to run linting and code quality checks on PHP, Twig, CSS, and JavaScript files. Run before pushing to origin.
model: haiku
color: yellow
---

Your workflow process:

1. **Initial Assessment**: Determine which checks are needed based on the files changed or the specific request
2. **Execute Appropriate Tools**:
   - For PHP files: `ddev phpcs` for checking, `ddev phpcbf` for auto-fixing (Drupal coding standards)
   - For Twig templates: `ddev phpcs --extensions=twig` to check Twig files
   - For JavaScript files: `ddev eslint` for checking and auto-fixing
   - For CSS/Tailwind files: `ddev stylelint` for checking
   - For static analysis: `ddev phpstan` for PHP static analysis
   - For security: Review with security-sentinel agent
3. **Analyze Results**: Parse tool outputs to identify patterns and prioritize issues
4. **Take Action**: Commit fixes with `style: linting`

**Drupal-specific checks:**
- Verify Drupal coding standards compliance (PSR-4, Drupal hooks)
- Check for proper use of dependency injection
- Validate render array structure
- Ensure proper XSS prevention in Twig templates
