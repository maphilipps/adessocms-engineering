---
name: review
description: Perform exhaustive code reviews using multi-agent analysis, ultra-thinking, and worktrees
argument-hint: "[PR number, GitHub URL, branch name, or latest]"
---

# Review Command

<command_purpose> Perform exhaustive code reviews using multi-agent analysis, ultra-thinking, and Git worktrees for deep local inspection. </command_purpose>

## Introduction

<role>Senior Code Review Architect with expertise in security, performance, architecture, and quality assurance</role>

## Prerequisites

<requirements>
- Git repository with GitHub CLI (`gh`) installed and authenticated
- Clean main/master branch
- Proper permissions to create worktrees and access the repository
- For document reviews: Path to a markdown file or document
</requirements>

## Main Tasks

### 1. Determine Review Target & Setup (ALWAYS FIRST)

<review_target> #$ARGUMENTS </review_target>

<thinking>
First, I need to determine the review target type and set up the code for analysis.
</thinking>

#### Immediate Actions:

<task_list>

- [ ] Determine review type: PR number (numeric), GitHub URL, file path (.md), or empty (current branch)
- [ ] Check current git branch
- [ ] If ALREADY on the PR branch → proceed with analysis on current branch
- [ ] If DIFFERENT branch → offer to use worktree: "Use git-worktree skill for isolated Call `skill: git-worktree` with branch name
- [ ] Fetch PR metadata using `gh pr view --json` for title, body, files, linked issues
- [ ] Set up language-specific analysis tools
- [ ] Prepare security scanning environment
- [ ] Make sure we are on the branch we are reviewing. Use gh pr checkout to switch to the branch or manually checkout the branch.

Ensure that the code is ready for analysis (either in worktree or on current branch). ONLY then proceed to the next step.

</task_list>

#### Parallel Agents to review the PR:

<parallel_tasks>

Run ALL or most of these agents at the same time:

1. Task drupal-reviewer(PR content)
2. Task dries-drupal-reviewer(PR title)
3. Task twig-template-reviewer(PR content)
4. Task drupal-theme-reviewer(PR content)
5. Task tailwind-reviewer(PR content)
6. Task storybook-reviewer(PR content)
7. Task accessibility-reviewer(PR content)
8. Task composer-dependency-reviewer(PR content)
9. Task test-coverage-reviewer(PR content)
10. Task git-history-analyzer(PR content)
11. Task pattern-recognition-specialist(PR content)
12. Task architecture-strategist(PR content)
13. Task security-sentinel(PR content)
14. Task performance-oracle(PR content)
15. Task data-integrity-guardian(PR content)

</parallel_tasks>

### 3b. Gemini Co-Author: Cross-Check Review Findings (Optional)

After parallel agents return findings, cross-check with Gemini to catch missed issues or validate findings:

```bash
# Check Gemini availability
if which gemini >/dev/null 2>&1; then
  echo "Gemini available - cross-checking review findings..."
fi
```

**If available, invoke gemini-coauthor skill:**
- Use `workflows/review-output.md` from gemini-coauthor skill
- Collect all agent findings with severity levels
- Send to Gemini for validation and cross-check
- Identify:
  - **Confirmed Issues**: Both Claude agents and Gemini agree
  - **Disputed Issues**: Different severity or validity assessments
  - **Additional Issues**: New findings from Gemini
  - **False Positives**: Issues to dismiss or downgrade

**Synthesis Results:**
- Present consolidated findings with confidence levels
- For disputed issues, present both perspectives
- Remove or downgrade confirmed false positives
- Add any additional issues found by Gemini

**If unavailable:** Continue with agent findings only.

### 4. Ultra-Thinking Deep Dive Phases

<ultrathink_instruction> For each phase below, spend maximum cognitive effort. Think step by step. Consider all angles. Question assumptions. And bring all reviews in a synthesis to the user.</ultrathink_instruction>

<deliverable>
Complete system context map with component interactions
</deliverable>

