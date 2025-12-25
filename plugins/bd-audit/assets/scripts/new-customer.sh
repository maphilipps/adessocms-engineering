#!/bin/bash

# ============================================
# BD-Audit: New Customer Setup Script
# Creates a new VitePress report structure for a customer
# ============================================

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="git@github.com:maphilipps/bd-audit-reports.git"
REPORTS_DIR="${BD_AUDIT_REPORTS_DIR:-$HOME/Sites/bd-audit-reports}"

# Usage
usage() {
    echo -e "${BLUE}BD-Audit: New Customer Setup${NC}"
    echo ""
    echo "Usage: $0 <customer-slug> <bd-name> [options]"
    echo ""
    echo "Arguments:"
    echo "  customer-slug   Slug for the customer (e.g., acme-corp)"
    echo "  bd-name        Name of the Business Developer"
    echo ""
    echo "Options:"
    echo "  --url URL       Website URL to audit"
    echo "  --company NAME  Full company name"
    echo "  --help          Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 acme-corp 'Max Mustermann' --url https://acme.de --company 'ACME Corporation GmbH'"
    exit 1
}

# Parse arguments
if [ $# -lt 2 ]; then
    usage
fi

CUSTOMER_SLUG=$1
BD_NAME=$2
shift 2

WEBSITE_URL=""
COMPANY_NAME=""

while [[ $# -gt 0 ]]; do
    case $1 in
        --url)
            WEBSITE_URL="$2"
            shift 2
            ;;
        --company)
            COMPANY_NAME="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

# Set defaults
if [ -z "$COMPANY_NAME" ]; then
    COMPANY_NAME=$(echo "$CUSTOMER_SLUG" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2))}1')
fi

echo -e "${BLUE}╔════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║      BD-Audit: New Customer Setup      ║${NC}"
echo -e "${BLUE}╚════════════════════════════════════════╝${NC}"
echo ""
echo -e "Customer: ${GREEN}$CUSTOMER_SLUG${NC}"
echo -e "Company:  ${GREEN}$COMPANY_NAME${NC}"
echo -e "BD:       ${GREEN}$BD_NAME${NC}"
echo -e "URL:      ${GREEN}${WEBSITE_URL:-'(not set)'}${NC}"
echo ""

# Check if reports directory exists
if [ ! -d "$REPORTS_DIR" ]; then
    echo -e "${YELLOW}Cloning bd-audit-reports repository...${NC}"
    git clone "$REPO_URL" "$REPORTS_DIR"
fi

cd "$REPORTS_DIR"

# Check if customer already exists
CUSTOMER_DIR="$REPORTS_DIR/customers/$CUSTOMER_SLUG"
if [ -d "$CUSTOMER_DIR" ]; then
    echo -e "${RED}Error: Customer '$CUSTOMER_SLUG' already exists!${NC}"
    echo -e "Location: $CUSTOMER_DIR"
    exit 1
fi

# Create customer directory structure
echo -e "${YELLOW}Creating directory structure...${NC}"
mkdir -p "$CUSTOMER_DIR"/{.vitepress/theme,public,analyse,empfehlung,anhang}

# Copy shared theme
if [ -d "$REPORTS_DIR/shared/theme" ]; then
    cp -r "$REPORTS_DIR/shared/theme/"* "$CUSTOMER_DIR/.vitepress/theme/"
fi

# Copy shared assets
if [ -d "$REPORTS_DIR/shared/assets" ]; then
    cp -r "$REPORTS_DIR/shared/assets/"* "$CUSTOMER_DIR/public/"
fi

# Generate config.mts
DATE=$(date +%Y-%m-%d)
cat > "$CUSTOMER_DIR/.vitepress/config.mts" << EOF
import { defineConfig } from 'vitepress'

