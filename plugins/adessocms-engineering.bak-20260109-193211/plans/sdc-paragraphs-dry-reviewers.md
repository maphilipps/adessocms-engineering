---
date: 2025-12-14
feature: SDC, Paragraphs & DRY Review Agents
status: completed
---

# feat: Add SDC, Paragraphs & DRY Best Practices Reviewers

## Summary

Added 3 new specialized review agents for Drupal frontend best practices: SDC (Single Directory Components), Paragraphs integration, and DRY (Don't Repeat Yourself) principle enforcement. Updated `/acms-review` to include these agents and `/acms-plan` to include DRY analysis during planning.

## Research Findings

### SDC Best Practices (Context7 + drupal.org)

**Props vs Slots**:
- Props: Structured, validated data (JSON Schema)
- Slots: Flexible HTML content, nested components
- Never destructure render arrays (breaks caching)

**component.yml Schema**:
- `$schema` reference required for validation
- `enforce_prop_schemas: true` in theme.info.yml
- Use enums for limited options, set defaults

**Key Anti-Patterns**:
- Prop drilling (separate image_url, image_alt, etc.)
- Missing default values in Twig
- Hardcoded classes instead of attributes object

### Paragraphs Best Practices (chromatichq.com + qed42.com)

**CRITICAL: No .value Access**:
- `{{ paragraph.field_title.value }}` breaks caching
- Use `{{ content.field_title }}` (preserves cache metadata)
- Override field templates for custom markup

**SDC Integration**:
- Use `{% embed %}` for slot-based components
- Use `{% include %}` with `with_context = false`
- Move logic to preprocess functions

**Helpful Modules**:
- Paragraph SDC - Dedicated paragraph type for SDC
- SDC Display - SDC as field formatters
- UI Patterns - SDC in Display Suite
- Paragraphs View Modes - Per-instance view mode selection

### DRY Principle (User Requirement)

**"3 Occurrences Before Abstraction"**:
1. First time: Just write it
2. Second time: Note the duplication
3. Third time: Extract the abstraction

**Component Reuse Priority**:
1. Use existing component
2. Add variant to existing component
3. Extend via slots/blocks
4. Only then: Create new component

## Implementation (Completed)

### Phase 1: Create Agents

- [x] `agents/review/sdc-best-practices-reviewer.md`
  - Props vs Slots design
  - component.yml schema quality
  - Twig template patterns
  - Component replacement rules

- [x] `agents/review/paragraphs-best-practices-reviewer.md`
  - Field templates vs .value access
  - SDC integration patterns
  - Preprocess functions
  - Cache metadata preservation

- [x] `agents/review/dry-component-reuse-reviewer.md`
  - Component reuse analysis
  - Atomic design violations
  - CSS/Tailwind duplication
  - PHP preprocess duplication

### Phase 2: Update Commands

- [x] `commands/workflows/acms-review.md`
  - Added 3 new agents to parallel review list
  - Updated Agent Selection Guide table

- [x] `commands/workflows/acms-plan.md`
  - Added Step 1b: DRY Analysis (ALWAYS)
  - Added "Component Reuse Analysis" section to plan template

### Phase 3: Update Plugin Metadata

- [x] `.claude-plugin/plugin.json`
  - Version: 1.8.4 → 1.9.0
  - Agents: 28 → 31

- [x] `CHANGELOG.md`
  - Added v1.9.0 entry with full documentation

## Files Modified/Created

| File | Action |
|------|--------|
| `agents/review/sdc-best-practices-reviewer.md` | Created |
| `agents/review/paragraphs-best-practices-reviewer.md` | Created |
| `agents/review/dry-component-reuse-reviewer.md` | Created |
| `commands/workflows/acms-review.md` | Modified |
| `commands/workflows/acms-plan.md` | Modified |
| `.claude-plugin/plugin.json` | Modified |
| `CHANGELOG.md` | Modified |

## Acceptance Criteria

- [x] SDC reviewer checks props/slots usage
- [x] Paragraphs reviewer flags .value access as CRITICAL
- [x] DRY reviewer identifies component duplication
- [x] `/acms-review` includes new agents for appropriate file types
- [x] `/acms-plan` includes DRY analysis section
- [x] Version bumped to 1.9.0
- [x] CHANGELOG documents all changes

## Usage Examples

### Review SDC Changes
```bash
/acms-review
# Automatically includes sdc-best-practices-reviewer for .component.yml/.twig changes
```

### Review Paragraphs
```bash
/acms-review
# Includes paragraphs-best-practices-reviewer for paragraph--*.twig changes
```

### DRY in Planning
```bash
/acms-plan "Add feature card component"
# Step 1b searches for existing card/feature components first
# Plan includes "Component Reuse Analysis" section
```

## References

- [Drupal SDC Documentation](https://www.drupal.org/docs/develop/theming-drupal/using-single-directory-components)
- [Props and Slots](https://www.drupal.org/docs/develop/theming-drupal/using-single-directory-components/what-are-props-and-slots-in-drupal-sdc-theming)
- [UI Patterns Best Practices](https://project.pages.drupalcode.org/ui_patterns/2-authors/2-best-practices)
- [Paragraphs + SDC Integration](https://chromatichq.com/insights/dynamic-duo-sdc-paragraphs/)
- [SDC Variations with Paragraphs](https://www.qed42.com/insights/integration-of-sdc-variations-with-paragraphs)
