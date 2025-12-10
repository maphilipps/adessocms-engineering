# Component Specification Template

## [Component Name]

**Type**: Atom | Molecule | Organism | Section | Region
**Quartz Equivalent**: [name or "N/A"]
**Priority**: P1 | P2 | P3 | P4

---

### Overview

[Brief description of what this component does and when to use it]

### Use Cases

1. [Primary use case]
2. [Secondary use case]
3. [Edge case to support]

---

### Props Schema

```yaml
$schema: https://git.drupalcode.org/project/drupal/-/raw/11.x/core/modules/sdc/src/metadata.schema.json
name: [Component Name]
description: [Description]
props:
  type: object
  required:
    - [required_prop]
  properties:
    [prop_name]:
      type: [string|number|boolean|array|object]
      title: [Display Name]
      description: [What this prop does]
      default: [default value]
      enum: [optional: allowed values]
```

### Slots

| Slot | Required | Description |
|------|----------|-------------|
| default | Yes/No | [What goes here] |
| [slot_name] | Yes/No | [What goes here] |

---

### Variants

| Variant | Props | Description |
|---------|-------|-------------|
| Default | - | Base appearance |
| [variant] | `prop: value` | [Description] |

---

### Accessibility Requirements

- [ ] Semantic HTML element: `<[element]>`
- [ ] ARIA role: `[role]` (if needed)
- [ ] ARIA attributes: `[list]`
- [ ] Keyboard navigation: [describe]
- [ ] Focus management: [describe]
- [ ] Screen reader: [considerations]

---

### Responsive Behavior

| Breakpoint | Behavior |
|------------|----------|
| Mobile (<640px) | [description] |
| Tablet (640-1024px) | [description] |
| Desktop (>1024px) | [description] |

---

### Drupal Integration

**Paragraph Type**: [name or "N/A"]
**Fields**:
- `field_[name]` - [type] - Maps to `[prop]`

**Block**: [name or "N/A"]

**Preprocess**: [hook or "N/A"]

---

### Dependencies

**Components**:
- [component-name] - [why needed]

**Libraries**:
- [library] - [purpose]

**Modules**:
- [module] - [purpose]

---

### Stories

```javascript
// [component-name].stories.js

export default {
  title: 'Components/[Category]/[Name]',
  tags: ['autodocs'],
  argTypes: {
    [prop]: {
      control: '[type]',
      description: '[description]',
    },
  },
};

export const Default = {
  args: {
    [prop]: '[value]',
  },
};

export const [Variant] = {
  args: {
    [prop]: '[value]',
  },
};
```

---

### Implementation Notes

[Any technical considerations, gotchas, or implementation details]

---

### References

- Quartz: [link]
- Figma: [link]
- Similar: [links to similar implementations]