export default defineConfig({
  title: '${COMPANY_NAME} - Website Audit',
  description: 'Umfassende Website-Analyse durch adesso SE',
  lang: 'de-DE',

  head: [
    ['link', { rel: 'icon', href: '/favicon.ico' }],
    ['meta', { property: 'og:image', content: '/og-image.png' }],
    ['meta', { property: 'og:title', content: '${COMPANY_NAME} - Website Audit' }],
    ['meta', { property: 'og:description', content: 'Audit Report erstellt von adesso SE' }],
    ['link', {
      rel: 'stylesheet',
      href: 'https://fonts.googleapis.com/css2?family=Fira+Sans:wght@400;500;600;700&display=swap'
    }]
  ],

  themeConfig: {
    logo: '/adesso-logo.svg',
    siteTitle: 'Audit Report',

    nav: [
      { text: 'Übersicht', link: '/' },
      { text: 'Analyse', link: '/analyse/technologie' },
      { text: 'Empfehlung', link: '/empfehlung/cms' }
    ],

    sidebar: [
      {
        text: 'Zusammenfassung',
        items: [
          { text: 'Executive Summary', link: '/zusammenfassung' },
          { text: 'Dashboard', link: '/dashboard' }
        ]
      },
      {
        text: 'Analyse',
        items: [
          { text: 'Technologie', link: '/analyse/technologie' },
          { text: 'Performance', link: '/analyse/performance' },
          { text: 'Accessibility', link: '/analyse/accessibility' },
          { text: 'SEO', link: '/analyse/seo' },
          { text: 'Security', link: '/analyse/security' },
          { text: 'Content', link: '/analyse/content' },
          { text: 'UX', link: '/analyse/ux' }
        ]
      },
      {
        text: 'Empfehlung',
        items: [
          { text: 'CMS-Empfehlung', link: '/empfehlung/cms' },
          { text: 'Roadmap', link: '/empfehlung/roadmap' },
          { text: 'Kosten & TCO', link: '/empfehlung/kosten' },
          { text: 'Team', link: '/empfehlung/team' }
        ]
      },
      {
        text: 'Anhang',
        items: [
          { text: 'Technische Details', link: '/anhang/details' },
          { text: 'Kontakt', link: '/anhang/kontakt' }
        ]
      }
    ],

    footer: {
      message: 'Erstellt von adesso SE',
      copyright: '© 2025 adesso SE - Solutions for Digital Business'
    },

    search: {
      provider: 'local'
    }
  }
})
EOF

# Generate index.md
cat > "$CUSTOMER_DIR/index.md" << EOF
---
layout: home
title: ${COMPANY_NAME}
hero:
  name: Website Audit
  text: ${COMPANY_NAME}
  tagline: Umfassende Analyse und Handlungsempfehlungen
  image:
    src: /adesso-logo.svg
    alt: adesso
  actions:
    - theme: brand
      text: Executive Summary
      link: /zusammenfassung
    - theme: alt
      text: Analyse ansehen
      link: /analyse/technologie

features:
  - icon: 🔍
    title: Technologie-Analyse
    details: Detaillierte Untersuchung des Tech-Stacks und der Systemarchitektur
  - icon: ⚡
    title: Performance
    details: Lighthouse-Scores und Core Web Vitals Analyse
  - icon: ♿
    title: Accessibility
    details: BFSG-Compliance und WCAG 2.1 AA Prüfung
  - icon: 📊
    title: SEO
    details: On-Page und Technical SEO Bewertung
  - icon: 💡
    title: CMS-Empfehlung
    details: Zukunftssichere Plattform aus dem adesso Portfolio
  - icon: 📅
    title: Roadmap
    details: Projektplan mit Meilensteinen und Timeline
---

## Über dieses Audit

Dieser Report wurde von **${BD_NAME}** (adesso SE) erstellt und enthält eine umfassende Analyse der Website ${WEBSITE_URL:-'[URL]'}.

**Erstellt am:** ${DATE}

**Ansprechpartner:** ${BD_NAME}
EOF

# Generate zusammenfassung.md placeholder
cat > "$CUSTOMER_DIR/zusammenfassung.md" << EOF
---
title: Executive Summary
description: Zusammenfassung der wichtigsten Audit-Ergebnisse
---

# Executive Summary

::: tip In Bearbeitung
Dieser Report wird gerade erstellt. Die Inhalte werden durch die BD-Audit Agents automatisch generiert.
:::

## Auf einen Blick

| Aspekt | Status |
|--------|--------|
| **Website** | ${WEBSITE_URL:-'[URL]'} |
| **Erstellt** | ${DATE} |
| **Ersteller** | ${BD_NAME} |
| **Status** | 🔄 In Bearbeitung |

## Nächste Schritte

