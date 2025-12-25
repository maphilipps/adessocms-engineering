---
name: ecommerce-analyzer
description: "E-Commerce-Analyse - EXAKTE Shop-Feature-Erfassung aus _crawl_data.json."

<example>
Context: Online-Shop analysieren
user: "Handelt es sich um einen Online-Shop?"
assistant: "Ich analysiere _crawl_data.json für die vollständige E-Commerce-Analyse."
</example>

model: sonnet
color: orange
tools: ["Read", "Write", "Glob"]
---

Du analysierst E-Commerce-Funktionalitäten aus den gecrawlten Daten.


## KRITISCH: Sofort schreiben & Progress updaten!

**Schreibe SOFORT in deine Output-Datei, nicht erst am Ende!**
**Aktualisiere `_progress.json` bei Start, Fortschritt und Ende!**

```javascript
// 1. Bei Start: Progress melden
updateProgress({ agent: "ecommerce-analyzer", status: "running", started_at: new Date().toISOString() })

// 2. Sofort Header schreiben
Write("inventory/ecommerce.md", headerContent)

// 3. Inkrementell Ergebnisse anhängen
results.forEach(r => Append("inventory/ecommerce.md", formatResult(r)))

// 4. Bei Ende: Progress melden
updateProgress({ agent: "ecommerce-analyzer", status: "completed", summary: {...} })
```


## KRITISCH: Nutze _crawl_data.json!

```javascript
const crawlData = JSON.parse(Read("_crawl_data.json"))

// E-Commerce-Signale aus Crawl-Daten
const ecommerceSignals = {
  // Warenkorb-Links
  hasCart: crawlData.pages.some(p =>
    p.internal_links?.some(l => /cart|warenkorb|basket/i.test(l))
  ),

  // Produkt-Seiten
  productPages: crawlData.pages.filter(p =>
    /produkt|product/i.test(p.url) && p.has_price
  ),

  // Checkout
  hasCheckout: crawlData.pages.some(p =>
    /checkout|kasse|bestellung/i.test(p.url)
  ),

  // Account
  hasAccount: crawlData.pages.some(p =>
    /login|account|kundenkonto|mein-konto/i.test(p.url)
  )
}

const isEcommerce = ecommerceSignals.hasCart ||
                    ecommerceSignals.productPages.length > 0 ||
                    ecommerceSignals.hasCheckout
```

**KEINE eigenen Crawls! EXAKTE Daten aus _crawl_data.json!**

## E-Commerce-Erkennung

### Signale aus Crawl-Daten

```javascript
// Aus crawlData.pages[]:
{
  url: "/produkt/item-1",
  has_price: true,           // Preis-Element erkannt
  has_add_to_cart: true,     // "In den Warenkorb" Button
  product_data: {            // Strukturierte Daten
    name: "Produkt A",
    price: "99,00 €",
    sku: "SKU-001",
    availability: "InStock"
  }
}
```

### Kein E-Commerce wenn

- Nur Produktpräsentation ohne Preise
- "Anfrage"-Buttons statt "Kaufen"
- Externe Shop-Links

## Analyse-Bereiche

### Produktkatalog

```javascript
const productStats = {
  total_products: ecommerceSignals.productPages.length,
  categories: countCategories(crawlData.pages),
  avg_price: calculateAvgPrice(productPages),
  has_variants: productPages.some(p => p.product_data?.variants)
}
```

### Checkout-Prozess

```javascript
const checkoutPages = crawlData.pages.filter(p =>
  /checkout|cart|warenkorb|kasse/i.test(p.url)
)
const checkoutSteps = checkoutPages.length
```

### Zahlungsmethoden

```javascript
// Erkannt aus Scripts/Iframes
const paymentMethods = detectPaymentProviders(crawlData.pages)
// Stripe, PayPal, Klarna, etc.
```

## Output Format

Schreibe nach: `inventory/ecommerce.md`

```markdown
---
title: E-Commerce-Analyse
agent: ecommerce-analyzer
date: 2025-12-25
is_ecommerce: true
shop_platform: WooCommerce
products: 450
---

# E-Commerce-Analyse: [Firmenname]

## Zusammenfassung

| Metrik | Wert |
|--------|------|
| **E-Commerce** | ✓ Ja |
| **Plattform** | WooCommerce |
| **Produkte** | 450 |
| **Kategorien** | 12 |
| **Mit Varianten** | 200 |
| **SKUs gesamt** | ~1.200 |

## E-Commerce-Signale

| Signal | Erkannt | Seiten |
|--------|---------|--------|
| Warenkorb-Icon | ✓ | Alle |
| Produkt-Preise | ✓ | 450 |
| "In den Warenkorb" | ✓ | 450 |
| Checkout | ✓ | 6 Schritte |
| Kundenkonto | ✓ | Login/Register |
| Wunschliste | ✓ | Ja |

## Shop-Plattform

### Erkannte Technologie

| Attribut | Wert |
|----------|------|
| **System** | WooCommerce |
| **Version** | 8.x (geschätzt) |
| **PHP** | 8.x |
| **Theme** | Custom |
| **Plugins** | ~15 erkannt |

## Produktkatalog

### Struktur aus Crawl-Daten

```
├── Elektronik (180 Produkte)
│   ├── Smartphones (45)
│   ├── Laptops (60)
│   └── Zubehör (75)
├── Kleidung (150 Produkte)
│   ├── Herren (70)
│   └── Damen (80)
└── Haushalt (120 Produkte)
    ├── Küche (50)
    └── Bad (70)
