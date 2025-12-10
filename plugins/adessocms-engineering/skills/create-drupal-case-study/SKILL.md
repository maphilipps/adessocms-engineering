---
name: create-drupal-case-study
description: Generates Drupal.org case study submissions by analyzing project codebases and gathering project information. Use when creating case studies for Drupal.org showcase, documenting client projects, or preparing project references.
---

<essential_principles>
## Drupal.org Case Study Format

Case studies on Drupal.org follow a standardized structure that showcases projects effectively to the Drupal community.

### Required Sections

1. **Title**: Engaging, descriptive title that captures the project essence
2. **Executive Summary**: 2-3 sentences overview of client, challenge, and solution
3. **Why Drupal Was Chosen**: Justification for Drupal selection (modularity, community, scalability, etc.)
4. **Project Description**: Goals, Requirements, and Outcome subsections
5. **Key Features & Technologies**: Technical highlights with module explanations
6. **Technical Specifications**: Drupal version, key modules, infrastructure

### Required Metadata

- **Client/Organization**: Who the project was built for
- **Industry/Sector**: Government, Sports, Healthcare, etc.
- **Partner Organization**: The agency/company that built it
- **Drupal Version**: 10.x or 11.x
- **Team Members**: Drupal.org usernames of contributors

### Quality Standards

- Write in professional, third-person tone
- Highlight Drupal-specific solutions and modules
- Include concrete metrics or outcomes where possible
- Link to relevant Drupal.org module pages
- Provide compelling "Why Drupal" justification
</essential_principles>

<objective>
Generate complete, submission-ready Drupal.org case studies by:
1. Analyzing the project codebase (composer.json, modules, theme, config)
2. Gathering missing information through targeted questions
3. Creating screenshots of the live site via Playwright
4. Outputting structured sections ready for Drupal.org submission
</objective>

<quick_start>
Invoke this skill in a Drupal project directory. The skill will:

1. Analyze your codebase to extract technical details
2. Ask targeted questions about client, goals, and outcomes
3. Generate structured case study sections
4. Optionally capture screenshots of the live site

**Basic invocation:**
```
/create-drupal-case-study
```

**With live site URL:**
```
/create-drupal-case-study https://example.com
```
</quick_start>

<intake>
**What would you like to do?**

1. **Generate case study** - Analyze codebase and create full case study
2. **Update existing draft** - Refine or expand an existing case study draft
3. **Capture screenshots only** - Take screenshots for an existing case study

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "generate", "create", "new" | `workflows/generate-case-study.md` |
| 2, "update", "refine", "edit" | `workflows/update-case-study.md` |
| 3, "screenshot", "capture", "images" | `workflows/capture-screenshots.md` |

**After reading the workflow, follow it exactly.**
</routing>

<reference_index>
All domain knowledge in `references/`:

**Format**: drupal-org-format.md - Complete Drupal.org case study structure
**Examples**: example-sections.md - Real-world section examples from published case studies
</reference_index>

<workflows_index>
| Workflow | Purpose |
|----------|---------|
| generate-case-study.md | Full case study generation from codebase analysis |
| update-case-study.md | Refine or expand existing draft |
| capture-screenshots.md | Playwright-based screenshot capture |
</workflows_index>

<templates_index>
| Template | Purpose |
|----------|---------|
| case-study-output.md | Structured output format for copy-paste |
</templates_index>

<success_criteria>
A complete case study submission includes:

- [ ] Engaging title that captures project essence
- [ ] Executive summary (2-3 sentences)
- [ ] "Why Drupal" section with concrete justifications
- [ ] Goals, Requirements, Outcome clearly defined
- [ ] Technical specifications with module list
- [ ] Team members with Drupal.org usernames
- [ ] At least 2 screenshots of live site
- [ ] All sections formatted for Drupal.org submission
</success_criteria>
