---
name: generate-watercolor
description: Generate watercolor style artistic images using Gemini API
argument-hint: "<scene description> [--output filename.jpg] [--aspect 16:9] [--size 2K]"
---

# /generate-watercolor - Watercolor Art Generator

Generiert künstlerische Bilder im Aquarell-Stil.

## Style Characteristics

- **Technik:** Authentischer Aquarell-Look
- **Kanten:** Weiche, fließende Übergänge
- **Farben:** Transparente, sich vermischende Töne
- **Textur:** Sichtbare Papierstruktur
- **Details:** Bewusst unperfekt, organisch
- **Weiß:** Papier scheint durch als Highlight

## Style Prompt

```
STYLE_PREFIX = """Beautiful watercolor painting style.
Soft flowing edges with color bleeding and blending.
Transparent layered washes of color.
Visible paper texture showing through paint.
Organic imperfections and happy accidents.
White paper showing through as highlights.
Delicate brushwork with wet-on-wet techniques.
Artistic and emotional aesthetic.
Traditional watercolor on cold-pressed paper."""
```

## Usage

```bash
/generate-watercolor "Blumenstrauß in einer Vase"
/generate-watercolor "Stadtlandschaft bei Regen" --aspect 3:2
/generate-watercolor "Portrait einer nachdenklichen Person" --size 2K
```

## Execution

```bash
python3.10 ~/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/skills/gemini-imagegen/scripts/generate_image.py \
  "Beautiful watercolor painting style. Soft flowing edges with color bleeding and blending. Transparent layered washes of color. Visible paper texture showing through paint. Organic imperfections and happy accidents. White paper showing through as highlights. Delicate brushwork with wet-on-wet techniques. Artistic and emotional aesthetic. Traditional watercolor on cold-pressed paper. Scene: {scene}" \
  "{output}" \
  --model gemini-3-pro-image-preview \
  --aspect {aspect} \
  --size {size}
```

## Examples

### Floral
```
/generate-watercolor "Lush bouquet of peonies and roses in soft pinks and whites"
```

### Landscape
```
/generate-watercolor "Misty mountain landscape at sunrise with pine trees" --aspect 16:9
```

### Portrait
```
/generate-watercolor "Thoughtful woman looking out rainy window, melancholic mood" --aspect 3:4
```

## Style Variations

| Variation | Prompt Addition |
|-----------|-----------------|
| **Loose** | "Very loose and expressive brushwork, abstract elements" |
| **Detailed** | "More detailed botanical illustration style" |
| **Minimal** | "Minimalist watercolor with lots of white space" |
| **Vibrant** | "Bold vibrant watercolors with intense pigments" |
| **Muted** | "Muted earth tones, subtle and calm" |
