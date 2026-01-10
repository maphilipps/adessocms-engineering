# Pattern Consistency Analysis Report
**Generated:** 2025-12-31
**Total Agents Analyzed:** 34

## Summary

All 34 agents have been analyzed for frontmatter pattern consistency. This report identifies violations and provides recommendations.

---

## 1. TOOLS FIELD PRESENCE

**STATUS:** ✅ ALL AGENTS HAVE TOOLS FIELD

All 34 agents include a `tools:` field in their frontmatter. This is consistent.

---

## 2. FIELD ORDER VIOLATIONS

**EXPECTED ORDER:**
```yaml
name: agent-name
description: description text
tools: tool, list
model: model-name
color: color-name
```

### Violations Found:

#### CRITICAL: skill-invoker.md
**Current order:**
```yaml
name: skill-invoker
color: blue          # ❌ Wrong position (should be after model)
model: haiku
description: ...
tools: ...
```

**Should be:**
```yaml
name: skill-invoker
description: ...
tools: ...
model: haiku
color: blue
```

#### CRITICAL: librarian.md
**Current order:**
```yaml
name: librarian
description: ...
model: sonnet        # ❌ model before tools
color: blue          # ❌ color before tools
tools: ...
```

**Should be:**
```yaml
name: librarian
description: ...
tools: ...
model: sonnet
color: blue
```

---

## 3. COLOR SCHEME VIOLATIONS

**EXPECTED COLOR SCHEME:**
- **Core agents:** `blue`
- **Research agents:** `yellow`
- **Workflow agents:** `yellow`
- **Specialist agents:** `blue`
- **Design agents:** `magenta`
- **Security agents:** `red`
- **Performance agents:** `red`

### Violations Found:

#### agent-native-reviewer.md
- **Current:** `purple`
- **Expected:** `blue` (specialist category)
- **Violation:** Custom color not in standard scheme

#### accessibility-specialist.md
- **Current:** `cyan`
- **Expected:** `blue` (specialist category)
- **Violation:** Custom color not in standard scheme

---

## 4. AGENT CATEGORIZATION

### Core Agents (5) - Expected Color: BLUE ✅
| Agent | Color | Status |
|-------|-------|--------|
| reviewer-selector | blue | ✅ Correct |
| skill-invoker | blue | ✅ Correct |
| frontend-engineer | blue | ✅ Correct |
| document-writer | blue | ✅ Correct |
| librarian | blue | ✅ Correct |

### Research Agents (4) - Expected Color: YELLOW ✅
| Agent | Color | Status |
|-------|-------|--------|
| git-history-analyzer | yellow | ✅ Correct |
| repo-research-analyst | yellow | ✅ Correct |
| framework-docs-researcher | yellow | ✅ Correct |
| best-practices-researcher | yellow | ✅ Correct |

### Workflow Agents (4) - Expected Color: YELLOW ✅
| Agent | Color | Status |
|-------|-------|--------|
| acms-bug-reproduction-validator | yellow | ✅ Correct |
| acms-lint | yellow | ✅ Correct |
| acms-spec-flow-analyzer | yellow | ✅ Correct |
| acms-pr-comment-resolver | yellow | ✅ Correct |

### Specialist Agents (18) - Expected Color: BLUE
| Agent | Color | Status |
|-------|-------|--------|
| drupal-specialist | blue | ✅ Correct |
| sdc-specialist | blue | ✅ Correct |
| tailwind-specialist | blue | ✅ Correct |
| twig-specialist | blue | ✅ Correct |
| paragraphs-specialist | blue | ✅ Correct |
| storybook-specialist | blue | ✅ Correct |
| test-coverage-specialist | blue | ✅ Correct |
| composer-specialist | blue | ✅ Correct |
| architecture-strategist | blue | ✅ Correct |
| pattern-recognition-specialist | blue | ✅ Correct |
| component-reuse-specialist | blue | ✅ Correct |
| drupal-theme-specialist | blue | ✅ Correct |
| code-simplifier | blue | ✅ Correct |
| data-integrity-guardian | blue | ✅ Correct |
| **accessibility-specialist** | **cyan** | ❌ **VIOLATION** |
| **agent-native-reviewer** | **purple** | ❌ **VIOLATION** |

### Security/Performance Specialists (2) - Expected Color: RED ✅
| Agent | Color | Status |
|-------|-------|--------|
| security-sentinel | red | ✅ Correct |
| performance-oracle | red | ✅ Correct |

### Design Agents (3) - Expected Color: MAGENTA ✅
| Agent | Color | Status |
|-------|-------|--------|
| figma-design-sync | magenta | ✅ Correct |
| design-implementation-reviewer | magenta | ✅ Correct |
| design-iterator | magenta | ✅ Correct |

---

## 5. NAMING CONVENTION ANALYSIS

**EXPECTED PATTERNS:**
- Core: `[noun]-[noun]` or `[role-name]`
- Research: `[domain]-[analyzer/researcher]`
- Workflow: `acms-[action]-[noun]`
- Specialists: `[domain]-specialist`
- Design: `[action]-[noun]` or `design-[action]`

### All agents follow naming conventions ✅

---

## 6. MODEL DISTRIBUTION

| Model | Count | Agents |
|-------|-------|--------|
| opus | 23 | Most specialists, design, research |
| sonnet | 3 | librarian, performance-oracle, architecture-strategist, pattern-recognition-specialist |
| haiku | 2 | reviewer-selector, skill-invoker, composer-specialist, acms-lint |

**NOTE:** Model selection appears appropriate based on agent complexity.

---

## RECOMMENDATIONS

### Priority 1: Fix Field Order Violations
1. **skill-invoker.md** - Reorder: move `color` after `model`, move `description` before `color`
2. **librarian.md** - Reorder: move `tools` before `model` and `color`

### Priority 2: Fix Color Scheme Violations
3. **accessibility-specialist.md** - Change `cyan` → `blue`
4. **agent-native-reviewer.md** - Change `purple` → `blue`

### Priority 3: Establish Enforcement
5. Add pre-commit hook to validate agent frontmatter
6. Create agent template with correct field order
7. Document color scheme in CLAUDE.md or CONTRIBUTING.md

---

## FILES REQUIRING CHANGES

### High Priority (Field Order):
- `/Users/marc.philipps/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/agents/core/skill-invoker.md`
- `/Users/marc.philipps/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/agents/core/librarian.md`

### Medium Priority (Color Scheme):
- `/Users/marc.philipps/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/agents/specialists/accessibility-specialist.md`
- `/Users/marc.philipps/.claude/plugins/marketplaces/adessocms-marketplace/plugins/adessocms-engineering/agents/specialists/agent-native-reviewer.md`

---

## VALIDATION CHECKLIST

For all future agents, verify:
- [ ] Field order: name → description → tools → model → color
- [ ] Color matches category (core/specialist=blue, research/workflow=yellow, design=magenta, security/perf=red)
- [ ] Tools field is present
- [ ] Name follows category convention
- [ ] Model is appropriate for complexity (haiku/sonnet/opus)
