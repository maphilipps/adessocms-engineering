# AI-Assisted Drupal Project Estimation Guidelines

This document provides estimation values for Drupal projects where **Claude Code** or similar AI assistants support ALL development phases.

## AI-Assisted Philosophy

**Key Assumption:** Every development task is performed WITH AI assistance:
- Content architecture: AI analyzes and maps automatically
- Code generation: AI writes boilerplate, config, templates
- Testing: AI generates test cases and implementations
- Documentation: AI generates docs from code
- Migration: AI transforms and cleans content

**Typical AI Reduction:** 60-70% compared to traditional development

## AI-Assisted Estimation Table

| Component | Simple | Medium | Complex | AI Reduction |
|-----------|--------|--------|---------|--------------|
| Content Type | 1h | 2h | 4h | ~67% |
| Paragraph Type | 0.5h | 1h | 2h | ~67% |
| Taxonomy | 0.5h | 1h | 2h | ~67% |
| Media Type | 0.5h | 1h | 1.5h | ~67% |
| View | 1h | 2h | 4h | ~67% |
| Webform | 1h | 2h | 4h | ~67% |
| Block | 0.5h | 1h | 2h | ~67% |
| Custom Module | 4h | 10h | 25h | ~65% |
| Theme Component (SDC) | 1h | 2h | 4h | ~67% |

**Formula:**
```
AI-Assisted Hours = Traditional Hours × 0.33
```

## Why These Reductions?

### Content Types (67% reduction)
- **Traditional:** Manual YAML writing, field configuration, form display, view modes
- **AI-Assisted:** Claude generates complete config from description in minutes

### Paragraph Types (67% reduction)
- **Traditional:** Schema design, Twig templates, CSS, JavaScript
- **AI-Assisted:** Claude generates SDC component with all files from requirements

### Views (67% reduction)
- **Traditional:** UI configuration, filters, sorts, displays, caching
- **AI-Assisted:** Claude generates Views config YAML directly

### Theme Components (67% reduction)
- **Traditional:** Design → HTML → Twig → CSS → JS → Storybook
- **AI-Assisted:** Claude generates complete SDC from Figma/description

### Custom Modules (65% reduction)
- **Traditional:** Architecture, coding, testing, debugging
- **AI-Assisted:** Claude generates boilerplate, services, plugins; human reviews

## AI-Assisted Multipliers

### Testing (reduced from +25% to +10%)
- AI generates test cases
- AI writes PHPUnit tests
- AI creates Playwright E2E tests
- Human reviews and validates

### Documentation (reduced from +15% to +5%)
- AI generates docs from code
- AI creates user guides
- Human reviews and approves

### QA (reduced from +20% to +10%)
- AI assists code review
- AI identifies issues
- Human validates critical paths

### Migration (reduced by 70%)
```
AI-Assisted Migration = Traditional Migration × 0.3

Per 100 nodes:
- Simple: 3h (vs. 10h traditional)
- Medium: 6h (vs. 20h traditional)
- Complex: 10h (vs. 35h traditional)
```

**Why:** AI transforms HTML, maps fields, cleans content automatically

## AI-Assisted Project Sizes

### Small Project (AI-Assisted)
**Traditional:** 300-450h → **AI-Assisted:** 100-150h

- 3-4 content types: 4-8h
- 10-15 paragraphs: 5-15h
- 30-40 components: 30-80h
- Timeline: 2.5-4 weeks @ 40h/week

### Medium Project (AI-Assisted)
**Traditional:** 550-850h → **AI-Assisted:** 180-280h

- 4-6 content types: 6-12h
- 15-25 paragraphs: 15-50h
- 40-60 components: 40-120h
- Timeline: 4.5-7 weeks @ 40h/week

### Large Project (AI-Assisted)
**Traditional:** 1,000-1,600h → **AI-Assisted:** 330-530h

- 8-12+ content types: 12-24h
- 40-60+ paragraphs: 40-120h
- 80-120+ components: 80-240h
- Timeline: 8-13 weeks @ 40h/week

## What AI CAN'T Reduce

Some tasks remain largely unchanged:

| Task | Reduction | Reason |
|------|-----------|--------|
| Requirements Gathering | 0% | Human communication |
| Stakeholder Meetings | 0% | Human interaction |
| Design Decisions | ~20% | AI assists, human decides |
| Complex Business Logic | ~30% | Domain expertise needed |
| Security Audit | ~30% | Human validation required |
| User Training | 0% | Human-to-human |
| Project Management | ~20% | Coordination is human |

## AI-Assisted Workflow

```
Traditional:                    AI-Assisted:
─────────────                   ─────────────
1. Requirement (human)    →     1. Requirement (human)
2. Design (human)         →     2. Design (human + AI)
3. Architecture (human)   →     3. Architecture (AI generates)
4. Coding (human)         →     4. Coding (AI generates, human reviews)
5. Testing (human)        →     5. Testing (AI generates, human validates)
6. Documentation (human)  →     6. Documentation (AI generates)
7. Review (human)         →     7. Review (human, AI assists)
```

## Cost Comparison Example

**Medium Project:**

| Metric | Traditional | AI-Assisted | Savings |
|--------|-------------|-------------|---------|
| Hours | 700h | 230h | 470h (67%) |
| Timeline | 17.5 weeks | 5.8 weeks | 11.7 weeks |
| Cost (€150/h) | €105,000 | €34,500 | €70,500 |

## When to Use AI-Assisted Estimates

✅ **Use AI-Assisted when:**
- Team uses Claude Code or similar
- AI tools available for all phases
- Standard Drupal patterns
- Team trained on AI workflows

❌ **Use Traditional when:**
- No AI tools available
- Legacy systems without AI support
- Highly regulated environments
- Client prohibits AI usage

## Risk Considerations

### Lower Buffer for AI-Assisted
- **Traditional Buffer:** 15-25%
- **AI-Assisted Buffer:** 10-15%

**Why:** AI generates consistent, testable code with fewer surprises

### New Risks with AI
- AI hallucinations → Human review required
- Context limits → Break into smaller tasks
- API availability → Have fallback plan

## Final Notes

**Key Insight:** AI doesn't just speed up tasks—it fundamentally changes HOW work is done:

1. **Shift from writing to reviewing**
2. **Focus on requirements and validation**
3. **Parallel generation instead of sequential coding**
4. **Instant documentation from code**

**Best Practice:** Always provide BOTH estimates (Traditional + AI-Assisted) to clients:
- Shows value of AI-assisted development
- Manages expectations
- Justifies AI tooling investment
