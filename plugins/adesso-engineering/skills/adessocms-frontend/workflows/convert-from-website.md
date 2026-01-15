# Convert Component from Website

## Required Reading
Before starting, load:
- `../references/sdc-structure.md` - Target structure
- `../references/slots-vs-props.md` - Mapping source to slots/props
- `../references/tailwind-v4.md` - Style conversion

---

## Input Gathering

Ask user:
1. **Source URL** - The website with the component to copy
2. **Component to extract** - Which element (hero, nav, footer, etc.)
3. **Target component name** - What to call it in our theme
4. **Customizations needed?** - Colors, spacing, content changes

---

## Process

### Step 1: Navigate and Screenshot

```
mcp__claude-in-chrome__tabs_context_mcp
mcp__claude-in-chrome__navigate(url="<source_url>", tabId=<id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<id>)
```

Analyze the screenshot to identify the component boundaries.

### Step 2: Extract HTML/CSS

Use JavaScript to get the component HTML:

```
mcp__claude-in-chrome__javascript_tool(
  action="javascript_exec",
  text="document.querySelector('<selector>').outerHTML",
  tabId=<id>
)
```

For computed styles:

```
mcp__claude-in-chrome__javascript_tool(
  action="javascript_exec",
  text="JSON.stringify(window.getComputedStyle(document.querySelector('<selector>')))",
  tabId=<id>
)
```

### Step 3: Analyze Structure

From extracted HTML, identify:

| Source Element | → SDC Mapping |
|----------------|---------------|
| Text content | **SLOT** |
| Images | **SLOT** |
| Links/buttons | **SLOT** |
| Layout variations | **PROP** (variant) |
| Color themes | **PROP** (theme) |
| Size options | **PROP** (size) |

### Step 4: Convert Styles to Tailwind

Map CSS to Tailwind v4 classes:

| CSS Property | Tailwind Class |
|--------------|----------------|
| `display: flex` | `flex` |
| `gap: 1rem` | `gap-4` |
| `padding: 2rem` | `p-8` |
| `background: #fff` | `bg-white` |
| Custom color | Use `@theme inline` |

### Step 5: Create SDC Structure

Follow `build-sdc-component.md` workflow with:
- Extracted content → slots
- Style variations → CVA variants
- Interactive elements → Alpine.js

### Step 6: Adapt to Project Theme

Replace hardcoded values with theme tokens:

```css
@theme inline {
  --color-primary: var(--primary);
  --color-secondary: var(--secondary);
}
```

### Step 7: Build and Verify

```bash
ddev theme build && ddev drush cr
```

Side-by-side comparison:
1. Screenshot of original
2. Screenshot of implementation
3. Note any intentional differences

---

## Chrome MCP Tool Reference

| Task | Tool |
|------|------|
| Navigate | `mcp__claude-in-chrome__navigate` |
| Screenshot | `mcp__claude-in-chrome__computer(action="screenshot")` |
| Extract HTML | `mcp__claude-in-chrome__javascript_tool` |
| Read page structure | `mcp__claude-in-chrome__read_page` |
| Find elements | `mcp__claude-in-chrome__find` |
| Resize for breakpoint | `mcp__claude-in-chrome__resize_window` |

---

## Anti-Patterns

❌ **NEVER** copy CSS verbatim - convert to Tailwind
❌ **NEVER** include third-party JS libraries without review
❌ **NEVER** hardcode content that should come from Drupal fields
❌ **NEVER** use inline styles - use Tailwind classes

---

## Success Criteria

- [ ] Visual parity with source (or documented differences)
- [ ] All content in slots (not hardcoded)
- [ ] Styles use Tailwind classes
- [ ] Responsive behavior matches or improves on source
- [ ] Accessibility maintained or improved
