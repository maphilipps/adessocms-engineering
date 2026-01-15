# Visual Verification Workflow

## Required Reading
Before starting, load:
- `../references/anti-patterns.md` - Common issues to check

---

## Input Gathering

Ask user:
1. **Component or page to verify?**
2. **Expected URL path?**
3. **Specific breakpoints to test?** (default: all three)
4. **Known issues to check?**

---

## Process

### Step 1: Build Theme

Always start with fresh build:

```bash
ddev theme build && ddev drush cr
```

### Step 2: Get Browser Context

```
mcp__claude-in-chrome__tabs_context_mcp(createIfEmpty=true)
```

### Step 3: Navigate to Component

```
mcp__claude-in-chrome__navigate(
  url="https://<project>.ddev.site/<path>",
  tabId=<id>
)
```

### Step 4: Desktop Verification (1280px)

```
mcp__claude-in-chrome__resize_window(
  width=1280,
  height=800,
  tabId=<id>
)

mcp__claude-in-chrome__computer(
  action="screenshot",
  tabId=<id>
)
```

**Check:**
- [ ] Layout correct
- [ ] Typography readable
- [ ] Colors match design
- [ ] Spacing consistent
- [ ] Interactive elements visible

### Step 5: Tablet Verification (768px)

```
mcp__claude-in-chrome__resize_window(
  width=768,
  height=1024,
  tabId=<id>
)

mcp__claude-in-chrome__computer(
  action="screenshot",
  tabId=<id>
)
```

**Check:**
- [ ] Responsive breakpoint triggers
- [ ] Content reflows correctly
- [ ] No horizontal overflow
- [ ] Touch targets adequate size

### Step 6: Mobile Verification (375px)

```
mcp__claude-in-chrome__resize_window(
  width=375,
  height=667,
  tabId=<id>
)

mcp__claude-in-chrome__computer(
  action="screenshot",
  tabId=<id>
)
```

**Check:**
- [ ] Mobile layout correct
- [ ] Text readable
- [ ] Buttons/links tappable
- [ ] No content cut off

### Step 7: Interactive State Testing

If component has interactive states:

```
# Hover state
mcp__claude-in-chrome__computer(
  action="hover",
  coordinate=[x, y],
  tabId=<id>
)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<id>)

# Click state
mcp__claude-in-chrome__computer(
  action="left_click",
  coordinate=[x, y],
  tabId=<id>
)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<id>)
```

### Step 8: Console Error Check

```
mcp__claude-in-chrome__read_console_messages(
  tabId=<id>,
  onlyErrors=true
)
```

**Check:**
- [ ] No JavaScript errors
- [ ] No 404 resource errors
- [ ] No CORS issues

### Step 9: Report

Generate verification report:

```
## Verification Report: <Component>

### Build Status
- Theme build: ✓
- Cache clear: ✓

### Visual Verification
| Breakpoint | Status | Notes |
|------------|--------|-------|
| Desktop (1280px) | ✓/✗ | ... |
| Tablet (768px) | ✓/✗ | ... |
| Mobile (375px) | ✓/✗ | ... |

### Interactive States
| State | Status | Notes |
|-------|--------|-------|
| Hover | ✓/✗ | ... |
| Click | ✓/✗ | ... |
| Focus | ✓/✗ | ... |

### Console
- Errors: 0
- Warnings: N

### Screenshots
[Attached above]
```

---

## Breakpoint Reference

| Name | Width | Use Case |
|------|-------|----------|
| Mobile | 375px | iPhone SE |
| Mobile L | 425px | Large phones |
| Tablet | 768px | iPad portrait |
| Laptop | 1024px | Small laptops |
| Desktop | 1280px | Standard desktop |
| Desktop L | 1440px | Large monitors |

---

## Chrome MCP Quick Reference

| Action | Tool |
|--------|------|
| Get tab context | `tabs_context_mcp` |
| Navigate | `navigate` |
| Resize | `resize_window` |
| Screenshot | `computer(action="screenshot")` |
| Click | `computer(action="left_click", coordinate=[x,y])` |
| Hover | `computer(action="hover", coordinate=[x,y])` |
| Read page | `read_page` |
| Console logs | `read_console_messages` |

---

## Success Criteria

- [ ] All three breakpoints verified
- [ ] No console errors
- [ ] Interactive states work
- [ ] Visual matches expectation
- [ ] Report generated with screenshots
