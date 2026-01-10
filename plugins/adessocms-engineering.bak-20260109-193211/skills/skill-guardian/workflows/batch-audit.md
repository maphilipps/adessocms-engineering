# Workflow: Batch Audit All Skills

<required_reading>
Read `references/quality-metrics.md` for scoring criteria.
</required_reading>

<objective>
Audit all skills in parallel and generate an aggregate report.
</objective>

<process>

## Step 1: List All Skills

```bash
ls skills/
```

Count total skills to audit.

## Step 2: Launch Parallel Audits

For each skill, run the audit checklist from `workflows/audit-skill-deep.md`.

**Parallelization approach:**
- Use Task tool to spawn multiple audit subagents
- Each audits one skill independently
- Collect results when all complete

**OR for simpler execution:**
- Iterate through skills sequentially
- Apply same checklist to each
- Build aggregate results

## Step 3: Collect Results

Build results matrix:

| Skill | Description | Structure | Content | Disclosure | Total | Grade |
|-------|-------------|-----------|---------|------------|-------|-------|
| create-agent-skills | 25 | 25 | 20 | 25 | 95 | ✅ |
| adessocms-frontend | 25 | 20 | 15 | 20 | 80 | ✅ |
| gemini-imagegen | 20 | 25 | 20 | 15 | 80 | ✅ |
| ... | ... | ... | ... | ... | ... | ... |

## Step 4: Calculate Aggregate Metrics

```markdown
## Batch Audit Summary

**Skills Audited:** 17
**Average Score:** 78/100

### Distribution
- Excellent (90+): 4 skills
- Good (75-89): 8 skills
- Needs Improvement (60-74): 4 skills
- Critical (<60): 1 skill

### Common Issues (by frequency)
1. Missing success_criteria: 8 skills
2. Markdown headings in body: 6 skills
3. SKILL.md over 500 lines: 3 skills
4. Description not third person: 3 skills

### Top Performers
1. create-agent-skills: 95/100
2. skill-guardian: 92/100
3. adessocms-frontend: 80/100

### Needs Attention
1. [skill-name]: 55/100 - Missing YAML, no XML structure
2. [skill-name]: 62/100 - Over 700 lines, no router
```

## Step 5: Prioritize Actions

Based on aggregate results, suggest:

```markdown
### Recommended Actions (Priority Order)

1. **Critical fixes** on [skill] - Score <60
   → Run: "Optimize [skill]"

2. **Quick wins** - Add success_criteria to 8 skills
   → Run: "Enforce consistency"

3. **Structure refactor** - Convert markdown → XML in 6 skills
   → Run: "Migrate to latest" on each
```

## Step 6: Offer Next Steps

"Would you like to:"
1. **Fix critical skills** - Optimize skills with <60 score
2. **Apply quick wins** - Add missing success_criteria
3. **Run consistency check** - Find cross-skill patterns
4. **Export report** - Save full audit to file

</process>

<success_criteria>
- All skills audited with consistent criteria
- Results aggregated into summary statistics
- Common issues identified with frequency
- Priority recommendations provided
- User has clear action path
</success_criteria>
