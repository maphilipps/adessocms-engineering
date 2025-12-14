# Section Templates

Detailed content templates for landing page sections.

## Table of Contents
1. [Hero Section](#hero-section)
2. [Problem/Solution](#problemsolution)
3. [Benefits Grid](#benefits-grid)
4. [Features Section](#features-section)
5. [Social Proof](#social-proof)
6. [Team/Contact Section](#teamcontact-section)
7. [Lead Form](#lead-form)
8. [Trust Footer](#trust-footer)

---

## Hero Section

**Purpose**: Capture attention, communicate value proposition, drive first action.

### Template Structure

```
┌────────────────────────────────────────────────────────┐
│  [Logo + Navigation]                                   │
├────────────────────────────────────────────────────────┤
│                                                        │
│  H1: [Primary Value Proposition]                       │
│                                                        │
│  Subline: [Supporting statement - who you help,        │
│           what you do, why it matters]                 │
│                                                        │
│  [Primary CTA Button]  [Secondary CTA Link]            │
│                                                        │
│                    [Hero Image/Video]                  │
└────────────────────────────────────────────────────────┘
```

### Content Guidelines

**H1 Headline (max 10 words)**:
- Lead with benefit, not feature
- Be specific to the service/product
- Use power words: "Dein", "Jetzt", "Einfach", "Sicher"

**Good**: "Dein verlässlicher Partner für Schweinevermarktung"
**Bad**: "Willkommen bei Firma XY"

**Subline (max 30 words)**:
- Expand on the headline
- Include: Who you serve + What you deliver + Key differentiator
- Can use bullet points for scanning

**CTA Button**:
- Action verb + Benefit
- Examples: "Jetzt Angebot anfordern", "Kostenlos beraten lassen", "Termin vereinbaren"

---

## Problem/Solution

**Purpose**: Build empathy, show understanding of customer challenges.

### Template Structure

```
┌────────────────────────────────────────────────────────┐
│  H2: [Acknowledge the Challenge]                       │
│                                                        │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐ │
│  │ Pain Point 1 │  │ Pain Point 2 │  │ Pain Point 3 │ │
│  │ + Solution   │  │ + Solution   │  │ + Solution   │ │
│  └──────────────┘  └──────────────┘  └──────────────┘ │
│                                                        │
│  [Transition text to benefits]                         │
└────────────────────────────────────────────────────────┘
```

### Content Pattern

**Pain → Solution pairs**:

| Pain Point | Solution Framing |
|------------|------------------|
| "Unübersichtliche Prozesse" | "Transparente Digitalisierung" |
| "Unsichere Marktlage" | "Europaweites Netzwerk für Flexibilität" |
| "Schwer erreichbare Ansprechpartner" | "24/7 Erreichbarkeit" |

---

## Benefits Grid

**Purpose**: Highlight 3-6 key advantages with visual anchors.

### Template Structure

```
┌────────────────────────────────────────────────────────┐
│  H2: [Benefits Overview Headline]                      │
│  Subline: [Brief context]                              │
│                                                        │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐                │
│  │  Icon   │  │  Icon   │  │  Icon   │                │
│  │  Title  │  │  Title  │  │  Title  │                │
│  │  Desc   │  │  Desc   │  │  Desc   │                │
│  └─────────┘  └─────────┘  └─────────┘                │
│                                                        │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐                │
│  │  Icon   │  │  Icon   │  │  Icon   │                │
│  │  Title  │  │  Title  │  │  Title  │                │
│  │  Desc   │  │  Desc   │  │  Desc   │                │
│  └─────────┘  └─────────┘  └─────────┘                │
└────────────────────────────────────────────────────────┘
```

### Benefit Card Template

```markdown
**Icon**: [Relevant icon from library]
**Title**: [2-4 words, benefit-focused]
**Description**: [1-2 sentences explaining the benefit]
```

**Example**:
- Icon: Clock
- Title: "24/7 Erreichbarkeit"
- Desc: "Unsere Experten sind rund um die Uhr für Dich da – auch an Wochenenden und Feiertagen."

### Best Practices
- Use 3, 4, or 6 items (grid-friendly)
- Each title should be scannable standalone
- Icons should be consistent in style
- Order by importance (most important first)

---

## Features Section

**Purpose**: Detailed look at what's included/offered.

### Layout Options

**Option A: List with Icons**
```
┌────────────────────────────────────────────────────────┐
│  H2: Unsere Leistungen im Überblick                    │
│                                                        │
│  ✓ Feature 1 - Brief explanation                       │
│  ✓ Feature 2 - Brief explanation                       │
│  ✓ Feature 3 - Brief explanation                       │
│  ✓ Feature 4 - Brief explanation                       │
└────────────────────────────────────────────────────────┘
```

**Option B: Image + Text Alternating**
```
┌────────────────────────────────────────────────────────┐
│  [Image]          │  H3: Feature Title                 │
│                   │  Description paragraph             │
│                   │  • Detail 1                        │
│                   │  • Detail 2                        │
├───────────────────┼────────────────────────────────────┤
│  H3: Feature 2    │           [Image]                  │
│  Description      │                                    │
└────────────────────────────────────────────────────────┘
```

**Option C: Comparison Table** (for competitive positioning)
```
| Feature           | Uns | Wettbewerb |
|-------------------|-----|------------|
| 24/7 Support      | ✓   | ✗          |
| Digitale Prozesse | ✓   | Teilweise  |
| Europaweites Netz | ✓   | Regional   |
```

---

## Social Proof

**Purpose**: Build trust through third-party validation.

### Elements (use 2+ of these)

**Testimonials**:
```
┌────────────────────────────────────────────────────────┐
│  "Quote from satisfied customer about specific         │
│   benefit they experienced."                           │
│                                                        │
│  [Photo]  Name, Role/Company                          │
└────────────────────────────────────────────────────────┘
```

**Numbers/Stats**:
```
┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐
│   50+    │  │  1969    │  │   24/7   │  │  100%    │
│  Jahre   │  │ Gegründet│  │ Service  │  │ Regional │
└──────────┘  └──────────┘  └──────────┘  └──────────┘
```

**Certifications**:
```
┌────────────────────────────────────────────────────────┐
│  H2: Unsere Zertifizierungen                          │
│                                                        │
│  [Cert Logo 1]  [Cert Logo 2]  [Cert Logo 3]          │
│   Title          Title          Title                  │
│   Brief desc     Brief desc     Brief desc             │
└────────────────────────────────────────────────────────┘
```

**Partner Logos**:
```
┌────────────────────────────────────────────────────────┐
│  Unsere Partner:                                       │
│  [Logo] [Logo] [Logo] [Logo] [Logo]                   │
└────────────────────────────────────────────────────────┘
```

---

## Team/Contact Section

**Purpose**: Humanize the business, provide direct contact path.

### Template Structure

```
┌────────────────────────────────────────────────────────┐
│  H2: Dein Ansprechpartner in Deiner Region            │
│  Subline: Finde den richtigen Kontakt                 │
│                                                        │
│  ┌─────────────────────────────────────────────────┐  │
│  │              [Interactive Map]                   │  │
│  │         (colored by sales regions)              │  │
│  └─────────────────────────────────────────────────┘  │
│                                                        │
│  ┌─────────┐  ┌─────────┐  ┌─────────┐  ┌─────────┐  │
│  │ [Photo] │  │ [Photo] │  │ [Photo] │  │ [Photo] │  │
│  │  Name   │  │  Name   │  │  Name   │  │  Name   │  │
│  │  Role   │  │  Role   │  │  Role   │  │  Role   │  │
│  │  Phone  │  │  Phone  │  │  Phone  │  │  Phone  │  │
│  │  Email  │  │  Email  │  │  Email  │  │  Email  │  │
│  └─────────┘  └─────────┘  └─────────┘  └─────────┘  │
└────────────────────────────────────────────────────────┘
```

### Quick Contact Bar (alternative)

```
┌────────────────────────────────────────────────────────┐
│  H2: Finde den richtigen Ansprechpartner              │
│                                                        │
│  [Icon] Disposition    +49 (0)25 96 5298 228          │
│  [Icon] Einkauf        +49 (0)25 96 5298 225          │
│  [Icon] Buchhaltung    +49 (0)25 96 5298 132          │
└────────────────────────────────────────────────────────┘
```

---

## Lead Form

**Purpose**: Capture lead information with minimal friction.

### Template Structure

```
┌────────────────────────────────────────────────────────┐
│  H2: [Benefit-focused headline]                        │
│  Subline: [What happens after submission]              │
│                                                        │
│  ┌──────────────────────────────────────────────────┐ │
│  │  Anrede:     [Dropdown: Frau/Herr/Divers]        │ │
│  │  Vorname:    [________________]                   │ │
│  │  Nachname:   [________________] *                 │ │
│  │  E-Mail:     [________________] *                 │ │
│  │  Telefon:    [________________]                   │ │
│  │  PLZ:        [______]                             │ │
│  │                                                   │ │
│  │  [ ] Rückruf gewünscht                           │ │
│  │  [ ] Datenschutz akzeptiert *                    │ │
│  │                                                   │ │
│  │  [    Jetzt anfragen    ]                        │ │
│  └──────────────────────────────────────────────────┘ │
└────────────────────────────────────────────────────────┘
```

### Field Guidelines

**Required fields** (mark with *):
- Name (or just Last Name)
- Email OR Phone
- Privacy consent

**Optional but useful**:
- PLZ (for regional routing)
- Callback preference
- Message/Notes

**Best Practices**:
- Max 5-7 fields
- Single column on mobile
- Inline validation
- Clear error messages
- Success message with next steps

---

## Trust Footer

**Purpose**: Reinforce credibility at page end.

### Template Structure

```
┌────────────────────────────────────────────────────────┐
│  H2: Vertrauen & Qualität                             │
│                                                        │
│  [Cert 1]     [Cert 2]     [Cert 3]                   │
│   EMAS         QS           ISO                        │
│   Desc         Desc         Desc                       │
│                                                        │
│  ─────────────────────────────────────────────────────│
│                                                        │
│  [Standard Footer with links, contact, social]        │
└────────────────────────────────────────────────────────┘
```

### Certification Display

Each certification should show:
- Logo (recognizable size)
- Name/Acronym
- Brief description of what it certifies
- Optional: Link to certificate PDF
