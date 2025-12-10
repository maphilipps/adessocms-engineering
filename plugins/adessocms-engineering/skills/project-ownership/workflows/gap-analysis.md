# Gap Analysis Workflow

<required_reading>
Read before proceeding:
- references/quartz-components.md
- references/adesso-components.md
- references/feature-comparison.md
</required_reading>

<objective>
Identify missing components and features compared to the 1xInternet Quartz reference.
</objective>

<process>
## Step 1: Refresh Component Inventory

```bash
# List current adesso CMS components
ls -la /Users/marc.philipps/Sites/adesso-cms/web/themes/custom/adesso_cms_theme/components/
```

## Step 2: Check Component Quality

For each component, verify:
```bash
# Check if component has required files
for comp in /Users/marc.philipps/Sites/adesso-cms/web/themes/custom/adesso_cms_theme/components/*/; do
  name=$(basename "$comp")
  echo "=== $name ==="
  ls -la "$comp"
done
```

## Step 3: Compare Against Quartz

Using the feature-comparison.md matrix:

1. **Identify ❌ (Missing)** - Components that don't exist
2. **Identify 🔄 (Partial)** - Components that need enhancement
3. **Prioritize by business value**

## Step 4: Generate Gap Report

Output format:
```markdown
## Gap Analysis Report - [DATE]

### Critical Gaps (Blocks user workflows)
| Component | Quartz | Business Impact | Effort |
|-----------|--------|-----------------|--------|
| ... | ... | ... | S/M/L |

### Important Gaps (Reduces UX quality)
| Component | Quartz | Business Impact | Effort |
|-----------|--------|-----------------|--------|
| ... | ... | ... | S/M/L |

### Nice-to-Have (Future consideration)
| Component | Quartz | Business Impact | Effort |
|-----------|--------|-----------------|--------|
| ... | ... | ... | S/M/L |

### Recommendations
1. ...
2. ...
```

## Step 5: Propose Next Steps

Ask user:
- "Shall I create ticket proposals for the critical gaps?"
- "Would you like to update the roadmap?"
</process>

<success_criteria>
- All current components inventoried
- Quality status checked (story, schema present)
- Gaps categorized by priority
- Effort estimates provided
- Clear recommendations made
</success_criteria>
