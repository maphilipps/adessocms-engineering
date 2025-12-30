---
event: PostToolUse
tools:
  - Write
  - Edit
match_path: "**/*.twig"
---

# Twig Template Validator Hook

Validiere Twig Templates nach Schreiben/Bearbeiten.

## Action

**Determine the appropriate specialist based on file type:**

### Für SDC Templates (components/*.twig)

```
Task(
  subagent_type="adessocms-engineering:specialists:sdc-specialist",
  prompt="Review this SDC Twig template for best practices. Check: defaults for props, attributes.addClass(), with_context=false, only in embeds, no render array destructuring. File: <changed_file_path>",
  description="SDC Twig validation"
)
```

### Für Paragraph Templates (paragraph--*.twig)

```
Task(
  subagent_type="adessocms-engineering:specialists:paragraphs-specialist",
  prompt="Review this Paragraph template for best practices. Check: no .value access, SDC delegation, cache metadata preservation, proper slot usage. File: <changed_file_path>",
  description="Paragraph template validation"
)
```

### Für Field Templates (field--*.twig)

```
Task(
  subagent_type="adessocms-engineering:specialists:paragraphs-specialist",
  prompt="Review this Field template for best practices. Check: proper item rendering, SDC delegation where appropriate, no semantic HTML (belongs in SDC). File: <changed_file_path>",
  description="Field template validation"
)
```

### Für andere Twig Templates

```
Task(
  subagent_type="adessocms-engineering:specialists:twig-specialist",
  prompt="Review this Twig template for best practices. Check: security (autoescape), performance, accessibility, proper Drupal patterns. File: <changed_file_path>",
  description="Twig validation"
)
```

## Bei Problemen

Der Agent gibt strukturiertes Feedback mit Prioritäten:
- **Critical**: Cache-breaking, Security issues
- **High**: Best practice violations
- **Medium**: Style, maintainability
- **Low**: Suggestions

Informiere den User und biete Fixes an, blockiere aber nicht.
