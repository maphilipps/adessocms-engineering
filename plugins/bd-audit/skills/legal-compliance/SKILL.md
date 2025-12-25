---
name: Legal Compliance
description: Rechtliche Anforderungen für Websites (BFSG, DSGVO, TMG)
version: 1.0.0
---

# Legal Compliance

Rechtliche Anforderungen und Compliance-Checklisten für deutsche Websites.

## BFSG - Barrierefreiheitsstärkungsgesetz

### Überblick

| Aspekt | Details |
|--------|---------|
| **Inkrafttreten** | 28.06.2025 |
| **Geltungsbereich** | B2C Websites & Apps |
| **Standard** | WCAG 2.1 Level AA |
| **Bußgeld** | Bis 100.000 € |
| **Aufsicht** | Marktüberwachungsbehörden der Länder |

### Wer ist betroffen?

**Betroffen (B2C):**
- ✅ Online-Shops
- ✅ Buchungsplattformen
- ✅ E-Banking
- ✅ E-Commerce generell
- ✅ Apps für Endverbraucher

**Ausnahmen:**
- ❌ Reine B2B-Websites
- ❌ Kleinstunternehmen (< 10 MA, < 2 Mio € Umsatz)
- ❌ Interne Tools/Intranets

### WCAG 2.1 AA Anforderungen

#### Wahrnehmbar

| Kriterium | Anforderung |
|-----------|-------------|
| 1.1.1 Non-text Content | Alt-Texte für Bilder |
| 1.2.x Time-based Media | Untertitel, Audiodeskription |
| 1.3.x Adaptable | Semantische Struktur |
| 1.4.x Distinguishable | Kontrast 4.5:1, Resize 200% |

#### Bedienbar

| Kriterium | Anforderung |
|-----------|-------------|
| 2.1.x Keyboard | Vollständig per Tastatur bedienbar |
| 2.2.x Enough Time | Zeitlimits einstellbar |
| 2.3.x Seizures | Keine flackernden Inhalte |
| 2.4.x Navigable | Skip-Links, Fokus-Reihenfolge |
| 2.5.x Input Modalities | Touch, Motion |

#### Verständlich

| Kriterium | Anforderung |
|-----------|-------------|
| 3.1.x Readable | Sprache, Abkürzungen |
| 3.2.x Predictable | Konsistente Navigation |
| 3.3.x Input Assistance | Fehleridentifikation, Labels |

#### Robust

| Kriterium | Anforderung |
|-----------|-------------|
| 4.1.x Compatible | Valides HTML, ARIA |

### BFSG-Checkliste

```markdown
## BFSG-Konformitätsprüfung

### Navigation & Struktur
- [ ] Skip-to-Content Link vorhanden
- [ ] Logische Heading-Hierarchie (h1 → h2 → h3)
- [ ] Breadcrumbs vorhanden
- [ ] Konsistente Navigation
- [ ] Sitemap vorhanden

### Bilder & Medien
- [ ] Alt-Texte für alle informativen Bilder
- [ ] Dekorative Bilder mit alt=""
- [ ] Videos mit Untertiteln
- [ ] Audiodeskription für Videos (wenn nötig)
- [ ] Keine automatische Wiedergabe

### Formulare
- [ ] Labels für alle Eingabefelder
- [ ] Fehlermeldungen verständlich
- [ ] Pflichtfelder gekennzeichnet
- [ ] Fokus-States sichtbar
- [ ] Formular per Tastatur bedienbar

### Farben & Kontrast
- [ ] Textkontrast ≥ 4.5:1
- [ ] Großer Text ≥ 3:1
- [ ] UI-Elemente ≥ 3:1
- [ ] Keine Information nur durch Farbe

### Interaktion
- [ ] Alle Funktionen per Tastatur
- [ ] Fokus-Indikator sichtbar
- [ ] Keine Tastaturfallen
- [ ] Touch-Targets ≥ 44x44px

### Technisch
- [ ] Lang-Attribut gesetzt
- [ ] Valides HTML
- [ ] ARIA korrekt verwendet
- [ ] Responsives Design
- [ ] Zoom bis 200% möglich
```

### Erklärung zur Barrierefreiheit

**Pflichtinhalt nach BFSG:**

