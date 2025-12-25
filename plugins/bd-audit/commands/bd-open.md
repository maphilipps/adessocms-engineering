---
name: bd-open
description: "Öffnet Audit-Report im Browser"
argument-hint: "<firmenname>"
allowed-tools: ["Bash", "Glob"]
---

Öffne den Audit-Report für den angegebenen Firmennamen im Browser.

## Workflow

1. Finde den Report:
```bash
find reports/ -type d -name "*${FIRMENNAME}*" | head -1
```

2. Ermittle die Online-URL:
```
https://audits.adessocms.de/[jahr]/[monat]/[firmenname]/
```

3. Öffne im Browser:
```bash
open "https://audits.adessocms.de/${YEAR}/${MONTH}/${FIRMENNAME}/"
```

## Fallback

Wenn der Report noch nicht deployed ist:
```bash
# Lokaler VitePress Dev Server
cd reports/ && npx vitepress dev
```

Dann: `http://localhost:5173/[jahr]/[monat]/[firmenname]/`

## Output

```
🌐 Öffne Report im Browser...

URL: https://audits.adessocms.de/2025/12/locarno-film-festival/

Falls nicht verfügbar, lokaler Server:
cd reports/ && npx vitepress dev
→ http://localhost:5173/
```
