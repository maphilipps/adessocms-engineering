---
name: adessocms-frontend
description: |
  Build adesso CMS frontend components from scratch through shipping. Covers SDC (Single Directory Components),
  Tailwind CSS v4, Twig templates, Alpine.js, and Storybook. Full lifecycle - design, build, test, verify.
  Automatically invoked when feature.skill = "adessocms-frontend" in Ralph Loop.
---

<essential_principles>
## How adesso CMS Frontend Works

### 1. SDC-First Architecture

All UI components are Single Directory Components (SDC) in `web/themes/custom/*/components/`:

```
components/hero/
├── hero.component.yml    # Schema (required)
├── hero.twig             # Template (required)
├── hero.tailwind.css     # Styles (optional)
└── hero.js               # Alpine.js behavior (optional)
```

**No separate .libraries.yml** - Library definitions go in component.yml via `libraryOverrides`.

### 2. Slots for Content, Props for Config

**CRITICAL RULE:** Never use props for Drupal field content.

| Use SLOTS for | Use PROPS for |
|---------------|---------------|
| Text from fields | theme: dark/light |
| Images/Media | variant: primary/secondary |
| Links/Buttons | size: sm/md/lg |
| Rich text | layout options |
| Menu items | Boolean flags |

Content flows through **field templates** → **slots** → **SDC**.

### 3. CVA-First Variants

All variant styling uses `html_cva()` in Twig - never manual class lists:

```twig
{% set button = html_cva(
  base: ['inline-flex', 'items-center', 'font-medium'],
  variants: {
    variant: {
      primary: 'bg-primary text-white',
      secondary: 'bg-secondary text-secondary-foreground'
    },
    size: {
      sm: 'h-9 px-3 text-sm',
      md: 'h-10 px-4 text-base'
    }
  }
) %}

<button class="{{ button.apply({variant: variant, size: size}) }}">
```

### 4. Tailwind v4 with @theme inline

Use modern Tailwind v4 syntax:

```css
@import "tailwindcss";

@theme inline {
  --color-primary: var(--primary);
  --color-primary-foreground: var(--primary-foreground);
}
```

### 5. Verify in Browser

**ALWAYS verify frontend changes with Claude in Chrome:**

```
mcp__claude-in-chrome__navigate(url="https://project.ddev.site/...", ...)
mcp__claude-in-chrome__computer(action="screenshot", ...)
```

Screenshots at multiple breakpoints: Desktop (1280px), Tablet (768px), Mobile (375px).
</essential_principles>

<intake>
**What would you like to do?**

1. Build a new SDC component
2. Convert component from website (copy/clone)
3. Use TailwindPlus template
4. Add variant to existing component
5. Verify component in browser
6. Something else

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "new", "create", "build", "sdc" | `workflows/build-sdc-component.md` |
| 2, "copy", "clone", "website", "convert", "from" | `workflows/convert-from-website.md` |
| 3, "tailwindplus", "template", "tailwind ui" | `workflows/convert-from-tailwindplus.md` |
| 4, "variant", "add", "extend" | `workflows/add-variant.md` |
| 5, "verify", "check", "browser", "screenshot" | `workflows/verify-component.md` |
| 6, other | Clarify, then select workflow |

**After reading the workflow, follow it exactly.**
</routing>

<verification_loop>
## After Every Change

```bash
# 1. Build theme
ddev theme build

# 2. Clear cache
ddev drush cr

# 3. Visual verification
# Take screenshot with Claude in Chrome
mcp__claude-in-chrome__computer(action="screenshot", ...)
```

Report to user:
- "Build: ✓"
- "Cache cleared: ✓"
- "Visual check: [screenshot attached]"
</verification_loop>

<reference_index>
## Domain Knowledge

All in `references/`:

**Component Structure:**
- sdc-structure.md - Mercury SDC patterns, file structure
- slots-vs-props.md - Decision guide for slots vs props

**Styling:**
- cva-patterns.md - Class Variance Authority usage
- tailwind-v4.md - Tailwind v4 integration, @theme inline

**Templates:**
- twig-patterns.md - Twig best practices, embed vs include
- field-templates.md - Field template patterns for slots

**Interactivity:**
- alpine-js.md - Alpine.js patterns for components

**Testing:**
- storybook.md - Writing Storybook stories

**Quality:**
- anti-patterns.md - Common mistakes to avoid
</reference_index>

<workflows_index>
## Workflows

All in `workflows/`:

| File | Purpose |
|------|---------|
| build-sdc-component.md | Create new SDC from scratch |
| convert-from-website.md | Clone component from any website |
| convert-from-tailwindplus.md | Use TailwindPlus as base template |
| add-variant.md | Add CVA variants to existing component |
| verify-component.md | Visual verification with Claude in Chrome |
</workflows_index>

<mcp_tools>
## Available MCP Tools

**TailwindPlus MCP:**
- `mcp__tailwindplus__search_component_names` - Search for components
- `mcp__tailwindplus__get_component_by_full_name` - Get component code
- `mcp__tailwindplus__get_component_preview_by_full_name` - Get preview HTML

**Claude in Chrome:**
- `mcp__claude-in-chrome__navigate` - Navigate to URL
- `mcp__claude-in-chrome__computer` - Screenshot, wait, click
- `mcp__claude-in-chrome__javascript_tool` - Extract HTML/CSS
- `mcp__claude-in-chrome__resize_window` - Test breakpoints
</mcp_tools>
