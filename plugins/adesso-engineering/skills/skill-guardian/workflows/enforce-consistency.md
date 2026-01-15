# Workflow: Enforce Consistency

<required_reading>
**Read these reference files NOW:**
1. `references/official-best-practices.md`
2. `references/anti-patterns-checklist.md`
</required_reading>

<objective>
Check all skills for consistent naming, structure, and patterns.
Flag inconsistencies and suggest standardization.
</objective>

<process>

## Step 1: Scan All Skills

```bash
ls skills/
```

Build list of all skill directories.

## Step 2: Check Naming Conventions

For each skill:
- Directory name is lowercase-with-hyphens
- YAML `name:` matches directory name
- No special characters, underscores, or spaces

**Flag inconsistencies:**
```
⚠️ Naming Issues:
- skills/MySkill/ → should be skills/my-skill/
- skills/create_agents/ → should be skills/create-agents/
```

## Step 3: Check Directory Structure

Define expected patterns:

**Simple skill (standalone):**
```
skill-name/
└── SKILL.md
```

**Complex skill (router):**
```
skill-name/
├── SKILL.md
├── workflows/
├── references/
└── templates/ or scripts/ (optional)
```

**Flag inconsistencies:**
```
⚠️ Structure Issues:
- skill-a/ has workflows/ but no references/
- skill-b/ has mixed: workflows/ + loose .md files
- skill-c/ uses /docs instead of /references
```

## Step 4: Check YAML Frontmatter Consistency

All skills should have:
```yaml
---
name: <matches-directory>
description: <third person, includes triggers>
---
```

**Flag inconsistencies:**
```
⚠️ YAML Issues:
- skill-a: missing description
- skill-b: uses 'summary' instead of 'description'
- skill-c: name doesn't match directory
```

## Step 5: Check XML Tag Usage

Common tags should be named consistently across skills:

| Purpose | Standard Tag | Variants Found |
|---------|--------------|----------------|
| Main purpose | `<objective>` | <goal>, <purpose> |
| Quick guide | `<quick_start>` | <quickstart>, <getting_started> |
| Completion | `<success_criteria>` | <done_when>, <completion> |
| Core rules | `<essential_principles>` | <principles>, <rules> |

**Flag inconsistencies:**
```
⚠️ Tag Naming Issues:
- skill-a: uses <goal> instead of <objective>
- skill-b: uses <done_when> instead of <success_criteria>
```

## Step 6: Check Reference Organization

- All reference files should be in `references/` (not `docs/`, `ref/`, etc.)
- All workflow files should be in `workflows/` (not `procedures/`, etc.)
- No deeply nested folders (max 1 level)

**Flag inconsistencies:**
```
⚠️ Organization Issues:
- skill-a/docs/ → should be skill-a/references/
- skill-b/workflows/sub/deep.md → too deep, flatten
```

## Step 7: Generate Consistency Report

```markdown
## Consistency Report

### ✅ Consistent Patterns
- 15/17 skills use lowercase-with-hyphens naming
- 14/17 skills have valid YAML frontmatter
- 12/17 skills use <objective> tag

### ⚠️ Inconsistencies Found

#### Naming (2 issues)
1. `skills/MySkill/` → rename to `skills/my-skill/`
2. `skills/create_agents/` → rename to `skills/create-agents/`

#### Structure (3 issues)
1. `skill-a/docs/` → move to `skill-a/references/`
2. `skill-b/` has no SKILL.md → create or remove
3. `skill-c/workflows/sub/` → flatten nested structure

#### Tags (4 issues)
1. Standardize on `<objective>` (not <goal>, <purpose>)
2. Standardize on `<success_criteria>` (not <done_when>)

### Recommendations
1. Run batch rename for 2 directory names
2. Consolidate tag naming in 4 skills
3. Reorganize 3 skill structures
```

## Step 8: Offer Fixes

"Would you like to:"
1. **Apply naming fixes** - Rename directories to conventions
2. **Reorganize structures** - Move files to standard locations
3. **Standardize tags** - Rename XML tags for consistency
4. **Just the report** - No changes

**Warning for renames:** "Directory renames may break references. Proceed with caution."

</process>

<success_criteria>
- All skills checked for consistency
- Naming issues identified and catalogued
- Structure issues identified and catalogued
- Tag naming inconsistencies found
- Clear standardization recommendations
- User can apply fixes with approval
</success_criteria>
