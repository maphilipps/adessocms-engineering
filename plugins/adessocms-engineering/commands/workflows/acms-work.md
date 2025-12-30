---
name: acms-work
description: Execute Beads Epic via Ralph Wiggum loop
argument-hint: "[epic-id or leave empty to select]"
---

# /acms-work - Beads Epic Executor

Arbeitet ein Beads Epic mit Ralph Wiggum Loop ab.

## Prerequisite

```bash
if ! command -v bd &> /dev/null; then
  echo "❌ Beads CLI nicht installiert!"
  echo "Installation: npm install -g @beads/bd"
  exit 1
fi
```

## 1. Epic auswählen

```bash
bd list --type epic --status open
```

Frage User mit AskUserQuestion welches Epic:

```
AskUserQuestion(questions=[{
  "question": "Welches Epic möchtest du bearbeiten?",
  "header": "Epic",
  "options": [
    {"label": "<epic-id>", "description": "<Epic-Titel> (N Subtasks)"},
    ...
  ],
  "multiSelect": false
}])
```

## 2. Ralph Wiggum Loop starten

```
Skill ralph-wiggum:ralph-loop
```

**Loop-Inhalt für Ralph Wiggum:**

```
LOOP bis Epic abgeschlossen:

1. NÄCHSTEN TASK HOLEN
   bd ready --parent <epic-id>
   → Wenn leer: Epic ist fertig → EXIT LOOP

2. TASK STARTEN
   bd update <task-id> --status in_progress

3. TASK IMPLEMENTIEREN
   - Lies Task-Beschreibung: bd show <task-id>
   - Implementiere gemäß Beschreibung
   - Teste die Änderungen
   - Committe: git add . && git commit -m "feat: <task-titel>"

4. TASK ABSCHLIEßEN
   bd close <task-id> --reason "Implemented in <commit-sha>"

5. ZURÜCK ZU 1.

END LOOP
```

## 3. Abschlusskriterien (Exit Conditions)

**Epic ist FERTIG wenn:**
- [ ] `bd ready --parent <epic-id>` gibt keine Tasks mehr zurück
- [ ] Alle Subtasks haben Status "closed"
- [ ] Alle Commits gepusht: `git push`

**Dann:**
```bash
bd close <epic-id> --reason "All subtasks completed"
bd sync
git push
```

## 4. Bei Blockern

Falls ein Task nicht abgeschlossen werden kann:

```bash
# Task als blocked markieren
bd update <task-id> --status blocked -d "Grund: <beschreibung>"

# Weiter zum nächsten Task
→ zurück zu Schritt 1
```

## Quality Gates (pro Task)

Vor `bd close`:

### Basis-Checks
- [ ] Code kompiliert/läuft
- [ ] Tests passen (falls vorhanden)
- [ ] Commit erstellt

### Bei SDC-Änderungen (*.component.yml, components/*.twig)

Konsultiere `docs/solutions/sdc/best-practices.md` und prüfe:
- [ ] `$schema` Reference vorhanden
- [ ] Props haben `type`, `title`, `description`
- [ ] HTML/Render Arrays als Slots (kein Prop Drilling)
- [ ] `{% set x = x|default(...) %}` für alle Props
- [ ] `with_context = false` bei includes
- [ ] `only` bei embeds

### Bei Twig-Änderungen (*.html.twig)

Konsultiere `docs/solutions/paragraphs/best-practices.md` und prüfe:
- [ ] Kein `.value` Access (`paragraph.field_x.value`)
- [ ] Kein Render Array Destructuring (`content.field_x.0['#item']`)
- [ ] Semantic HTML (`<h1>`-`<h6>`, `<figure>`) nur in SDC
- [ ] Fields via `{{ content.field_name }}`

### Bei Paragraph-Templates (paragraph--*.html.twig)

- [ ] Delegiert an SDC Component (embed/include)
- [ ] Scalar Props mit `|render|trim` extrahiert
- [ ] Cache Metadata erhalten (keine Entity-Destrukturierung)

## Land the Plane

Nach Epic-Abschluss:

```bash
bd sync
git push  # MANDATORY
git status  # "up to date with origin"
```

> **"Work is NOT complete until `git push` succeeds"**
