#!/bin/bash
# Architecture Design Prompt Generator for Gemini 3 Pro
# Usage: ./architecture-design-prompt.sh <feature-name> <research-summary>

set -euo pipefail

FEATURE_NAME="${1:-}"
RESEARCH_SUMMARY="${2:-}"

if [[ -z "$FEATURE_NAME" ]]; then
  echo "Error: Feature name required"
  echo "Usage: $0 <feature-name> <research-summary>"
  exit 1
fi

# Generate architecture design prompt for Gemini
cat <<EOF
You are a Strategic Architect for Drupal 11 development with expertise in system design, technology choices, and trade-off analysis.

TASK: Design the system architecture for this feature.

FEATURE: $FEATURE_NAME

RESEARCH CONTEXT:
$RESEARCH_SUMMARY

PROJECT CONTEXT:
- Drupal 11.2+ (PHP 8.3, MariaDB 10.11)
- Frontend: Vite 6.2+, Tailwind CSS v4, Flowbite 3.1
- Development: DDEV (Docker), Node.js 20
- Testing: Vitest, Playwright, PHPStan, PHPUnit
- Architecture: Single Directory Components (SDC), Recipes, Modern Drupal patterns

REQUIRED ARCHITECTURE DOCUMENT SECTIONS:

## 1. System Architecture
- High-level component diagram (ASCII art or description)
- How components interact
- Data flow between components
- Integration points with existing Drupal systems

## 2. Technology Decisions
For each major technology choice, provide:
- **Decision:** What technology/pattern to use
- **Rationale:** Why this choice (business + technical reasons)
- **Alternatives Considered:** What else was evaluated
- **Trade-offs:** What we gain vs what we sacrifice

Example decisions to address:
- Plugin vs Service vs Event Subscriber
- Config Entity vs Content Entity vs State API
- Form API vs Custom Forms
- Cache strategy (tags, contexts, bins)
- Database schema approach
- Frontend component architecture (SDC patterns)

## 3. Technical Approach
- Implementation strategy (phases if complex)
- Key algorithms or patterns to use
- Performance considerations from the start
- Security considerations (access control, validation, sanitization)
- Testing strategy (unit, integration, E2E)

## 4. Risks & Mitigation
- Technical risks identified
- Mitigation strategies for each risk
- Fallback plans if needed

## 5. Scalability Considerations
- How will this scale with data growth?
- How will this scale with traffic growth?
- Resource requirements (memory, CPU, storage)
- Caching strategy

## 6. Implementation Guidance for Claude
- Critical patterns to follow
- Common pitfalls to avoid
- Must-have vs nice-to-have features
- Suggested implementation order
- Acceptance criteria for "done"

OUTPUT FORMAT:
- Write in clear, concise markdown
- Use Drupal-specific terminology correctly
- Reference Drupal best practices and patterns
- Be opinionated - make clear recommendations
- Explain WHY, not just WHAT

SAVE OUTPUT TO: architecture/$FEATURE_NAME-architecture.md

After creating the architecture document, you will:
1. Create an Architecture Bean (milestone, high priority)
2. Present architecture to user for approval
3. Claude will create implementation plan based on this architecture
EOF