```markdown
# Erklärung zur Barrierefreiheit

[Unternehmen] ist bemüht, seine Website im Einklang mit den nationalen
Rechtsvorschriften zur Umsetzung der Richtlinie (EU) 2019/882 des
Europäischen Parlaments und des Rates barrierefrei zugänglich zu machen.

## Stand der Konformität

Diese Website ist mit dem BFSG [vollständig/teilweise/nicht] konform.

## Nicht barrierefreie Inhalte

[Auflistung bekannter Probleme]

## Feedback und Kontakt

Kontaktmöglichkeit für Barrieremeldungen:
- E-Mail: barrierefreiheit@example.de
- Telefon: +49 xxx xxxxxxx

## Durchsetzungsverfahren

Sollten Sie der Meinung sein, dass unsere Antwort auf Ihre Anfrage
nicht ausreichend war, können Sie sich an die zuständige
Marktüberwachungsbehörde wenden.

Zuletzt aktualisiert: [Datum]
```

## DSGVO - Datenschutz-Grundverordnung

### Pflichten für Websites

| Pflicht | Umsetzung |
|---------|-----------|
| Datenschutzerklärung | Umfassende Erklärung |
| Cookie-Consent | Opt-in vor Tracking |
| Rechte der Betroffenen | Auskunft, Löschung, etc. |
| Auftragsverarbeitung | AVV mit Dienstleistern |
| Technische Maßnahmen | SSL, Anonymisierung |

### Cookie-Consent Anforderungen

**Erlaubt ohne Consent:**
- Technisch notwendige Cookies
- Session-Cookies
- Load Balancing

**Consent erforderlich:**
- Analytics (Google Analytics, Matomo)
- Marketing/Advertising
- Social Media Plugins
- Personalisierung

### Cookie-Banner Checkliste

```markdown
## Cookie-Consent Prüfung

### Rechtliche Anforderungen
- [ ] Opt-in (nicht Opt-out)
- [ ] Keine vorausgewählten Checkboxen
- [ ] Ablehnen genauso einfach wie Akzeptieren
- [ ] Cookies erst nach Consent gesetzt
- [ ] Consent nachweisbar gespeichert

### Technische Umsetzung
- [ ] Kein Tracking vor Consent
- [ ] GTM/Analytics blockiert
- [ ] Third-Party Scripts blockiert
- [ ] Consent-Tool TCF 2.2 kompatibel

### Inhaltliche Anforderungen
- [ ] Zwecke der Cookies erklärt
- [ ] Kategorien aufgeführt
- [ ] Speicherdauer angegeben
- [ ] Widerrufsrecht erklärt
- [ ] Link zur Datenschutzerklärung
```

### Datenschutzerklärung Pflichtinhalte

1. **Verantwortlicher** - Name, Adresse, Kontakt
2. **Datenschutzbeauftragter** - Falls vorhanden
3. **Erhobene Daten** - Welche personenbezogenen Daten
4. **Zweck der Verarbeitung** - Warum werden Daten verarbeitet
5. **Rechtsgrundlage** - Art. 6 DSGVO Basis
6. **Empfänger** - Wer erhält die Daten
7. **Drittlandtransfer** - Falls außerhalb EU
8. **Speicherdauer** - Wie lange werden Daten gespeichert
9. **Betroffenenrechte** - Auskunft, Löschung, Widerspruch
10. **Cookies** - Details zu eingesetzten Cookies
11. **Analysetools** - Google Analytics, etc.
12. **Social Plugins** - Facebook, Twitter, etc.
13. **Formulare** - Kontaktformular, Newsletter
14. **SSL-Verschlüsselung** - Hinweis

## TMG/DDG - Impressumspflicht

### Pflichtangaben Impressum

