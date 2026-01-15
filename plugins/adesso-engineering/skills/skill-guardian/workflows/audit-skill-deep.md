# Workflow: Deep Audit a Skill

<required_reading>
**Read these reference files NOW:**
1. `references/official-best-practices.md`
2. `references/anti-patterns-checklist.md`
3. `references/quality-metrics.md`
</required_reading>

<objective>
Perform comprehensive audit of a single skill against Anthropic's official best practices.
Generate a scored report with actionable findings.
</objective>

<process>

## Step 1: Select Skill

List available skills:
```bash
ls skills/
```

Present as numbered list. Ask: "Which skill to audit? (number or name)"

## Step 2: Read Skill Contents

```bash
# Read main file
cat skills/{skill-name}/SKILL.md

# Check structure
ls -la skills/{skill-name}/
ls skills/{skill-name}/workflows/ 2>/dev/null
ls skills/{skill-name}/references/ 2>/dev/null
ls skills/{skill-name}/templates/ 2>/dev/null
ls skills/{skill-name}/scripts/ 2>/dev/null
```

## Step 3: Run Audit Checklist

### A. YAML Frontmatter (25 points)
- [ ] Has `name:` field (5 pts)
- [ ] Name is lowercase-with-hyphens (5 pts)
- [ ] Name matches directory name (5 pts)
- [ ] Has `description:` field (5 pts)
- [ ] Description is third person ("Use when...") (5 pts)

### B. Structure Quality (25 points)
- [ ] SKILL.md under 500 lines (5 pts)
- [ ] Pure XML structure (no # headings in body) (10 pts)
- [ ] All XML tags properly closed (5 pts)
- [ ] Has required tags (objective/essential_principles) (5 pts)

### C. Content Quality (25 points)
- [ ] Has success_criteria (5 pts)
- [ ] Writing is imperative form (5 pts)
- [ ] Concise (no over-explanation) (5 pts)
- [ ] Appropriate degrees of freedom (5 pts)
- [ ] No redundant content (5 pts)

### D. Progressive Disclosure (25 points)
- [ ] Complex skill uses router pattern (10 pts)
- [ ] Essential principles inline (5 pts)
- [ ] Reference files one level deep (5 pts)
- [ ] All referenced files exist (5 pts)

## Step 4: Calculate Scores

```
Description Quality: X/25
Structure Quality: X/25
Content Quality: X/25
Progressive Disclosure: X/25
─────────────────────────
Total Score: X/100
```

Grade:
- 90-100: Excellent (✅)
- 75-89: Good (✅)
- 60-74: Needs Improvement (⚠️)
- <60: Critical Issues (❌)

## Step 5: Generate Report

Use `templates/audit-report.md` format:

```markdown
## Audit Report: {skill-name}
**Score: X/100 (Grade)**

### ✅ Passing (X items)
- [List passing criteria]

### ⚠️ Warnings (X items)
1. **[Issue]**: [Description]
   → Fix: [Specific action]

### ❌ Critical (X items)
1. **[Issue]**: [Description]
   → Fix: [Specific action]

### Recommendations
1. [Priority recommendation]
2. [Secondary recommendation]
```

## Step 6: Offer Actions

"Would you like to:"
1. **Fix issues** → Route to workflows/optimize-skill.md
2. **Audit another skill** → Restart this workflow
3. **Just the report** → Done

</process>

<success_criteria>
- Skill fully read and analyzed
- All 20 checklist items evaluated
- Score calculated correctly
- Report generated with actionable fixes
- User knows next steps
</success_criteria>
