# Jira Ticket Template

## Story: New Component

```markdown
**Project**: DS
**Type**: Story
**Summary**: [Component] - Implement [name] SDC component

### Description

**As a** site builder
**I want** a [component name] component
**So that** I can [business value]

#### Reference
- Quartz: [link to Storybook story if applicable]
- Figma: [link if available]

### Acceptance Criteria

- [ ] Component directory created at `components/[name]/`
- [ ] `[name].component.yml` with complete prop schema
- [ ] `[name].twig` template with semantic HTML
- [ ] `[name].stories.js` with:
  - [ ] Default story
  - [ ] All variants documented
  - [ ] Edge cases (empty, long content)
- [ ] Passes `ddev eslint` and `ddev stylelint`
- [ ] Passes `ddev story-check`
- [ ] Accessible (WCAG 2.1 AA):
  - [ ] Keyboard navigable
  - [ ] Screen reader compatible
  - [ ] Sufficient color contrast
- [ ] Responsive (mobile, tablet, desktop)
- [ ] [Custom criteria...]

### Technical Notes

**Dependencies**: [list any required components]
**Drupal Integration**: [paragraph type, field, block?]
**JS Behavior**: [Alpine.js, vanilla JS, none?]

### Effort

- **Size**: S / M / L / XL
- **Complexity**: Low / Medium / High
- **Estimated**: X story points

### Labels

component, sdc, [category: atom/molecule/organism]
```

---

## Task: Enhancement

```markdown
**Project**: DS
**Type**: Task
**Summary**: [Component] - [Enhancement description]

### Description

Enhance the [component] component to [improvement].

#### Current State
[What exists now]

#### Desired State
[What should change]

### Acceptance Criteria

- [ ] [Specific criterion 1]
- [ ] [Specific criterion 2]
- [ ] Existing functionality preserved
- [ ] Stories updated
- [ ] No lint errors

### Technical Notes

[Implementation details]

### Effort

- **Size**: S / M / L
```

---

## Bug: Defect Fix

```markdown
**Project**: DS
**Type**: Bug
**Summary**: [Component] - [Brief bug description]

### Description

**Bug**: [What's wrong]
**Impact**: [How it affects users]

### Steps to Reproduce

1. [Step 1]
2. [Step 2]
3. [Step 3]

### Expected Behavior

[What should happen]

### Actual Behavior

[What happens instead]

### Environment

- Browser: [Chrome/Firefox/Safari]
- Device: [Desktop/Mobile]
- URL: [if applicable]

### Acceptance Criteria

- [ ] Bug no longer reproducible
- [ ] No regression in related functionality
- [ ] Test added to prevent recurrence

### Severity

Critical / High / Medium / Low
```

---

## Epic: Feature Set

```markdown
**Project**: DS
**Type**: Epic
**Summary**: [Feature Area] - [High-level goal]

### Description

[Overview of the feature set]

### Business Value

[Why this matters]

### Child Issues

1. **Story**: [First component/feature]
2. **Story**: [Second component/feature]
3. **Task**: [Technical work]
...

### Success Metrics

- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]

### Timeline

Target: [Quarter/Date]
```
