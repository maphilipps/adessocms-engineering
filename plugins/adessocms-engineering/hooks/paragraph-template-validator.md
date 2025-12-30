---
event: PostToolUse
tools:
  - Write
  - Edit
match_path: "**/paragraph--*.html.twig"
---

# Paragraph Template Validator Hook

Spezifische Validierung für Paragraph Templates.

## Action

**Invoke the Paragraphs Specialist Agent:**

```
Task(
  subagent_type="adessocms-engineering:specialists:paragraphs-specialist",
  prompt="Review this Paragraph template for best practices compliance.

Check specifically:
1. No .value access (paragraph.field_x.value) - use content.field_x
2. No render array destructuring (content.field_x.0['#item'])
3. SDC delegation via embed/include with 'only' keyword
4. Semantic HTML (<h1>-<h6>, <figure>) only in SDC, not here
5. Scalar props extracted with |render|trim
6. Cache metadata preserved through render arrays

File: <changed_file_path>",
  description="Paragraph validation"
)
```

## Agent Knowledge

Der Paragraphs Specialist hat eingebaut:
- Field Templates vs .value Access patterns
- SDC Integration patterns (embed vs include)
- Preprocess function best practices
- View Mode usage
- Cache metadata preservation
- Common issues & solutions

## Bei Problemen

Der Agent liefert:
```markdown
## Critical Issues (Cache/Data Integrity)
### Direct Value Access (line X)
**Issue**: `{{ paragraph.field_title.value }}`
**Impact**: Bypasses caching
**Fix**: Use `{{ content.field_title }}`
```

Informiere den User über kritische Issues und biete Fixes an.