Die Audit-Agents werden folgende Analysen durchführen:

1. 🔍 **Tech Stack Detection** - Technologie-Erkennung
2. ⚡ **Performance Audit** - Lighthouse & Core Web Vitals
3. ♿ **Accessibility Audit** - BFSG/WCAG Prüfung
4. 📊 **SEO Audit** - On-Page & Technical SEO
5. 🔒 **Security Check** - Sicherheitsanalyse
6. 📝 **Content Inventory** - Inhaltsanalyse
7. 💡 **CMS Evaluation** - Systemempfehlung
8. 📅 **Roadmap** - Projektplanung
EOF

# Generate package.json
cat > "$CUSTOMER_DIR/package.json" << EOF
{
  "name": "@bd-audit/${CUSTOMER_SLUG}",
  "version": "1.0.0",
  "description": "Website Audit Report for ${COMPANY_NAME}",
  "private": true,
  "scripts": {
    "dev": "vitepress dev",
    "build": "vitepress build",
    "preview": "vitepress preview"
  },
  "devDependencies": {
    "vitepress": "^1.5.0",
    "vue": "^3.5.0"
  }
}
EOF

# Generate .gitignore
cat > "$CUSTOMER_DIR/.gitignore" << EOF
node_modules
.vitepress/cache
.vitepress/dist
.DS_Store
*.local
EOF

# Generate netlify.toml
cat > "$CUSTOMER_DIR/netlify.toml" << EOF
[build]
  publish = ".vitepress/dist"
  command = "npm run build"

[build.environment]
  NODE_VERSION = "20"

[[redirects]]
  from = "/*"
  to = "/index.html"
  status = 200

[[headers]]
  for = "/*"
  [headers.values]
    X-Frame-Options = "DENY"
    X-Content-Type-Options = "nosniff"
EOF

# Create placeholder files for sections
for section in analyse/technologie analyse/performance analyse/accessibility analyse/seo analyse/security analyse/content analyse/ux; do
    title=$(basename "$section" | sed 's/^./\U&/')
    mkdir -p "$CUSTOMER_DIR/$(dirname $section)"
    cat > "$CUSTOMER_DIR/${section}.md" << EOF
---
title: ${title}
---

# ${title}

::: tip In Bearbeitung
Diese Sektion wird durch die BD-Audit Agents automatisch ausgefüllt.
:::
EOF
done

for section in empfehlung/cms empfehlung/roadmap empfehlung/kosten empfehlung/team; do
    title=$(basename "$section" | sed 's/^./\U&/')
    mkdir -p "$CUSTOMER_DIR/$(dirname $section)"
    cat > "$CUSTOMER_DIR/${section}.md" << EOF
---
title: ${title}
---

# ${title}

::: tip In Bearbeitung
Diese Sektion wird durch die BD-Audit Agents automatisch ausgefüllt.
:::
EOF
done

# Create dashboard.md
cat > "$CUSTOMER_DIR/dashboard.md" << EOF
---
title: Dashboard
---

# Score Dashboard

::: tip In Bearbeitung
Das Dashboard wird nach Abschluss aller Audits generiert.
:::

<div class="score-dashboard">
  <div class="metric">
    <div class="metric-value">--</div>
    <div class="metric-label">Gesamt-Score</div>
  </div>
  <div class="metric">
    <div class="metric-value">--</div>
    <div class="metric-label">Performance</div>
  </div>
  <div class="metric">
    <div class="metric-value">--</div>
    <div class="metric-label">Accessibility</div>
  </div>
  <div class="metric">
    <div class="metric-value">--</div>
    <div class="metric-label">SEO</div>
  </div>
</div>
EOF

echo ""
echo -e "${GREEN}✅ Customer '$CUSTOMER_SLUG' created successfully!${NC}"
echo ""
echo -e "Location: ${BLUE}$CUSTOMER_DIR${NC}"
echo -e "Report URL: ${BLUE}https://audits.adessocms.de/$CUSTOMER_SLUG${NC}"
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo "1. cd $CUSTOMER_DIR"
echo "2. npm install"
echo "3. npm run dev"
echo ""
echo -e "Or run the BD-Audit with: ${BLUE}/bd ${WEBSITE_URL:-'<url>'}${NC}"
