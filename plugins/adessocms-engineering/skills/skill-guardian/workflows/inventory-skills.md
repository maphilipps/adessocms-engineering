# Workflow: Inventory Skills

<required_reading>
Read `references/quality-metrics.md` for scoring criteria.
</required_reading>

<objective>
Scan all skills in the repository and generate a health dashboard with metrics.
</objective>

<process>

## Step 1: Scan Skills Directory

```bash
ls -la skills/
```

For each skill directory, check if SKILL.md exists.

## Step 2: Analyze Each Skill

For each skill with SKILL.md:

1. **Count lines**: `wc -l skills/{name}/SKILL.md`
2. **Check YAML**: Extract name and description from frontmatter
3. **Check structure**: Look for XML tags vs markdown headings
4. **Count subfiles**: `ls skills/{name}/workflows/ skills/{name}/references/ 2>/dev/null`

## Step 3: Calculate Health Indicators

| Metric | ✅ Pass | ⚠️ Warning | ❌ Fail |
|--------|---------|------------|---------|
| Lines | <300 | 300-500 | >500 |
| YAML | Valid name+desc | Missing desc | Invalid/missing |
| Structure | Pure XML | Mixed | Markdown headings |
| Subfiles | Organized | Flat | None needed but missing |

## Step 4: Generate Dashboard

Output as table:

```
## Skill Inventory Dashboard

| Skill | Lines | Structure | YAML | Subfiles | Health |
|-------|-------|-----------|------|----------|--------|
| create-agent-skills | 193 | Router | ✅ | 22 | ✅ |
| adessocms-frontend | 450 | Router | ✅ | 15 | ⚠️ |
| gemini-imagegen | 89 | Simple | ✅ | 0 | ✅ |

**Summary:**
- Total skills: 17
- Healthy: 12 (✅)
- Warnings: 4 (⚠️)
- Issues: 1 (❌)
```

## Step 5: Offer Next Actions

Based on results, suggest:
- "Run deep audit on [skill with ❌]?"
- "Run batch audit for detailed report?"
- "Check consistency across all skills?"

</process>

<success_criteria>
- All skills in skills/ directory listed
- Each skill has health indicators
- Summary statistics calculated
- Next action suggestions provided
</success_criteria>
