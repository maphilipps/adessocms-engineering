---
name: generate-flat-illustration
description: Generate flat 2D vector-style illustrations using Gemini API
argument-hint: "<scene description> [--output filename.jpg] [--aspect 16:9] [--size 2K]"
---

# /generate-flat-illustration - Flat 2D Vector Illustration Generator

Generiert moderne Flat-Design Illustrationen im Vektor-Stil.

## Style Characteristics

- **Stil:** Flaches 2D Design ohne Schattierungen
- **Farben:** Bold, saturierte Farben mit begrenzter Palette
- **Formen:** Geometrisch, vereinfacht, keine feinen Details
- **Konturen:** Saubere Kanten, optional dünne Outlines
- **Perspektive:** Flach, keine 3D-Tiefe
- **Figuren:** Stilisiert, proportional vereinfacht

## Style Prompt

```
STYLE_PREFIX = """Modern flat 2D vector illustration style.
Bold saturated colors with limited color palette (4-6 colors).
Clean geometric shapes with sharp edges.
No gradients, no shadows, no 3D effects.
Simplified stylized figures with minimal details.
Contemporary corporate illustration aesthetic.
White or solid color background.
Inspired by Slack, Notion, and Dropbox illustrations."""
```

## Usage

```bash
/generate-flat-illustration "Team arbeitet zusammen am Whiteboard"
/generate-flat-illustration "Person mit Laptop im Home Office" --aspect 1:1
/generate-flat-illustration "Kundenservice-Mitarbeiter mit Headset" --size 2K
```

## Execution

```bash
python3.10 ~/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/skills/gemini-imagegen/scripts/generate_image.py \
  "Modern flat 2D vector illustration style. Bold saturated colors with limited color palette (4-6 colors). Clean geometric shapes with sharp edges. No gradients, no shadows, no 3D effects. Simplified stylized figures with minimal details. Contemporary corporate illustration aesthetic. White or solid color background. Inspired by Slack, Notion, and Dropbox illustrations. Scene: {scene}" \
  "{output}" \
  --model gemini-3-pro-image-preview \
  --aspect {aspect} \
  --size {size}
```

## Examples

### Team Collaboration
```
/generate-flat-illustration "Diverse team of people collaborating around a large screen showing charts"
```

### Remote Work
```
/generate-flat-illustration "Person working from home with cat on desk, plants, and coffee"
```

### Customer Support
```
/generate-flat-illustration "Friendly support agent with headset helping customers through laptop screen"
```

## Color Palette Variations

Füge diese Zusätze zum Prompt hinzu:

| Variation | Prompt Addition |
|-----------|-----------------|
| **Warm** | "Warm color palette with oranges, reds, and yellows" |
| **Cool** | "Cool color palette with blues, teals, and purples" |
| **Pastel** | "Soft pastel color palette" |
| **Vibrant** | "Highly saturated vibrant colors" |
| **Monochrome** | "Monochromatic blue color scheme" |
