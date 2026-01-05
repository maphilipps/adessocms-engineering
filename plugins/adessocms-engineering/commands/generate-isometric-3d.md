---
name: generate-isometric-3d
description: Generate isometric 3D low-poly style images using Gemini API
argument-hint: "<scene description> [--output filename.jpg] [--aspect 16:9] [--size 2K]"
---

# /generate-isometric-3d - Isometric Low-Poly 3D Image Generator

Generiert hochwertige isometrische 3D-Renderings im Low-Poly-Stil.

## Style Characteristics

- **Perspektive:** Isometrisch (30° Winkel, keine Fluchtpunkte)
- **Geometrie:** Low-Poly mit sauberen, facettierten Oberflächen
- **Farben:** Klare, satte Farben mit sanften Verläufen
- **Schatten:** Weiche, diffuse Schatten
- **Details:** Minimalistisch aber erkennbar
- **Materialien:** Matte Oberflächen, kein Glanz

## Usage

```bash
/generate-isometric-3d "Ein modernes Bürogebäude mit Parkplatz und Bäumen"
/generate-isometric-3d "Logistikzentrum mit LKWs und Laderampen" --output warehouse.jpg
/generate-isometric-3d "Café mit Außenterrasse und Gästen" --aspect 16:9 --size 2K
```

## Execution

### 1. Parse Arguments

```python
import argparse
import shlex

# Default values
output = "isometric_3d.jpg"
aspect = "16:9"
size = "2K"
scene = "$ARGUMENTS"

# Parse if flags present
if "--" in "$ARGUMENTS":
    parts = shlex.split("$ARGUMENTS")
    # Extract scene (everything before first --)
    scene_parts = []
    i = 0
    while i < len(parts) and not parts[i].startswith("--"):
        scene_parts.append(parts[i])
        i += 1
    scene = " ".join(scene_parts)

    # Parse remaining flags
    while i < len(parts):
        if parts[i] == "--output" and i + 1 < len(parts):
            output = parts[i + 1]
            i += 2
        elif parts[i] == "--aspect" and i + 1 < len(parts):
            aspect = parts[i + 1]
            i += 2
        elif parts[i] == "--size" and i + 1 < len(parts):
            size = parts[i + 1]
            i += 2
        else:
            i += 1
```

### 2. Build Prompt

Der Prompt wird automatisch mit dem Isometric Low-Poly Style angereichert:

```
STYLE_PREFIX = """High-quality isometric 3D rendering in low-poly style.
Clean geometric shapes with faceted surfaces.
Soft diffuse shadows on light gray ground plane.
Matte materials, no glossy reflections.
Miniature diorama aesthetic with tiny detailed figures.
Professional corporate illustration style.
Warm natural lighting from top-left.
Tilt-shift depth of field effect.
Color palette: Clean whites, soft grays, with accent colors."""

FULL_PROMPT = f"{STYLE_PREFIX}\n\nScene: {scene}"
```

### 3. Generate Image

Führe das Script aus:

```bash
python3.10 ~/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/skills/gemini-imagegen/scripts/generate_image.py \
  "{FULL_PROMPT}" \
  "{output}" \
  --model gemini-3-pro-image-preview \
  --aspect {aspect} \
  --size {size}
```

### 4. Output

Nach erfolgreicher Generierung:

```
✅ Isometric 3D image generated: {output}

Style: Low-Poly Isometric 3D
Scene: {scene}
Aspect: {aspect}
Size: {size}
```

## Style Variations

Du kannst den Stil mit Zusätzen variieren:

| Variation | Zusatz zum Prompt |
|-----------|-------------------|
| **Nacht** | "Night scene with warm interior lighting and street lamps" |
| **Winter** | "Winter scene with snow coverage and bare trees" |
| **Busy** | "Busy scene with many people and vehicles in motion" |
| **Aerial** | "Higher aerial view showing larger area" |
| **Cutaway** | "Cutaway view showing interior spaces" |

## Examples

### Logistik/Warehouse
```
/generate-isometric-3d "Large logistics warehouse with loading docks, red branded trucks, forklift activity, and workers"
```

### Office Building
```
/generate-isometric-3d "Modern glass office building with rooftop garden, parking garage, and employees entering"
```

### Retail Store
```
/generate-isometric-3d "Flagship retail store with large windows, customer queue, and delivery van"
```

### Factory
```
/generate-isometric-3d "Manufacturing facility with assembly line visible through windows, smokestacks, and cargo containers"
```

## Technical Notes

- **Model:** gemini-3-pro-image-preview (best quality)
- **Default Aspect:** 16:9 (ideal für Präsentationen)
- **Default Size:** 2K (gute Balance Qualität/Speed)
- **Format:** JPEG (Gemini default)
- **Requires:** `GEMINI_API_KEY` environment variable