#### Phase 3: Stakeholder Perspective Analysis

<thinking_prompt> ULTRA-THINK: Put yourself in each stakeholder's shoes. What matters to them? What are their pain points? </thinking_prompt>

<stakeholder_perspectives>

1. **Developer Perspective** <questions>

   - How easy is this to understand and modify?
   - Are the APIs intuitive?
   - Is debugging straightforward?
   - Can I test this easily? </questions>

2. **Operations Perspective** <questions>

   - How do I deploy this safely?
   - What metrics and logs are available?
   - How do I troubleshoot issues?
   - What are the resource requirements? </questions>

3. **End User Perspective** <questions>

   - Is the feature intuitive?
   - Are error messages helpful?
   - Is performance acceptable?
   - Does it solve my problem? </questions>

4. **Security Team Perspective** <questions>

   - What's the attack surface?
   - Are there compliance requirements?
   - How is data protected?
   - What are the audit capabilities? </questions>

5. **Business Perspective** <questions>
   - What's the ROI?
   - Are there legal/compliance risks?
   - How does this affect time-to-market?
   - What's the total cost of ownership? </questions> </stakeholder_perspectives>

#### Phase 4: Scenario Exploration

<thinking_prompt> ULTRA-THINK: Explore edge cases and failure scenarios. What could go wrong? How does the system behave under stress? </thinking_prompt>

<scenario_checklist>

- [ ] **Happy Path**: Normal operation with valid inputs
- [ ] **Invalid Inputs**: Null, empty, malformed data
- [ ] **Boundary Conditions**: Min/max values, empty collections
- [ ] **Concurrent Access**: Race conditions, deadlocks
- [ ] **Scale Testing**: 10x, 100x, 1000x normal load
- [ ] **Network Issues**: Timeouts, partial failures
- [ ] **Resource Exhaustion**: Memory, disk, connections
- [ ] **Security Attacks**: Injection, overflow, DoS
- [ ] **Data Corruption**: Partial writes, inconsistency
- [ ] **Cascading Failures**: Downstream service issues </scenario_checklist>

### 6. Multi-Angle Review Perspectives

#### Technical Excellence Angle

- Code craftsmanship evaluation
- Engineering best practices
- Technical documentation quality
- Tooling and automation assessment

#### Business Value Angle

- Feature completeness validation
- Performance impact on users
- Cost-benefit analysis
- Time-to-market considerations

#### Risk Management Angle

- Security risk assessment
- Operational risk evaluation
- Compliance risk verification
- Technical debt accumulation

#### Team Dynamics Angle

- Code review etiquette
- Knowledge sharing effectiveness
- Collaboration patterns
- Mentoring opportunities

### 4. Simplification and Minimalism Review

Run the Task code-simplicity-reviewer() to see if we can simplify the code.

### 5. Findings Synthesis and Bean Creation

<critical_requirement> ALL findings MUST be stored as Beans using the beans-maintainer agent. Create beans immediately after synthesis - do NOT present findings for user approval first. </critical_requirement>

#### Step 1: Synthesize All Findings

<thinking>
Consolidate all agent reports into a categorized list of findings.
Remove duplicates, prioritize by severity and impact.
</thinking>

<synthesis_tasks>

- [ ] Collect findings from all parallel agents
- [ ] Categorize by type: security, performance, architecture, quality, etc.
- [ ] Assign severity levels: 🔴 CRITICAL (P1), 🟡 IMPORTANT (P2), 🔵 NICE-TO-HAVE (P3)
- [ ] Remove duplicate or overlapping findings
- [ ] Estimate effort for each finding (Small/Medium/Large)

</synthesis_tasks>

#### Step 2: Create Beans for Findings

<critical_instruction> Use the beans-maintainer agent to create Beans for ALL findings immediately. Create beans in parallel, then summarize results to user. </critical_instruction>

**Implementation:**

For each finding, use the beans-maintainer agent (runs on Haiku for speed):

