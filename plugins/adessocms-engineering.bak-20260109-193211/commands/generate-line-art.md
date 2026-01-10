---
name: generate-line-art
description: Generate minimalist line art illustrations using Gemini API
argument-hint: "<scene description> [--output filename.jpg] [--aspect 16:9] [--size 2K]"
---

# /generate-line-art - Minimalist Line Art Generator

Generiert minimalistische Strichzeichnungen und Line Art.

## Style Characteristics

- **Stil:** Reine Linienzeichnung
- **Strichstärke:** Konsistent oder bewusst variiert
- **Farbe:** Schwarz auf Weiß (oder invertiert)
- **Details:** Reduziert auf das Wesentliche
- **Flächen:** Keine Füllungen, nur Konturen
- **Ästhetik:** Modern, clean, technisch

## Style Prompt

```
STYLE_PREFIX = """Minimalist line art illustration.
Clean continuous lines with consistent stroke weight.
Black lines on pure white background.
No fills, shading, or gradients - only outlines.
Simplified forms reduced to essential contours.
Modern technical drawing aesthetic.
Single line weight or deliberate variation for emphasis.
Inspired by architectural sketches and technical illustrations.
High contrast, crisp and precise lines."""
```

## Usage

```bash
/generate-line-art "Architekturskizze eines modernen Hauses"
/generate-line-art "Technische Zeichnung einer Kaffeemaschine" --aspect 1:1
/generate-line-art "Portrait im One-Line-Art Stil" --size 2K
```

## Execution

```bash
python3.10 ~/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/skills/gemini-imagegen/scripts/generate_image.py \
  "Minimalist line art illustration. Clean continuous lines with consistent stroke weight. Black lines on pure white background. No fills, shading, or gradients - only outlines. Simplified forms reduced to essential contours. Modern technical drawing aesthetic. Single line weight or deliberate variation for emphasis. Inspired by architectural sketches and technical illustrations. High contrast, crisp and precise lines. Scene: {scene}" \
  "{output}" \
  --model gemini-3-pro-image-preview \
  --aspect {aspect} \
  --size {size}
```

## Examples

### Architecture
```
/generate-line-art "Modern minimalist house with large windows and flat roof, architectural elevation view"
```

### Technical
```
/generate-line-art "Exploded view of vintage camera showing internal components" --aspect 1:1
```

### One-Line Portrait
```
/generate-line-art "Continuous single line drawing of woman's face in profile" --aspect 3:4
```

## Style Variations

| Variation | Prompt Addition |
|-----------|-----------------|
| **One-Line** | "Continuous single line drawing without lifting pen" |
| **Technical** | "Precise technical illustration with annotations" |
| **Sketch** | "Loose architectural sketch style with construction lines" |
| **Bold** | "Bold thick lines with strong presence" |
| **Fine** | "Delicate fine lines with intricate details" |
| **Inverted** | "White lines on black background" |
