# Official Best Practices

<source>
Extracted from:
- Claude Platform docs: https://platform.claude.com/docs/en/agents-and-tools/agent-skills/
- Anthropic skill-creator: `/Users/marc.philipps/.claude/plugins/marketplaces/anthropic-agent-skills/skills/skill-creator/SKILL.md`
</source>

<skill_anatomy>

## Required: SKILL.md

Every skill MUST have a SKILL.md file with:

### YAML Frontmatter (Required)
```yaml
---
name: lowercase-with-hyphens    # Must match directory name
description: Third person description with specific triggers
---
```

### Body Structure (Required)
- Pure XML tags (NO markdown headings like #, ##, ###)
- Has `<objective>` or `<essential_principles>`
- Has `<success_criteria>` or `<when_successful>`

</skill_anatomy>

<progressive_disclosure>

## Three-Level Loading

1. **Metadata** - Always in context (~100 words)
   - Just name + description from YAML

2. **SKILL.md body** - When skill triggers (<5k tokens)
   - Core instructions, router, quick start

3. **Bundled resources** - As needed (unlimited)
   - scripts/, references/, templates/, assets/

**Rule:** SKILL.md under 500 lines. Split larger content into reference files.

</progressive_disclosure>

<directory_structure>

## Standard Skill Layout

**Simple skill (single file):**
```
skill-name/
└── SKILL.md
```

**Complex skill (router pattern):**
```
skill-name/
├── SKILL.md              # Router + essential principles
├── workflows/            # Step-by-step procedures (FOLLOW)
├── references/           # Domain knowledge (READ)
├── templates/            # Output structures (COPY + FILL)
└── scripts/              # Executable code (RUN)
```

**Folder purposes:**
- `workflows/` - Multi-step procedures Claude follows
- `references/` - Domain knowledge Claude reads for context
- `templates/` - Consistent output formats Claude copies
- `scripts/` - Executable code Claude runs as-is

</directory_structure>

<description_quality>

## Writing Effective Descriptions

**Requirements:**
1. Third person ("Use when..." not "I will...")
2. Specific trigger phrases that match user requests
3. Concrete scenarios, not vague generalities
4. States both WHAT it does and WHEN to use it

**Good example:**
```yaml
description: Maintains ownership, quality, and consistency across all skills.
  Use when auditing skills for best practices, optimizing existing skills,
  checking skill inventory health, or migrating skills to latest patterns.
```

**Bad example:**
```yaml
description: Helps with skills.
```

</description_quality>

<xml_structure>

## Pure XML Tags

**Use semantic XML tags instead of markdown headings:**

| Instead of | Use |
|------------|-----|
| `# Objective` | `<objective>` |
| `## Quick Start` | `<quick_start>` |
| `### Workflow` | `<workflow>` |
| `## Success Criteria` | `<success_criteria>` |

**Why XML:**
- Unambiguous section boundaries
- Claude parses more reliably
- Consistent across all skills
- Enables programmatic validation

**Markdown is OK for:**
- Formatting WITHIN tags (bold, lists, code blocks)
- NOT for section headings

</xml_structure>

<router_pattern>

## Router Pattern for Complex Skills

When a skill supports multiple workflows, use router pattern:

```xml
<essential_principles>
[Core rules that always apply - inline, not in separate file]
</essential_principles>

<intake>
What would you like to do?

1. Option A
2. Option B
3. Option C

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Action | Workflow |
|----------|--------|----------|
| 1, "a" | [Description] | workflows/option-a.md |
| 2, "b" | [Description] | workflows/option-b.md |
| 3, "c" | [Description] | workflows/option-c.md |
</routing>
```

**Key points:**
- Essential principles MUST be inline (can't be skipped)
- Intake asks a simple question
- Routing maps answers to workflow files
- Workflow files are loaded only when matched

</router_pattern>

<conciseness>

## Conciseness Principle

**Default assumption:** Claude is already very smart.

Only add context Claude doesn't already have:
- Domain-specific knowledge (company schemas, APIs)
- Non-obvious patterns or gotchas
- Specific constraints or requirements

**Don't explain:**
- Common programming concepts
- Standard library usage
- Well-known tools (git, npm, pip)

**Challenge every paragraph:**
- "Does Claude really need this?"
- "Does this justify its token cost?"

**Prefer:** Concise examples over verbose explanations

</conciseness>

<degrees_of_freedom>

## Matching Specificity to Fragility

**High freedom** (text-based guidance):
- Creative tasks (code review, content generation)
- Multiple valid approaches
- Heuristics guide the work

**Medium freedom** (templates with parameters):
- Standard operations with preferred patterns
- Some variation acceptable
- Configuration affects behavior

**Low freedom** (exact scripts):
- Fragile operations (database migrations, payments)
- Consistency critical
- Specific sequence required

**Rule:** Match specificity to how fragile the task is. More fragile = less freedom.

</degrees_of_freedom>

<workflow_files>

## Workflow File Structure

Each workflow file should have:

```markdown
# Workflow: [Name]

<required_reading>
**Read these reference files NOW:**
1. references/[relevant-file].md
2. references/[other-file].md
</required_reading>

<objective>
[What this workflow accomplishes]
</objective>

<process>
## Step 1: [Title]
[Instructions]

## Step 2: [Title]
[Instructions]
</process>

<success_criteria>
- [Verifiable outcome 1]
- [Verifiable outcome 2]
</success_criteria>
```

</workflow_files>

<reference_files>

## Reference File Best Practices

- Store in `references/` directory
- Keep one level deep (no nested folders)
- Include table of contents for files >100 lines
- Use descriptive names matching content
- Load only when workflow requires it

**Good names:**
- `official-best-practices.md`
- `quality-metrics.md`
- `migration-patterns.md`

**Avoid:**
- `ref1.md`
- `misc-notes.md`
- `stuff.md`

</reference_files>

<imperative_writing>

## Writing Style

Use imperative/infinitive form:
- ✅ "Configure the server"
- ✅ "Run the migration"
- ✅ "Create the component"

Not descriptive:
- ❌ "You should configure the server"
- ❌ "The server needs to be configured"
- ❌ "Configuring the server is important"

</imperative_writing>

<success_criteria_section>

## Success Criteria Requirements

Every skill MUST have success criteria that are:

1. **Verifiable** - Can be checked objectively
2. **Specific** - Not vague platitudes
3. **Complete** - Covers all key outcomes

**Good:**
```xml
<success_criteria>
- All skills in directory listed with health metrics
- Audit report generated with actionable fixes
- User approved changes before application
</success_criteria>
```

**Bad:**
```xml
<success_criteria>
- User is happy
- Skill works correctly
- Things are good
</success_criteria>
```

</success_criteria_section>