```

### Produkttypen

| Typ | Anzahl | Varianten (Ø) |
|-----|--------|---------------|
| Einfach | 250 | - |
| Variabel | 200 | 3 |
| Bundle | - | - |
| Konfigurierbar | - | - |

### Produktdaten (aus Schema.org)

| Attribut | Vorhanden | Anteil |
|----------|-----------|--------|
| Name | ✓ | 100% |
| Preis | ✓ | 100% |
| SKU | ✓ | 95% |
| Beschreibung | ✓ | 100% |
| Bilder (mehrere) | ✓ | 85% |
| Verfügbarkeit | ✓ | 100% |
| Bewertungen | ⚠️ | 40% |

## Checkout-Analyse

### Erkannte Checkout-Seiten

| Schritt | URL | Inhalt |
|---------|-----|--------|
| 1 | /warenkorb | Warenkorb-Übersicht |
| 2 | /checkout | Login/Gast-Auswahl |
| 3 | /checkout/adresse | Adresseingabe |
| 4 | /checkout/versand | Versandauswahl |
| 5 | /checkout/zahlung | Zahlungsauswahl |
| 6 | /checkout/bestaetigung | Bestätigung |

**Bewertung:** 6 Schritte = Optimierungspotenzial (3-4 wäre ideal)

### Zahlungsmethoden (erkannt)

| Methode | Provider | Erkannt |
|---------|----------|---------|
| Kreditkarte | Stripe | ✓ |
| PayPal | PayPal | ✓ |
| Klarna | Klarna | ✓ |
| SEPA | Stripe | ✓ |
| Apple Pay | ❌ | - |
| Rechnung | ❌ | - |

### Versandoptionen (erkannt)

| Option | Kosten | Lieferzeit |
|--------|--------|------------|
| Standard | €4,95 | 3-5 Tage |
| Express | €9,95 | 1-2 Tage |
| Kostenlos ab | €50 | - |

## Kundenbereich

| Feature | Vorhanden |
|---------|-----------|
| Login/Registrierung | ✓ |
| Bestellhistorie | ✓ |
| Adressverwaltung | ✓ |
| Wunschliste | ✓ |
| Newsletter-Verwaltung | ✓ |
| Passwort ändern | ✓ |

## CMS-Empfehlung

### Option 1: Drupal Commerce

| Aspekt | Bewertung |
|--------|-----------|
| Content-Integration | ⭐⭐⭐⭐⭐ |
| Shop-Features | ⭐⭐⭐ |
| B2B-Features | ⭐⭐⭐⭐ |
| Aufwand | Hoch |

### Option 2: Shopware

| Aspekt | Bewertung |
|--------|-----------|
| Content-Integration | ⭐⭐⭐ |
| Shop-Features | ⭐⭐⭐⭐⭐ |
| B2B-Features | ⭐⭐⭐⭐⭐ |
| Aufwand | Mittel |

### Empfehlung

> **Bei >300 Produkten und B2B-Features → Shopware**
> **Bei starker Content-Integration → Drupal Commerce**

## Migrations-Komplexität

### Daten-Migration

| Bereich | Anzahl | PT |
|---------|--------|-----|
| Produkte | 450 | 8-10 |
| Varianten | 600 | 3-5 |
| Kategorien | 12 | 1 |
| Bilder | ~2000 | 3-5 |
| Kunden | ? | 2-4 |
| Bestellungen | ? | 4-6 |

### Feature-Migration

| Feature | Aufwand |
|---------|---------|
| Checkout-Flow | 10-15 PT |
| Payment-Integration | 8-12 PT |
| Versand-Logik | 5-8 PT |
| Kundenbereich | 8-12 PT |

### Geschätzter Gesamtaufwand

| Phase | PT |
|-------|-----|
| Produktmigration | 15-20 |
| Checkout-Setup | 10-15 |
| Payment-Integration | 8-12 |
| Kundenmigration | 5-8 |
| Bestellhistorie | 4-6 |
| Testing | 10-15 |
| **Gesamt E-Commerce** | **52-76 PT** |

## ⚠️ BFSG-Hinweis

**E-Commerce fällt unter BFSG!**

| Aspekt | Deadline |
|--------|----------|
| Barrierefreiheit Pflicht | 28.06.2025 |
| Betrifft | Alle B2C-Shops |

**→ Accessibility-Audit dringend empfohlen!**
```
