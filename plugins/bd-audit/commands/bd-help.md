---
name: bd-help
description: "Zeigt alle verfügbaren BD-Audit Commands mit Beispielen"
allowed-tools: []
---

Zeige dem Benutzer alle verfügbaren Commands:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
       BD-AUDIT COMMANDS - Hilfe
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

AUDITS STARTEN
──────────────

/bd example.com           Vollständiger Audit (60-90 Min)
/bd example.com --quick   Schnell-Check (5-10 Min)
/bd example.com --tech    Nur technische Analyse
/bd example.com --marketing   Nur Marketing-Analyse
/bd example.com --legal   Nur Legal/Compliance
/bd example.com --no-deploy   Ohne Git Push

REPORTS & OUTPUT
────────────────

/bd-ppt firmenname        PowerPoint Präsentation erstellen
/bd-onepager firmenname   Executive Summary (1 Seite)
/bd-open firmenname       Report im Browser öffnen

VERWALTUNG
──────────

/bd-list                  Alle Audits anzeigen
/bd-status                Laufende Audits prüfen
/bd-help                  Diese Hilfe anzeigen

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

BEISPIELE
─────────

# Neuen Kunden schnell bewerten
/bd kunde.de --quick

# Vollständige Analyse für Pitch
/bd enterprise-kunde.com

# Präsentation für Meeting erstellen
/bd-ppt enterprise-kunde

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

REPORTS ONLINE
──────────────

Alle Reports: https://audits.adessocms.de/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```
