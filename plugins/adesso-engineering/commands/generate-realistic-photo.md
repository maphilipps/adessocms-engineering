---
name: generate-realistic-photo
description: Generate photorealistic images with studio lighting using Gemini API
argument-hint: "<scene description> [--output filename.jpg] [--aspect 16:9] [--size 2K]"
---

# /generate-realistic-photo - Photorealistic Image Generator

Generiert fotorealistische Bilder mit professionellem Studio-Lighting.

## Style Characteristics

- **Qualität:** Fotorealistisch, hochauflösend
- **Beleuchtung:** Professionelles 3-Punkt Studio-Setup
- **Schärfe:** Gestochen scharf mit kontrollierter Tiefenunschärfe
- **Farben:** Natürlich, farbkorrigiert
- **Details:** Hohe Detailtreue, realistische Texturen
- **Komposition:** Professionelle Fotografie-Regeln

## Style Prompt

```
STYLE_PREFIX = """Photorealistic high-resolution photograph.
Professional three-point studio lighting setup.
Sharp focus with shallow depth of field where appropriate.
Natural color grading, not oversaturated.
Shot on high-end DSLR camera with 85mm lens.
Clean, uncluttered composition following rule of thirds.
Commercial photography quality suitable for advertising.
Realistic textures and materials."""
```

## Usage

```bash
/generate-realistic-photo "Laptop auf Holztisch mit Kaffeetasse"
/generate-realistic-photo "Professionelles Headshot einer Geschäftsfrau" --aspect 1:1
/generate-realistic-photo "Modernes Büro-Interior" --aspect 16:9 --size 4K
```

## Execution

```bash
python3.10 ~/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/skills/gemini-imagegen/scripts/generate_image.py \
  "Photorealistic high-resolution photograph. Professional three-point studio lighting setup. Sharp focus with shallow depth of field where appropriate. Natural color grading, not oversaturated. Shot on high-end DSLR camera with 85mm lens. Clean, uncluttered composition following rule of thirds. Commercial photography quality suitable for advertising. Realistic textures and materials. Scene: {scene}" \
  "{output}" \
  --model gemini-3-pro-image-preview \
  --aspect {aspect} \
  --size {size}
```

## Examples

### Product Shot
```
/generate-realistic-photo "Sleek smartphone on marble surface with soft reflections and plant in background"
```

### Portrait
```
/generate-realistic-photo "Professional headshot of confident business executive in modern office" --aspect 1:1
```

### Interior
```
/generate-realistic-photo "Modern minimalist office space with large windows and designer furniture" --aspect 16:9
```

## Lighting Variations

| Variation | Prompt Addition |
|-----------|-----------------|
| **Golden Hour** | "Warm golden hour natural lighting through window" |
| **High Key** | "High key lighting, bright and airy atmosphere" |
| **Low Key** | "Low key dramatic lighting with deep shadows" |
| **Backlit** | "Backlit with rim lighting creating silhouette effect" |
| **Natural** | "Soft natural daylight, no artificial lighting" |
