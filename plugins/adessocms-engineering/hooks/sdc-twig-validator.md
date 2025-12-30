---
event: PostToolUse
tools:
  - Write
  - Edit
match_path: "**/*.component.yml"
---

# SDC Component Validator Hook

Validiere SDC component.yml Dateien nach Schreiben/Bearbeiten.

## Action

**Invoke the SDC Specialist Agent for validation:**

```
Task(
  subagent_type="adessocms-engineering:specialists:sdc-specialist",
  prompt="Review this SDC component.yml file for best practices compliance. Check: schema reference, props structure, slots vs prop drilling, defaults. File: <changed_file_path>",
  description="SDC validation"
)
```

Der Agent hat alle Best Practices eingebaut und liefert:
- Critical Issues
- High/Medium/Low Priority Findings
- Konkrete Fix-Vorschläge

## Bei Problemen

Der Agent gibt strukturiertes Feedback. Bei Critical Issues:
- Informiere den User
- Biete an, die Probleme zu beheben
- Blockiere NICHT den Workflow
