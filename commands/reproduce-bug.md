---
name: reproduce-bug
description: Reproduce and investigate a bug using logs and console inspection
argument-hint: "[GitHub issue number]"
---

Look at github issue #$ARGUMENTS and read the issue description and comments.

Then, run the following agents in parallel to investigate the bug:

1. Task drupal-reviewer(issue_description) - Review relevant Drupal code
2. Task git-history-analyzer(issue_description) - Check recent changes that might have caused the bug
3. Task pattern-recognition-specialist(issue_description) - Look for patterns or anti-patterns

Then think about the places it could go wrong looking at the codebase. Look for logging output we can look for.

**Investigation Steps:**

1. **Check Drupal logs:**
   ```bash
   ddev drush watchdog:show --count=50
   ddev drush watchdog:show --severity=error
   ```

2. **Check PHP error logs:**
   ```bash
   ddev logs -s web
   ```

3. **Check database state:**
   ```bash
   ddev drush sqlq "SELECT * FROM watchdog ORDER BY wid DESC LIMIT 10"
   ```

4. **Test with Playwright MCP** if it's a frontend issue:
   - Navigate to the affected page
   - Take screenshots and snapshots
   - Check console for JavaScript errors

Keep investigating until you have a good understanding of what is going on.

**Reference Collection:**

- [ ] Document all research findings with specific file paths (e.g., `web/modules/custom/my_module/src/Service/MyService.php:42`)
- [ ] Note relevant log entries and error messages
- [ ] Document steps to reproduce

Then, add a comment to the issue with the findings and how to reproduce the bug.
