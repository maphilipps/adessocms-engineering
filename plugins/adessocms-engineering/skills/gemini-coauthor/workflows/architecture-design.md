# Workflow: Architecture Design

<purpose>
Gemini 3 Pro acts as Strategic Architect to design system architecture, make technology decisions, and evaluate trade-offs BEFORE Claude begins implementation planning.
</purpose>

<when_to_use>
- At the START of `/plan` workflow (Phase 1)
- For complex features requiring architectural decisions
- When technology stack choices need to be made
- For system design that impacts multiple components
</when_to_use>

<gemini_role>
**Gemini 3 Pro = Strategic Architect**
- System architecture design
- Technology stack decisions
- High-level approach
- Trade-off analysis (performance vs simplicity vs maintainability)
- Risk identification
- Scalability considerations
</gemini_role>

<process>
## Step 1: Check Gemini Availability

```bash
if ! which gemini >/dev/null 2>&1; then
  echo "SKIP: Gemini not available, Claude will handle architecture (less optimal)"
  exit 0
fi
```

If unavailable, Claude does architecture (fallback mode).

## Step 2: Prepare Context for Gemini

Gather research findings from repo-research-analyst, best-practices-researcher, and framework-docs-researcher agents.

Create context summary:
- Feature description
- Research findings
- Constraints (Drupal 11, existing patterns)
- Performance requirements
- Security considerations

## Step 3: Send Architecture Design Request to Gemini

```bash
gemini -y "You are a Strategic Architect for Drupal 11 development.

TASK: Design the architecture for this feature.

Feature Description:
[FEATURE_DESCRIPTION]

Context:
[RESEARCH_FINDINGS]

Constraints:
- Drupal 11.2+ with PHP 8.3
- Must follow Drupal coding standards
- Must be exportable via config management
- Frontend: Vite + Tailwind v4 + SDC components

Please provide:

## System Architecture
- High-level design
- Component breakdown
- Data flow

## Technology Decisions
- Which Drupal APIs/systems to use (Plugin, Service, Event Subscriber, etc.)
- Why each choice (justify trade-offs)
- Alternatives considered and rejected

## Technical Approach
- How components interact
- Where logic lives (backend vs frontend)
- Caching strategy
- Security approach

## Trade-offs Analysis
- Performance vs Simplicity
- Flexibility vs Maintainability
- Custom code vs Contrib modules

## Risks & Mitigation
- Technical risks
- How to mitigate each

## Scalability Considerations
- How this scales with data growth
- Performance implications

Format as structured markdown suitable for an Architecture Decision Record (ADR).
"
```

## Step 4: Parse Gemini's Architecture Document

Gemini returns architecture document. Save to `architecture/[feature-name]-architecture.md`.

## Step 5: Create Architecture Bean (Beans Integration)

```bash
# Check and init beans if needed
if ! [ -d ".beans" ]; then
  echo "Initializing Beans for this project..."
  beans init
fi

# Create architecture bean
beans create "Architecture: [Feature Name]" \
  -t milestone \
  -p high \
  -d "$(cat architecture/[feature-name]-architecture.md)" \
  -s in-progress \
  --json
```

Save bean ID for linking implementation beans later.

## Step 6: Present Architecture to User

Show user:
- Gemini's architecture document
- Key decisions and trade-offs
- Recommendations

Ask: "Does this architectural approach make sense? Any concerns or different preferences?"

## Step 7: Iterate if Needed

If user has concerns:
- Update context with user feedback
- Re-run Gemini with additional constraints
- Update architecture document

## Step 8: Hand Off to Claude for Implementation Planning

Once architecture is approved:
- Claude receives architecture document
- Claude creates detailed implementation plan
- Claude follows architectural decisions from Gemini
</process>

<output>
## Architecture Document Structure

```markdown
# Architecture: [Feature Name]

**Status:** Proposed
**Architect:** Gemini 3 Pro
**Date:** YYYY-MM-DD

## System Architecture

[High-level design, component diagram]

## Technology Decisions

### Decision 1: [Technology/Pattern]
- **Choice:** [What we're using]
- **Rationale:** [Why]
- **Alternatives Considered:** [What else, why not]
- **Trade-offs:** [What we gain/lose]

## Technical Approach

[How components interact, data flow]

## Risks & Mitigation

| Risk | Impact | Mitigation |
|------|--------|------------|
| [Risk] | [High/Med/Low] | [How to mitigate] |

## Scalability Considerations

[Performance, data growth, caching strategy]

## Implementation Guidance

[What Claude should focus on, what patterns to follow]
```
</output>

<success_criteria>
- Gemini availability checked
- Architecture document created with all sections
- Architecture bean created and linked
- User approved architecture
- Document saved to `architecture/` directory
- Bean ID passed to implementation phase
</success_criteria>

<fallback_without_gemini>
If Gemini unavailable:
1. Claude creates architecture (less strategic)
2. Still create architecture document
3. Still create architecture bean
4. Note in bean: "Created by Claude (Gemini unavailable)"
</fallback_without_gemini>
