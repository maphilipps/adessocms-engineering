---
name: adesso-styleguide
description: Guardian für adesso Corporate Design Compliance. Prüft, korrigiert und implementiert Styling nach dem offiziellen adesso Styleguide (Juni 2025). Konfiguriert Tailwind CSS, validiert Farben/Typografie/Icons, und stellt Brand-Konformität sicher.
---

<essential_principles>

<principle name="adesso-Blau ist heilig">
**#006ec7** - Keine Abstufungen erlaubt. Vermeide Aufhellen oder Abdunkeln. Bei Kontrast-Problemen: Weiß oder adesso-Grau verwenden.
</principle>

<principle name="Akzentfarben sparsam">
Akzentfarben (Gelb, Orange, Pink, Violett, Türkis, Grün) nur als Highlights. Maximal 2 pro Design. Nie dominierend.
</principle>

<principle name="Farbverläufe brauchen adesso-Blau">
Jeder Gradient sollte adesso-Blau enthalten. Vermeide Verläufe nur aus Akzentfarben.
</principle>

<principle name="FontAwesome Thin">
Icons ausschließlich im "Thin" Style (fa-thin). Keine anderen Stärken (solid, regular, light).
</principle>

<principle name="Typografie-Hierarchie">
- Headlines: Klavika (Bold/Medium)
- Fließtext: ABC Marist (Regular)
- Fallback/Web: Fira Sans
</principle>

</essential_principles>

<intake>
**Was möchtest du tun?**

1. **Code/Design reviewen** - Prüfen ob Styleguide eingehalten wird
2. **Styling korrigieren** - Nicht-konforme Styles fixen
3. **Tailwind konfigurieren** - adesso Design System in Tailwind einrichten
4. **Farben anwenden** - Hilfe bei korrekter Farbverwendung
5. **Typografie einrichten** - Schriften korrekt implementieren
6. **Icons validieren** - FontAwesome Thin Icons prüfen
7. **Etwas anderes**

**Warte auf Antwort, dann lade den passenden Workflow.**
</intake>

<routing>
| Antwort | Workflow |
|---------|----------|
| 1, "review", "prüfen", "check" | `workflows/review-compliance.md` |
| 2, "fix", "korrigieren", "fixen", "ändern" | `workflows/fix-styling.md` |
| 3, "tailwind", "config", "konfigurieren" | `workflows/configure-tailwind.md` |
| 4, "farben", "colors", "blau", "grau" | `workflows/apply-colors.md` |
| 5, "font", "schrift", "typografie" | `workflows/apply-typography.md` |
| 6, "icon", "icons", "fontawesome" | `workflows/validate-icons.md` |
| 7, andere | Klären, dann passenden Workflow oder Reference laden |
</routing>

<color_quick_reference>
**Primärfarben:**
- `adesso-blau`: #006ec7 (keine Tints)
- `adesso-grau`: #887d75 (Tints 10-90% erlaubt)

**Akzentfarben:**
- `accent-gelb`: #ffff00
- `accent-orange`: #ff9868
- `accent-pink`: #f566ba
- `accent-violett`: #461ebe
- `accent-tuerkis`: #28dcaa
- `accent-gruen`: #76c800
</color_quick_reference>

<reference_index>
Alle Domain-Knowledge in `references/`:

**Farben:** colors.md, gradients.md
**Typografie:** typography.md
**Icons:** icons.md
**Logo:** logo.md
**Implementierung:** tailwind-config.md
**Verbote:** anti-patterns.md
</reference_index>

<workflows_index>
| Workflow | Zweck |
|----------|-------|
| review-compliance.md | Code auf Styleguide-Konformität prüfen |
| fix-styling.md | Nicht-konforme Styles korrigieren |
| configure-tailwind.md | Tailwind CSS für adesso einrichten |
| apply-colors.md | Farbsystem korrekt anwenden |
| apply-typography.md | Schriften implementieren |
| validate-icons.md | Icons prüfen und korrigieren |
</workflows_index>
