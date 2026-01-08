# Quick Tech Check Workflow

Fast CMS detection and tech stack analysis.

**REMINDER: All output must be in German (Deutsch).**

## Step 1: Setup Browser

```
mcp__claude-in-chrome__tabs_context_mcp (createIfEmpty: true)
mcp__claude-in-chrome__tabs_create_mcp
mcp__claude-in-chrome__navigate (url: <website_url>)
```

## Step 2: Take Screenshot

```
mcp__claude-in-chrome__computer (action: "screenshot")
```

## Step 3: CMS Detection

### 3.1 Check Page Source
```
mcp__claude-in-chrome__read_page
```

Look for CMS indicators:

| CMS | Indicators |
|-----|------------|
| WordPress | `wp-content`, `wp-includes`, generator meta |
| Drupal | `sites/default/files`, `Drupal.settings` |
| Typo3 | `typo3temp`, `typo3conf` |
| Magnolia | `.html` URLs, JSESSIONID cookie |
| Sitecore | `/sitecore/`, SC_ANALYTICS_COOKIE |
| AEM | `/content/dam/`, `/etc/designs/` |

### 3.2 External Detection Services
```
WebSearch: "<domain> builtwith"
WebSearch: "<domain> wappalyzer technology stack"
```

## Step 4: Framework Detection

### 4.1 Frontend Frameworks
- React: `react`, `__REACT_DEVTOOLS__`
- Vue: `vue`, `__VUE__`
- Angular: `ng-`, `angular`
- jQuery: `jquery`

### 4.2 CSS Frameworks
- Bootstrap: `bootstrap`, `col-`, `row`
- Tailwind: `tailwind`, utility classes

## Step 5: Output Report (GERMAN)

```markdown
# Schneller Tech-Check: [Domain]

## CMS
- **Erkannt:** [CMS Name] [Version falls bekannt]
- **Konfidenz:** Hoch/Mittel/Niedrig
- **Indikatoren:** [Liste]

## Frontend-Stack
- **Framework:** [React/Vue/Keins/etc.]
- **CSS:** [Bootstrap/Tailwind/Custom]
- **JavaScript-Bibliotheken:** [Liste]

## Infrastruktur
- **Hosting:** [Provider falls erkannt]
- **CDN:** [Ja/Nein - Provider]
- **SSL:** [Ja/Nein]

## Empfehlungen
- [Migrations-Überlegungen]
- [Potenzielle Herausforderungen]
```

## Duration
Estimated: 15-30 minutes
