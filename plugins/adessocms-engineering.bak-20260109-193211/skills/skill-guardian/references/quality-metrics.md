# Quality Metrics

<overview>
Scoring criteria for skill audits. Four dimensions, 25 points each, totaling 100 points.
</overview>

<scoring_dimensions>

## Dimension A: Description Quality (25 points)

| Criterion | Points | Check |
|-----------|--------|-------|
| Has `name:` field | 5 | YAML contains name field |
| Name is lowercase-with-hyphens | 5 | Regex: `^[a-z][a-z0-9-]*$` |
| Name matches directory | 5 | Directory name equals YAML name |
| Has `description:` field | 5 | YAML contains description field |
| Description is third person | 5 | No "I", "you", "we"; uses "Use when..." |

**Scoring:**
- 25/25: Perfect description
- 20-24: Minor issues (e.g., slightly vague)
- 15-19: Missing one key element
- <15: Multiple issues or missing

## Dimension B: Structure Quality (25 points)

| Criterion | Points | Check |
|-----------|--------|-------|
| SKILL.md under 500 lines | 5 | `wc -l` < 500 |
| Pure XML structure | 10 | No `^#` in body after frontmatter |
| All XML tags closed | 5 | Matching open/close tags |
| Has required tags | 5 | Has objective OR essential_principles |

**Scoring:**
- 25/25: Perfect structure
- 20-24: Minor structure issues
- 15-19: Markdown headings present
- <15: Missing required structure

## Dimension C: Content Quality (25 points)

| Criterion | Points | Check |
|-----------|--------|-------|
| Has success_criteria | 5 | Tag exists with content |
| Writing is imperative | 5 | Uses action verbs, not "you should" |
| Concise (no over-explanation) | 5 | No common concept explanations |
| Appropriate degrees of freedom | 5 | Low for fragile, high for creative |
| No redundant content | 5 | Information in one place only |

**Scoring:**
- 25/25: Excellent content
- 20-24: Mostly good, minor wordiness
- 15-19: Missing success_criteria or verbose
- <15: Multiple content issues

## Dimension D: Progressive Disclosure (25 points)

| Criterion | Points | Check |
|-----------|--------|-------|
| Router pattern (if complex) | 10 | Has intake + routing if >1 workflow |
| Essential principles inline | 5 | Not in separate reference file |
| References one level deep | 5 | No nested reference directories |
| All referenced files exist | 5 | No broken links |

**Scoring:**
- 25/25: Perfect progressive disclosure
- 20-24: Minor organization issues
- 15-19: Missing router or skippable principles
- <15: Broken references or poor organization

</scoring_dimensions>

<grade_scale>

## Grade Scale

| Score | Grade | Interpretation |
|-------|-------|----------------|
| 90-100 | ✅ Excellent | Follows all best practices |
| 75-89 | ✅ Good | Minor improvements possible |
| 60-74 | ⚠️ Needs Improvement | Multiple issues to address |
| <60 | ❌ Critical | Requires significant rework |

</grade_scale>

<health_indicators>

## Quick Health Indicators

For inventory dashboard, use simplified indicators:

| Aspect | ✅ Pass | ⚠️ Warning | ❌ Fail |
|--------|---------|------------|---------|
| **Lines** | <300 | 300-500 | >500 |
| **YAML** | Valid name+desc | Missing desc | Invalid/missing |
| **Structure** | Pure XML | Mixed | Markdown only |
| **Subfiles** | Organized | Flat | None needed but missing |

</health_indicators>

<calculation_example>

## Score Calculation Example

```
Skill: create-agent-skills

A. Description Quality:
   - Has name: ✅ (5)
   - Lowercase-hyphens: ✅ (5)
   - Matches directory: ✅ (5)
   - Has description: ✅ (5)
   - Third person: ✅ (5)
   Subtotal: 25/25

B. Structure Quality:
   - Under 500 lines: ✅ (5)
   - Pure XML: ✅ (10)
   - Tags closed: ✅ (5)
   - Required tags: ✅ (5)
   Subtotal: 25/25

C. Content Quality:
   - Has success_criteria: ✅ (5)
   - Imperative writing: ✅ (5)
   - Concise: ⚠️ (3) - some verbosity
   - Degrees of freedom: ✅ (5)
   - No redundancy: ✅ (5)
   Subtotal: 23/25

D. Progressive Disclosure:
   - Router pattern: ✅ (10)
   - Principles inline: ✅ (5)
   - One level deep: ✅ (5)
   - Files exist: ✅ (5)
   Subtotal: 25/25

TOTAL: 98/100 (✅ Excellent)
```

</calculation_example>

<aggregate_metrics>

## Aggregate Metrics (Batch Audit)

When auditing all skills, calculate:

**Average Score:** Sum of scores / Number of skills

**Distribution:**
- Count skills in each grade bracket
- Identify outliers (very high or very low)

**Common Issues:**
- Count frequency of each criterion failure
- Rank by most common

**Priority Matrix:**
```
                High Impact
                    ↑
   Quick Wins   |   Priority 1
   (fix many    |   (fix first)
    at once)    |
  ←─────────────┼─────────────→ Hard to Fix
   Low Priority |   Priority 2
   (ignore or   |   (plan for
    defer)      |    later)
                ↓
              Low Impact
```

</aggregate_metrics>
