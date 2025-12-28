---
name: acms-plan
description: Transform feature descriptions into well-structured project plans following conventions
argument-hint: "[feature description, bug report, or improvement idea]"
---

# Create a plan for a new feature or bug fix

## Core Principle

> **We want the simplest change possible. We don't care about migration. Code readability matters most, and we're happy to make bigger changes to achieve it.**

## Introduction

**Note: The current year is 2025.** Use this when dating plans and searching for recent documentation.

Transform feature descriptions, bug reports, or improvement ideas into well-structured markdown files that follow project conventions and best practices.

## Feature Description

<feature_description> #$ARGUMENTS </feature_description>

**If the feature description above is empty, ask the user:** "What would you like to plan? Please describe the feature, bug fix, or improvement you have in mind."

Do not proceed until you have a clear feature description from the user.

## Main Tasks

### 0. Quick Context Scan (FIRST)

**Before asking questions, understand the IST-Zustand.**

You can't ask good questions without knowing the current state. Do a quick scan:

1. **Read relevant files** - If the feature mentions specific areas, read those files
2. **Search for existing patterns** - `Grep` or `Glob` for related code
3. **Check docs/solutions/** - Look for existing learnings on this topic
4. **Understand the scope** - How big is this change? What exists already?

**This should be fast (1-2 minutes max).** Just enough to ask informed questions.

### 1. Deep Interview (MANDATORY)

**Now that you understand the context, interview the user in depth.**

Use the **AskUserQuestion tool** to clarify:

- Technical implementation details
- UI & UX considerations
- Concerns and edge cases
- Tradeoffs and alternatives
- Integration points
- Performance requirements
- Security considerations
- Error handling expectations
- User permissions and access control
- Data models and relationships
- Migration needs (or lack thereof)
- Testing requirements

**Rules:**
- Ask **non-obvious** questions that require thought
- Reference what you found in the context scan
- Go deep - surface-level questions waste time
- Continue interviewing until the spec is truly complete
- Use multi-select questions when exploring options
- Challenge assumptions - ask "why" and "what if"

**Example informed questions:**
- "I found `ExistingService.php` doing X. Should we extend it or create something new?"
- "There's already a similar pattern in `ModuleY`. Follow that or diverge?"
- "The current implementation uses caching strategy X. Keep that or change?"
- "I see no tests for this area. Is that intentional or a gap to fill?"

**Only proceed to deep research after the interview is complete.**

### 2. Repository Research & Context Gathering

Run these agents in parallel:

- Task repo-research-analyst(feature_description)
- Task best-practices-researcher(feature_description)
- Task framework-docs-researcher(feature_description)

**Reference Collection:**

- [ ] Document all research findings with specific file paths (e.g., `web/modules/custom/example/src/Service/ExampleService.php:42`)
- [ ] Include URLs to external documentation and best practices guides
- [ ] Create a reference list of similar issues or PRs (e.g., `#123`, `#456`)
- [ ] Note any team conventions discovered in `CLAUDE.md` or team documentation

### 3. Issue Planning & Structure

**Title & Categorization:**

- [ ] Draft clear, searchable issue title using conventional format (e.g., `feat:`, `fix:`, `docs:`)
- [ ] Determine issue type: enhancement, bug, refactor

**Content Planning:**

- [ ] Choose appropriate detail level based on issue complexity
- [ ] List all necessary sections for the chosen template
- [ ] Gather supporting materials (error logs, screenshots, design mockups)
- [ ] Prepare code examples or reproduction steps if applicable

### 4. SpecFlow Analysis

After planning the issue structure, run SpecFlow Analyzer to validate and refine the feature specification:

- Task acms-spec-flow-analyzer(feature_description, research_findings)

**SpecFlow Analyzer Output:**

- [ ] Review SpecFlow analysis results
- [ ] Incorporate any identified gaps or edge cases into the issue
- [ ] Update acceptance criteria based on SpecFlow findings

### 5. Choose Implementation Detail Level

Select how comprehensive you want the issue to be. Simpler is mostly better.

#### 📄 MINIMAL (Quick Issue)

**Best for:** Simple bugs, small improvements, clear features

**Includes:**
- Problem statement or feature description
- Basic acceptance criteria
- Essential context only

#### 📋 MORE (Standard Issue)

**Best for:** Most features, complex bugs, team collaboration

**Includes everything from MINIMAL plus:**
- Detailed background and motivation
- Technical considerations
- Dependencies and risks
- Basic implementation suggestions

#### 📚 A LOT (Comprehensive Issue)

**Best for:** Major features, architectural changes, complex integrations

**Includes everything from MORE plus:**
- Detailed implementation plan with phases
- Alternative approaches considered
- Resource requirements and timeline
- Risk mitigation strategies

### 6. Issue Creation & Formatting

**Content Formatting:**

- [ ] Use clear, descriptive headings with proper hierarchy
- [ ] Include code examples in triple backticks with language syntax highlighting
- [ ] Add screenshots/mockups if UI-related
- [ ] Use task lists (- [ ]) for trackable items
- [ ] Apply appropriate emoji for visual scanning (🐛 bug, ✨ feature, 📚 docs, ♻️ refactor)

**Cross-Referencing:**

- [ ] Link to related issues/PRs using #number format
- [ ] Reference specific commits with SHA hashes when relevant
- [ ] Link to code using GitHub's permalink feature

### 7. Final Review & Submission

**Pre-submission Checklist:**

- [ ] Title is searchable and descriptive
- [ ] All template sections are complete
- [ ] Links and references are working
- [ ] Acceptance criteria are measurable
- [ ] Add names of files in pseudo code examples and todo lists

## Output Format

Write the plan to `plans/<issue_title>.md`

## Post-Generation Options

After writing the plan file, use the **AskUserQuestion tool** to present these options:

**Question:** "Plan ready at `plans/<issue_title>.md`. What would you like to do next?"

**Options:**
1. **Open plan in editor** - Open the plan file for review
2. **Run `/plan_review`** - Get feedback from reviewers
3. **Start `/acms-work`** - Begin implementing this plan
4. **Create Issue** - Create issue in project tracker (GitHub/Linear)
5. **Simplify** - Reduce detail level

Based on selection:
- **Open plan in editor** → Run `open -a Typora plans/<issue_title>.md`
- **`/plan_review`** → Call the /plan_review command with the plan file path
- **`/acms-work`** → Call the /acms-work command with the plan file path
- **Create Issue** → Use `gh issue create` with plan content
- **Simplify** → Ask "What should I simplify?" then regenerate simpler version

NEVER CODE! Just research and write the plan.
