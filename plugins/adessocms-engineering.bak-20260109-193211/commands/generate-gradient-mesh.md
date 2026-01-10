---
name: generate-gradient-mesh
description: Generate modern gradient mesh style images using Gemini API
argument-hint: "<scene description> [--output filename.jpg] [--aspect 16:9] [--size 2K]"
---

# /generate-gradient-mesh - Gradient Mesh Art Generator

Generiert moderne Bilder mit fließenden Farbverläufen im Gradient-Mesh Stil.

## Style Characteristics

- **Stil:** Weiche, fließende Farbverläufe
- **Farben:** Lebendige, moderne Farbkombinationen
- **Übergänge:** Nahtlose Mesh-Übergänge
- **Form:** Abstrakt oder als Hintergrund für Objekte
- **Tiefe:** 3D-Effekt durch Farbverläufe
- **Ästhetik:** Modern, digital, futuristisch

## Style Prompt

```
STYLE_PREFIX = """Modern gradient mesh art style.
Smooth flowing color gradients with seamless transitions.
Vibrant contemporary color palette with purples, pinks, blues, and teals.
Soft organic blob shapes with gradient fills.
Dreamy ethereal atmosphere with depth.
Glass morphism and aurora borealis influences.
Suitable for modern hero sections and backgrounds.
High-end tech company aesthetic like Apple or Stripe.
Subtle grain texture overlay for premium feel."""
```

## Usage

```bash
/generate-gradient-mesh "Abstrakte Formen für Hero-Section"
/generate-gradient-mesh "Smartphone schwebt in Farbwolke" --aspect 16:9
/generate-gradient-mesh "Futuristische Datenvisualisierung" --size 4K
```

## Execution

```bash
python3.10 ~/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/skills/gemini-imagegen/scripts/generate_image.py \
  "Modern gradient mesh art style. Smooth flowing color gradients with seamless transitions. Vibrant contemporary color palette with purples, pinks, blues, and teals. Soft organic blob shapes with gradient fills. Dreamy ethereal atmosphere with depth. Glass morphism and aurora borealis influences. Suitable for modern hero sections and backgrounds. High-end tech company aesthetic like Apple or Stripe. Subtle grain texture overlay for premium feel. Scene: {scene}" \
  "{output}" \
  --model gemini-3-pro-image-preview \
  --aspect {aspect} \
  --size {size}
```

## Examples

### Abstract Background
```
/generate-gradient-mesh "Abstract flowing shapes in purple, pink and blue gradients for website hero section" --aspect 16:9
```

### Product Feature
```
/generate-gradient-mesh "Floating smartphone surrounded by colorful gradient clouds and light rays"
```

### Data Visualization
```
/generate-gradient-mesh "Abstract 3D data streams and particles flowing through gradient space" --aspect 21:9
```

## Color Palette Variations

| Variation | Prompt Addition |
|-----------|-----------------|
| **Aurora** | "Northern lights aurora colors: greens, teals, and purples" |
| **Sunset** | "Warm sunset gradient: oranges, pinks, and deep purples" |
| **Ocean** | "Deep ocean gradients: teals, blues, and aquamarines" |
| **Neon** | "Vibrant neon gradients: hot pink, electric blue, lime green" |
| **Pastel** | "Soft pastel gradients: lavender, mint, peach" |
| **Dark** | "Dark mode gradients: deep purples and blues on near-black" |
