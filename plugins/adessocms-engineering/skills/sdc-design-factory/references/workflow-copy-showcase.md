# Workflow: Copy from Tailwind Showcase

Workflow for creating SDC components inspired by websites in the Tailwind CSS Showcase.

## Important Notes

**Never copy copyrighted content directly.** This workflow is for learning from design patterns
and recreating the structural/visual approach with original content.

## Phase 1: Inspiration Gathering

### Step 1.1: Browse Tailwind Showcase

Visit https://tailwindcss.com/showcase and identify components that match the needed pattern:

- Hero sections
- Card layouts
- Navigation patterns
- Feature grids
- Testimonial displays
- Pricing tables
- Footer layouts

### Step 1.2: Analyze the Chosen Design

For the inspiring component, document:

**Visual Analysis:**
- Layout structure (grid, flex, positioning)
- Spacing patterns (padding, margins, gaps)
- Typography scale (heading sizes, body text)
- Color usage (primary, accents, neutrals)
- Shadow/elevation effects
- Border treatments
- Animation/transitions

**Structural Analysis:**
- HTML semantic structure
- Responsive breakpoints used
- Interactive states
- Accessibility patterns

### Step 1.3: Create Screenshots for Reference

**Use Claude in Chrome (PRIMARY):**

```
mcp__claude-in-chrome__tabs_context_mcp
mcp__claude-in-chrome__navigate(url="https://example.com", tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="wait", duration=2, tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
# Save screenshot as: inspiration/hero-reference.png
```

**Fallback (only if Claude in Chrome unavailable):** Use Playwright MCP.

## Phase 2: Design Abstraction

### Step 2.1: Extract Design Principles

Don't copy—abstract the design principles:

**Before (specific):** "OpenAI uses a dark navy #0a0a0f background with white text"

**After (abstract):** "Dark dramatic backgrounds with high-contrast text create
a sophisticated, premium feel. The near-black backdrop allows accent colors
to pop while maintaining readability."

### Step 2.2: Write Original Design Philosophy

Create a unique aesthetic manifesto inspired by (not copied from) the reference:

```markdown
# [Component Name] Design Philosophy

## Visual Essence
[Your original interpretation of the visual concept]

## Form & Space
[Your approach to layout and whitespace, inspired by but not copying the reference]

## Color & Material
[Your color strategy, using your theme's palette]

## Craftsmanship Standard
[Quality expectations for the implementation]
```

### Step 2.3: Map to Theme Variables

Translate the design to your existing design tokens:

| Observed Pattern | Your Theme Token |
|-----------------|------------------|
| Dark background | `bg-background` (dark theme) |
| White text | `text-foreground` |
| Accent color | `bg-primary` |
| Large heading | `text-5xl md:text-6xl xl:text-7xl` |

## Phase 3: Component Creation

### Step 3.1: Create Component Structure

Follow the standard Mercury SDC structure:

```
components/hero-dramatic/
├── hero-dramatic.component.yml
├── hero-dramatic.twig
├── hero-dramatic.tailwind.css (if needed)
└── assets/
    └── placeholder.jpg
```

### Step 3.2: Build Semantic HTML

Start with proper HTML structure (not the exact HTML from the source):

```twig
<section class="hero-dramatic" aria-labelledby="{{ heading_id }}">
  <div class="hero-dramatic--background">
    {# Background treatment #}
  </div>

  <div class="hero-dramatic--content">
    <h1 id="{{ heading_id }}" class="hero-dramatic--headline">
      {% block headline %}{{ headline }}{% endblock %}
    </h1>

    {% if subheadline %}
      <p class="hero-dramatic--subheadline">
        {{ subheadline }}
      </p>
    {% endif %}

    <div class="hero-dramatic--actions">
      {% block actions %}{% endblock %}
    </div>
  </div>
</section>
```

### Step 3.3: Apply CVA Variants

Create variants for different use cases:

```twig
{% set hero = html_cva(
  base: [
    'relative min-h-[70vh] flex items-center',
    'overflow-hidden'
  ],
  variants: {
    theme: {
      dark: 'bg-gray-950 text-white',
      light: 'bg-background text-foreground',
      gradient: 'bg-gradient-to-br from-primary to-secondary text-white'
    },
    alignment: {
      center: 'text-center justify-center',
      left: 'text-left justify-start',
      split: 'justify-between'
    },
    size: {
      compact: 'min-h-[50vh] py-16',
      standard: 'min-h-[70vh] py-24',
      full: 'min-h-screen py-32'
    }
  }
) %}
```

### Step 3.4: Implement Responsive Behavior

Ensure the component adapts across breakpoints:

```twig
<div class="
  px-4 md:px-6 lg:px-8
  max-w-4xl md:max-w-5xl lg:max-w-6xl
  mx-auto
">
  <h1 class="
    text-3xl md:text-4xl lg:text-5xl xl:text-6xl
    font-bold tracking-tight
    leading-tight
  ">
    {{ headline }}
  </h1>

  <p class="
    mt-4 md:mt-6
    text-lg md:text-xl lg:text-2xl
    text-muted-foreground
    max-w-2xl
  ">
    {{ subheadline }}
  </p>
</div>
```

## Phase 4: Original Content

### Step 4.1: Replace All Content

Never use content from the source. Create original:

- Headlines and copy
- Images (use placeholders or stock)
- Icons (use your icon set)
- Color values (use your palette)

### Step 4.2: Add Unique Features

Go beyond the inspiration by adding:

- Additional variants not in the original
- Better accessibility (the original may lack it)
- Dark mode support
- Animation refinements
- Enhanced responsive behavior

## Phase 5: Documentation

### Step 5.1: Credit Inspiration (Optionally)

In internal documentation, you may note:

```markdown
## Design Inspiration

This component's layout was inspired by patterns seen in modern SaaS landing pages,
particularly the dramatic hero sections common in developer-focused products.
The implementation is original and uses our design system tokens.
```

### Step 5.2: Document Differences

Note how your component differs from the inspiration:

```markdown
## Our Approach

Unlike typical implementations that use fixed breakpoints, our hero component:
- Uses fluid typography with clamp()
- Supports multiple theme variants
- Includes full accessibility implementation
- Integrates with our CVA system
```

## Common Patterns from Showcase

### Hero Patterns

| Pattern | Description | Key Techniques |
|---------|-------------|----------------|
| **Dramatic Dark** | Dark bg, white text, minimal | High contrast, generous whitespace |
| **Split Layout** | Text left, media right | Grid/flex, responsive stack on mobile |
| **Gradient Overlay** | Image with gradient | Background-blend, overlay positioning |
| **Animated** | Subtle motion | Fade-in, parallax, floating elements |

### Card Patterns

| Pattern | Description | Key Techniques |
|---------|-------------|----------------|
| **Elevated** | Shadow, rounded, subtle hover lift | box-shadow, transition-transform |
| **Bordered** | Clear border, minimal shadow | border-width, hover:border-color |
| **Full-bleed Image** | Image extends to edges | overflow-hidden, object-cover |
| **Icon-led** | Large icon, centered | Icon sizing, consistent padding |

### Navigation Patterns

| Pattern | Description | Key Techniques |
|---------|-------------|----------------|
| **Transparent → Solid** | Scrolls to solid bg | JS scroll listener, backdrop-blur |
| **Mega Menu** | Large dropdown with columns | Grid layout, absolute positioning |
| **Mobile Drawer** | Slide-in mobile menu | Transform, fixed positioning |

## Anti-Patterns to Avoid

When adapting from showcase:

- **Don't copy HTML verbatim** - Write semantic structure appropriate for Drupal
- **Don't copy colors** - Use your theme's CSS custom properties
- **Don't copy fonts** - Use your theme's typography scale
- **Don't copy images** - Use placeholders or licensed alternatives
- **Don't copy text** - Create original content
- **Don't skip accessibility** - Many showcase sites have gaps
- **Don't ignore mobile** - Always verify responsive behavior

## Output Checklist

After completing this workflow:

- [ ] Original design philosophy written
- [ ] Component uses theme design tokens only
- [ ] All content is original
- [ ] CVA variants implemented
- [ ] Responsive behavior verified
- [ ] Accessibility complete
- [ ] No copyrighted material copied
- [ ] Documentation includes approach notes