```markdown
## Impressum

[Firmenname]
[Rechtsform, z.B. GmbH, AG]

[Straße und Hausnummer]
[PLZ Ort]

Vertreten durch:
[Geschäftsführer/Vorstand]

Kontakt:
Telefon: [+49 xxx xxxxxxx]
E-Mail: [kontakt@example.de]

Registereintrag:
Eintragung im Handelsregister
Registergericht: [Amtsgericht]
Registernummer: [HRB xxxxx]

Umsatzsteuer-ID:
USt-IdNr. gemäß § 27a UStG: [DE xxxxxxxxx]

[Falls zutreffend:]
Aufsichtsbehörde: [Name und Anschrift]
Berufsbezeichnung: [Beruf, verliehen in Deutschland]
Kammer: [zuständige Kammer]
Berufsrechtliche Regelungen: [Gesetze/Verordnungen]

Verantwortlich für Inhalte nach § 18 Abs. 2 MStV:
[Name]
[Adresse]
```

### Branchenspezifische Zusatzangaben

| Branche | Zusätzliche Pflichtangaben |
|---------|---------------------------|
| Ärzte/Heilberufe | Approbation, Kammer |
| Rechtsanwälte | RAK, BRAO |
| Architekten | Kammer, Berufsbezeichnung |
| Handwerker | HWK, Meisterbrief |
| Finanzdienstleister | BaFin-Registrierung |
| Makler | Erlaubnis §34c GewO |

## NetzDG - Netzwerkdurchsetzungsgesetz

### Betrifft

- Soziale Netzwerke
- Plattformen mit User-generated Content
- Foren und Kommentarfunktionen (ab Größe)

### Anforderungen

- Meldeverfahren für rechtswidrige Inhalte
- 24h-Löschfrist für offensichtlich rechtswidrige Inhalte
- 7-Tage-Frist für sonstige rechtswidrige Inhalte
- Halbjährliche Transparenzberichte

## Urheberrecht

### Bildlizenzen

| Lizenztyp | Nutzung | Nachweis |
|-----------|---------|----------|
| Eigene Bilder | ✅ Frei | Urheber = Firma |
| Stock (Kauf) | ✅ Gemäß Lizenz | Rechnung |
| Creative Commons | ✅ Mit Attribution | Lizenztext |
| Pressematerial | ⚠️ Nur für Presse | Genehmigung |
| Screenshots | ⚠️ Fair Use | Kontext prüfen |
| Ohne Lizenz | ❌ Verboten | - |

### Font-Lizenzen

| Font-Quelle | Web-Nutzung | DSGVO |
|-------------|-------------|-------|
| Google Fonts (selbst gehostet) | ✅ | ✅ |
| Google Fonts (CDN) | ✅ | ⚠️ |
| Adobe Fonts | ✅ | ⚠️ |
| Selbst gekaufte Fonts | ✅ | ✅ |
| System Fonts | ✅ | ✅ |

## Prüf-Workflow

### Compliance-Audit Ablauf

```
1. BFSG-Check (Lighthouse, axe, manuell)
   └─→ Score < 80 = 🔴 Kritisch

2. Cookie-Check (Browser Dev Tools)
   └─→ Tracking vor Consent = 🔴 Kritisch

3. Impressum-Check (manuell)
   └─→ Pflichtangaben fehlen = 🟡 Warnung

4. Datenschutz-Check (manuell)
   └─→ Unvollständig = 🟡 Warnung

5. SSL-Check (automatisch)
   └─→ Kein HTTPS = 🔴 Kritisch

6. Third-Party-Check (Wappalyzer)
   └─→ US-Dienste ohne AVV = 🟡 Warnung
```

### Risiko-Matrix

| Verstoß | Risiko | Bußgeld |
|---------|--------|---------|
| BFSG | Hoch | Bis 100.000 € |
| DSGVO | Sehr hoch | Bis 20 Mio € / 4% Umsatz |
| Impressum | Mittel | Abmahnung, Bußgeld |
| Cookie | Hoch | DSGVO-Bußgeld |
| Urheberrecht | Hoch | Abmahnung, Schadensersatz |

## Timeline 2025

```
Jan 2025 ─────────────────────────────────────────────── Dez 2025
│                         │                              │
│                    28.06.2025                          │
│                    BFSG IN KRAFT                       │
│                         │                              │
│   Vorbereitung          │      Umsetzung erforderlich  │
│   ────────────────→     │     ←────────────────────    │
│                         │                              │
│ - Audit durchführen     │     - Erste Prüfungen        │
│ - Roadmap erstellen     │     - Marktüberwachung aktiv │
│ - Relaunch planen       │     - Bußgelder möglich      │
```
