---
name: reproduce-bug
description: Reproduce and investigate a bug using logs and console inspection
argument-hint: "[GitHub issue number]"
---

Look at github issue #$ARGUMENTS and read the issue description and comments.

Then, run the following agents in parallel to investigate the bug:

```
Task(subagent_type="adessocms-engineering:specialists:drupal-specialist", prompt="Review relevant Drupal code for: {issue_description}")
Task(subagent_type="adessocms-engineering:research:git-history-analyzer", prompt="Check recent changes that might have caused: {issue_description}")
Task(subagent_type="adessocms-engineering:specialists:pattern-recognition-specialist", prompt="Look for patterns or anti-patterns related to: {issue_description}")
```

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
