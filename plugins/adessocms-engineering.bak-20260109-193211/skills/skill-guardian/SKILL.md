---
name: skill-guardian
description: Maintains ownership, quality, and consistency across all skills in this repository. Use when auditing skills for best practices, optimizing existing skills, checking skill inventory health, enforcing consistency across skills, or migrating skills to latest patterns. Invokes Anthropic official skill-creator patterns. Triggers on "audit skill", "optimize skill", "skill health", "skill inventory", "skill consistency", "migrate skill".
---

<essential_principles>

<anthropic_first>
All guidance derives from Anthropic's official skill-creator and Claude platform documentation.
Reference `/Users/marc.philipps/.claude/plugins/marketplaces/anthropic-agent-skills/skills/skill-creator/SKILL.md` as the authoritative source.
</anthropic_first>

<non_destructive>
Propose changes, never auto-apply without explicit user approval.
Show before/after previews for all modifications.
Group changes by severity for informed decision-making.
</non_destructive>

<metrics_driven>
Use quantifiable quality scores (0-100) across four dimensions:
- **Description Quality**: Third person, triggers, specificity
- **Structure Quality**: Under 500 lines, pure XML, required tags
- **Content Quality**: Concise, imperative, appropriate freedom
- **Progressive Disclosure**: References one level deep, details externalized
</metrics_driven>

<progressive_loading>
SKILL.md is the router. Load workflow files only when needed.
Load reference files only when the workflow requires them.
Never load all content upfront.
</progressive_loading>

</essential_principles>

<intake>
What would you like to do?

1. **Inventory all skills** - Health dashboard with metrics
2. **Deep audit a skill** - Comprehensive best practices check
3. **Optimize skill(s)** - Apply improvements with approval
4. **Batch audit** - Audit all skills in parallel
5. **Enforce consistency** - Cross-skill naming/structure checks
6. **Migrate to latest** - Update to Opus 4.5 era patterns

**Wait for response before proceeding.**
</intake>

<routing>

| Response | Action | Workflow |
|----------|--------|----------|
| 1, "inventory", "list", "health", "dashboard" | List all skills with health metrics | workflows/inventory-skills.md |
| 2, "audit", "deep audit", "check" | Deep audit single skill | workflows/audit-skill-deep.md |
| 3, "optimize", "improve", "fix" | Apply optimizations | workflows/optimize-skill.md |
| 4, "batch", "all", "parallel" | Audit all skills in parallel | workflows/batch-audit.md |
| 5, "consistency", "naming", "structure" | Cross-skill consistency | workflows/enforce-consistency.md |
| 6, "migrate", "update", "opus" | Migrate to latest patterns | workflows/migrate-to-latest.md |

**After reading the workflow, follow it exactly.**

</routing>

<workflows_index>

| Workflow | Purpose |
|----------|---------|
| inventory-skills.md | Scan skills/, output health table with ✅⚠️❌ indicators |
| audit-skill-deep.md | 25+ criteria check against official best practices |
| optimize-skill.md | Apply fixes grouped by severity with user approval |
| batch-audit.md | Parallel audit all skills, aggregate results |
| enforce-consistency.md | Cross-skill naming, structure, pattern consistency |
| migrate-to-latest.md | Pre-Opus 4.5 → current patterns migration |

</workflows_index>

<references_index>

| Reference | Purpose |
|-----------|---------|
| official-best-practices.md | Extracted from Claude platform docs |
| anti-patterns-checklist.md | What to flag and fix |
| quality-metrics.md | Scoring criteria (0-100 per dimension) |
| migration-patterns.md | Old → new transformation patterns |

</references_index>

<templates_index>

| Template | Purpose |
|----------|---------|
| audit-report.md | Standard audit output format |
| optimization-plan.md | Improvement proposal format |

</templates_index>

<quick_reference>

**Required YAML frontmatter:**
```yaml
---
name: lowercase-with-hyphens
description: Third person, specific triggers, concrete scenarios
---
```

**Required body structure:**
- Pure XML tags (no # headings)
- Has `<objective>` or `<essential_principles>`
- Has `<success_criteria>`
- Under 500 lines

**Router pattern (complex skills):**
- `<intake>` - Question to ask
- `<routing>` - Maps answers to workflows
- Essential principles inline (not in separate file)

</quick_reference>

<success_criteria>
Skill guardian successfully completes when:
- Inventory shows accurate health metrics for all skills
- Audits generate actionable, scored reports
- Optimizations apply cleanly with user approval
- Consistency checks flag real issues across skills
- Migrations transform skills to current patterns
- All changes are non-destructive and reversible
</success_criteria>
