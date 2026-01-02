---
name: reproduce-bug
description: Reproduce and investigate a bug using logs and console inspection
argument-hint: "[GitHub issue number]"
---

Look at github issue #$ARGUMENTS and read the issue description and comments.

Then, run the following agents in parallel at the same time to investigate the bug:

- Task drupal-specialist(issue_description)
- Task git-history-analyzer(issue_description)
- Task code-simplifier(issue_description) → Includes pattern/anti-pattern detection

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

4. **Test with Claude in Chrome** if it's a frontend issue:
   ```
   mcp__claude-in-chrome__tabs_context_mcp
   mcp__claude-in-chrome__navigate(url="...", tabId=<tab_id>)
   mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
   mcp__claude-in-chrome__read_console_messages(tabId=<tab_id>)  # Check for JS errors
   ```

   **Fallback (only if Claude in Chrome unavailable):** Use Playwright MCP

Keep investigating until you have a good understanding of what is going on.

**Reference Collection:**

- [ ] Document all research findings with specific file paths (e.g., `web/modules/custom/my_module/src/Service/MyService.php:42`)
- [ ] Note relevant log entries and error messages
- [ ] Document steps to reproduce

Then, add a comment to the issue with the findings and how to reproduce the bug.
