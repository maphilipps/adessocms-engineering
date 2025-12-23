# Design Philosophy Guide

Creating aesthetic manifestos that guide component design with intentionality and craftsmanship.

## What is a Design Philosophy?

A Design Philosophy is a 4-6 paragraph aesthetic manifesto that describes the visual essence of a component before any code is written. It defines:

- **Form & Space** - How shapes and negative space work together
- **Color & Material** - Color theory and material qualities
- **Scale & Rhythm** - Size relationships and repetitions
- **Composition** - Visual balance and hierarchy
- **Craftsmanship** - Quality standards and attention to detail

## Why Philosophy First?

1. **Intentional Design** - Prevents ad-hoc styling decisions
2. **Consistency** - Creates cohesive component families
3. **Communication** - Documents design rationale for teams
4. **Quality Anchor** - Establishes craftsmanship expectations
5. **Anti-AI-Slop** - Forces thoughtful, unique solutions

## Writing a Design Philosophy

### Structure Template

```markdown
# [Component Name] Design Philosophy

## Visual Essence
[1 paragraph describing the core visual idea and emotional quality]

## Form & Space
[1 paragraph on shapes, proportions, negative space usage]

## Color & Material
[1 paragraph on color relationships, surface qualities, depth]

## Motion & Interaction
[1 paragraph on hover states, transitions, feedback]

## Craftsmanship Standard
[1 paragraph emphasizing quality, attention to detail, mastery]
```

### Example: Button Component

```markdown
# Button Design Philosophy

## Visual Essence
The button embodies confident action—a clear invitation to engage. It
communicates importance through visual weight while remaining approachable
through subtle softness. Like a well-crafted door handle, it promises
satisfying interaction before touch.

## Form & Space
Generous horizontal padding creates breathing room for text, preventing
the cramped feeling of hurried design. The border radius varies by context:
smaller for utilitarian actions (md), larger for primary calls-to-action (xl).
Height remains consistent within size variants, creating reliable alignment
in button groups.

## Color & Material
Primary buttons command attention with saturated fills that lift slightly
from the page. Secondary buttons step back with subtle backgrounds that
complement rather than compete. The ghost variant disappears until needed,
revealing itself on hover like a whispered suggestion. All variants maintain
WCAG AA contrast ratios without exception.

## Motion & Interaction
Hover states arrive with purposeful timing—200ms for color transitions,
quick enough to feel responsive, slow enough to appear smooth. Active states
provide immediate tactile feedback through subtle scale reduction (98%).
Disabled states communicate unavailability through reduced opacity while
maintaining visible structure.

## Craftsmanship Standard
Every button must appear as if hand-crafted by a master interface designer.
Focus rings are precisely calibrated with consistent offset. Text sits
optically centered, accounting for font metrics. Icons align perfectly with
text baselines. The result should feel inevitable—as if no other design
were possible.
```

### Example: Card Component

```markdown
# Card Design Philosophy

## Visual Essence
The card serves as a contained universe—a window into focused content
that invites exploration. It creates hierarchy through containment,
signaling "this belongs together" through consistent boundary treatment.
Like a museum vitrine, it presents content with reverence and clarity.

## Form & Space
Cards breathe through generous internal padding that prevents content
from feeling trapped. The container's border radius (lg) creates warmth
without excessive softness. Framed variants add subtle borders that
define edges without harsh separation. Full-bleed variants use imagery
to create visual drama, letting content speak without ornament.

## Color & Material
Surface colors establish hierarchy: elevated cards cast shadows that
suggest physical presence, while flat variants rely on subtle background
shifts. Interactive cards invite touch through hover states that lift
or highlight. The distinction between container and content remains clear
but never jarring.

## Composition
Vertical rhythm follows an 8px baseline grid. Headlines maintain
proximity to supporting text. Media sits flush to edges in full-bleed
variants or maintains consistent gutters in framed variants. Footer
actions align with body content, creating visual continuity.

## Craftsmanship Standard
Card corners must align precisely when placed in grids—no half-pixel
discrepancies. Shadow blur and spread are calibrated to suggest material
depth realistically. Text truncation includes elegant ellipsis handling.
Image aspect ratios are maintained without distortion. The card should
feel like a physical object one could pick up.
```

### Example: Hero Component

