---
event: PostToolUse
tools:
  - Write
  - Edit
match_path: "**/*.component.yml"
---

# SDC Component Validator Hook

Validiere SDC component.yml Dateien nach Schreiben/Bearbeiten.

## Validation

Prüfe die geänderte Datei auf:

1. **Schema-Referenz vorhanden?**
   ```yaml
   $schema: https://git.drupalcode.org/project/drupal/-/raw/HEAD/core/assets/schemas/v1/metadata.schema.json
   ```

2. **Name und Description?**
   ```yaml
   name: Component Name
   description: Clear description
   ```

3. **Props-Schema korrekt?**
   - Alle Props haben `type`
   - Alle Props haben `title`
   - Enums für begrenzte Optionen
   - Defaults wo sinnvoll

4. **Slots statt Prop-Drilling?**
   - Keine `image_url`, `image_alt` Props
   - HTML Content als Slot, nicht als Prop

## Bei Problemen

Wenn Validierung fehlschlägt:

```
⚠️ SDC Validation Warning:
- Missing $schema reference
- Prop 'image_url' should probably be a slot

📖 See: docs/solutions/sdc/best-practices.md
```

Frage den User ob er die Probleme beheben möchte, aber blockiere nicht.