```
Task(subagent_type="adessocms-engineering:workflow:beans-maintainer",
     model="haiku",
     prompt="Transfer this finding to Beans:

     Title: [P1/P2/P3] <finding title>
     Type: bug
     Priority: critical|high|normal|low

     ## Problem
     <what's wrong>

     ## Location
     <file:line references>

     ## Proposed Solution
     <how to fix>

     ## Acceptance Criteria
     - [ ] <testable criterion>")
```

**Parallel Execution Strategy:**

1. Synthesize all findings into categories (P1/P2/P3)
2. Launch beans-maintainer agents in parallel (one per finding or batch)
3. Each agent creates its beans
4. Consolidate results and present summary

**Priority Mapping:**

| Severity | Bean Priority | Bean Type |
|----------|---------------|-----------|
| 🔴 P1 CRITICAL | critical | bug |
| 🟡 P2 IMPORTANT | high | bug or task |
| 🔵 P3 NICE-TO-HAVE | normal or low | task |

**Bean Structure:**

Each finding bean includes:

- **Title**: `[P1/P2/P3] <description>`
- **Type**: `bug` (for issues) or `task` (for improvements)
- **Priority**: Maps from severity level
- **Description**:
  - Problem Statement
  - Location (file:line references)
  - Proposed Solution
  - Acceptance Criteria as checklist

**Linking Findings:**

For related findings, link them:
```bash
# If finding B blocks finding A
beans update <finding-b-id> --link blocks:<finding-a-id>

# If findings are related
beans update <finding-a-id> --link related:<finding-b-id>
```

#### Step 3: Summary Report

After creating all beans, present comprehensive summary:

````markdown
## ✅ Code Review Complete

**Review Target:** PR #XXXX - [PR Title] **Branch:** [branch-name]

### Findings Summary:

- **Total Findings:** [X]
- **🔴 CRITICAL (P1):** [count] - BLOCKS MERGE
- **🟡 IMPORTANT (P2):** [count] - Should Fix
- **🔵 NICE-TO-HAVE (P3):** [count] - Enhancements

### Created Beans:

**P1 - Critical (BLOCKS MERGE):**

- `adesso-cms-xxxx` - [P1] {description}
- `adesso-cms-yyyy` - [P1] {description}

**P2 - Important:**

- `adesso-cms-zzzz` - [P2] {description}

**P3 - Nice-to-Have:**

- `adesso-cms-aaaa` - [P3] {description}

### Review Agents Used:

- drupal-reviewer
- dries-drupal-reviewer
- twig-template-reviewer
- drupal-theme-reviewer
- tailwind-reviewer
- accessibility-reviewer
- security-sentinel
- performance-oracle
- [other agents]

### Next Steps:

1. **Address P1 Findings**: CRITICAL - must be fixed before merge

   - Review each P1 bean in detail
   - Implement fixes or request exemption
   - Mark beans as completed: `beans update <id> --status completed`

2. **View All Findings**:
   ```bash
   beans list                           # View all beans
   beans list --status todo --priority critical  # Only P1 findings
   ```
````

3. **Work on Findings**:

   ```bash
   /work <bean-id>  # Fix a specific finding
   ```

4. **Track Progress**:
   - Update status: `beans update <id> --status in-progress|completed`
   - View progress: `beans list --no-status completed`
   - Commit beans: `git add .beans/ && git commit -m "refactor: add code review findings"`

### Severity Breakdown:

**🔴 P1 (Critical - Blocks Merge):**

- Security vulnerabilities
- Data corruption risks
- Breaking changes
- Critical architectural issues

**🟡 P2 (Important - Should Fix):**

- Performance issues
- Significant architectural concerns
- Major code quality problems
- Reliability issues

**🔵 P3 (Nice-to-Have):**

- Minor improvements
- Code cleanup
- Optimization opportunities
- Documentation updates

```

### Important: P1 Findings Block Merge

Any **🔴 P1 (CRITICAL)** findings must be addressed before merging the PR. Present these prominently and ensure they're resolved before accepting the PR.
```