```markdown
# Hero Billboard Design Philosophy

## Visual Essence
The hero commands the viewport with cinematic presence—a visual manifesto
that declares the page's purpose within seconds. It borrows from film title
sequences: dramatic scale, purposeful emptiness, confident typography that
needs no explanation. The hero doesn't ask for attention; it assumes it.

## Form & Space
Generous vertical padding creates pause, allowing the message to resonate
before scrolling begins. Headlines scale dramatically across breakpoints,
maintaining impact on every device. Negative space isn't empty—it's
intentional breath that amplifies content significance. The hero occupies
at minimum 70vh, establishing presence without demanding full commitment.

## Color & Material
Background treatments range from subtle gradients to full-bleed imagery.
When images are present, overlays ensure text contrast without flattening
visual interest. Gradient directions follow reading flow. Dark variants
create cinema-like immersion; light variants maintain editorial clarity.

## Typography & Hierarchy
The headline is architectural—it structures the entire composition.
Supporting text whispers context without competing. CTAs provide clear
next steps without shouting. The typographic scale creates unmistakable
hierarchy: headline 6xl, subhead lg, body base.

## Craftsmanship Standard
Hero execution reveals design mastery. Typographic scales must feel
inevitable at every breakpoint—no awkward intermediate sizes. Image
positioning uses art direction, not arbitrary cropping. Gradient
overlays are calibrated to maintain image interest while ensuring
4.5:1 contrast. The hero should feel like the cover of a design annual.
```

## Design Philosophy Principles

### 1. Specificity Over Generality

**Avoid:** "The button should look nice and be easy to use."

**Prefer:** "Horizontal padding of 20px creates breathing room that prevents
the text from feeling cramped, while the 10px border-radius softens the
industrial feel without becoming cartoonish."

### 2. Reference Design Traditions

Connect to established design lineages:

- "Drawing from Swiss typographic traditions..."
- "Like the confident minimalism of Dieter Rams..."
- "Channeling the editorial clarity of Massimo Vignelli..."
- "With the material honesty of Bauhaus principles..."

### 3. Emphasize Craftsmanship Repeatedly

Every philosophy must include multiple references to quality:

- "Meticulously calibrated"
- "Painstakingly refined"
- "Precision-engineered"
- "Master-level execution"
- "Museum-quality finish"
- "The result of countless iterations"

### 4. Address All States

Consider and document:

- Default state
- Hover state
- Focus state
- Active/pressed state
- Disabled state
- Loading state (if applicable)
- Error state (if applicable)

### 5. Include Accessibility as Quality

Accessibility isn't separate—it's part of craftsmanship:

"Focus indicators are not afterthoughts but integral design elements,
calibrated with the same care as hover states. WCAG AA contrast isn't
a constraint but a quality floor that ensures universal access."

## Anti-Patterns to Avoid

### In Writing

- Vague descriptions ("looks modern", "feels clean")
- Technical-only language (pure CSS descriptions)
- Missing emotional quality
- No craftsmanship emphasis
- Ignoring interaction states

### In Resulting Design

- Centered everything (use intentional asymmetry)
- Purple gradients (choose purposeful palettes)
- Uniform rounded corners (vary by context)
- Generic Inter font (select typography thoughtfully)
- Missing breathing room
- Inconsistent spacing
- Overlooked edge cases

## From Philosophy to Implementation

After writing the philosophy:

1. **Extract Design Tokens** - Identify specific values mentioned (padding, radius, timing)
2. **Define CVA Variants** - Map conceptual variants to class combinations
3. **Create Responsive Rules** - Document how philosophy adapts across breakpoints
4. **Document States** - List all interaction states with their treatments
5. **Establish Quality Checks** - Create verification criteria from philosophy

### Philosophy → CVA Mapping Example

**Philosophy excerpt:**
> "Primary buttons command attention with saturated fills... Secondary buttons
> step back with subtle backgrounds... The ghost variant disappears until needed."

**CVA Implementation:**
```twig
variants: {
  variant: {
    primary: 'bg-primary text-primary-foreground hover:bg-primary/90',
    secondary: 'bg-secondary text-secondary-foreground hover:bg-secondary/80',
    ghost: 'bg-transparent hover:bg-accent hover:text-accent-foreground'
  }
}
```

## Quality Checklist for Philosophies

Before finalizing a design philosophy:

- [ ] Visual essence clearly articulated
- [ ] Form & space relationships described
- [ ] Color approach documented
- [ ] Motion & interaction covered
- [ ] Craftsmanship emphasized (at least 3 references)
- [ ] All interaction states addressed
- [ ] Accessibility integrated naturally
- [ ] Specific enough to guide implementation
- [ ] Inspirational enough to maintain quality standards
- [ ] References established design traditions
