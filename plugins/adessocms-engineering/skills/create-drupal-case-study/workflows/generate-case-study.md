# Workflow: Generate Case Study

<required_reading>
**Read these reference files NOW:**
1. references/drupal-org-format.md
2. templates/case-study-output.md
</required_reading>

<process>
## Step 1: Codebase Analysis

Analyze the project to extract technical details automatically:

```bash
# Drupal version and modules
ddev exec composer show drupal/core | head -5
ddev exec composer show --installed | grep drupal/

# Custom modules
ls -la web/modules/custom/

# Theme information
ls -la web/themes/custom/
cat web/themes/custom/*/composer.json 2>/dev/null || cat web/themes/custom/*/*.info.yml

# Key configuration
ddev drush config:get system.site name
ddev drush pm:list --status=enabled --type=module --no-core | head -30
```

**Extract and note:**
- Drupal version (10.x or 11.x)
- Key contrib modules (Paragraphs, Solr, Migrate, etc.)
- Custom modules and their purpose
- Theme approach (Tailwind, Bootstrap, custom)
- Notable integrations (APIs, search, etc.)

## Step 2: Gather Project Context

Use AskUserQuestion to collect missing information:

**Question Set 1 - Client & Context:**
- Client/Organization name
- Industry/Sector (Government, Sports, Healthcare, Education, etc.)
- Project timeline (start, launch date)
- Project URL (live site)

**Question Set 2 - Goals & Challenges:**
- What was the main challenge or need?
- What were the primary goals? (3-5 bullet points)
- What were the key requirements? (3-5 bullet points)

**Question Set 3 - Outcomes & Impact:**
- What was the main outcome/achievement?
- Any metrics or measurable results?
- What makes this project special/noteworthy?

**Question Set 4 - Team & Process:**
- Team members (Drupal.org usernames)
- Development approach (Agile, phases, etc.)
- Any special methodologies or tools used?

## Step 3: Craft "Why Drupal" Section

Based on the technical analysis, craft compelling reasons. Common justifications:

- **Modularity**: Paragraphs, Layout Builder, flexible content architecture
- **Scalability**: High-traffic handling, caching strategies
- **Accessibility**: WCAG 2.1 compliance, native a11y support
- **API-First**: Headless capabilities, REST/JSON:API
- **Community**: Long-term support, security updates
- **Content Management**: Editorial workflows, multilingual support
- **Integration**: Third-party APIs, search engines, external systems

Match reasons to actual modules and features found in codebase.

## Step 4: Generate Structured Sections

Use the template from `templates/case-study-output.md` to generate each section:

1. **Title**: Create engaging title that captures project essence
   - Pattern: "[Action/Impact]: The [Project Type] for [Client]"
   - Examples: "Empowering Sustainable Energy Solutions: The Relaunch of the Energy Atlas Bavaria"

2. **Executive Summary**: 2-3 sentences covering:
   - Who (client)
   - What (project type)
   - Why (key benefit/outcome)

3. **Why Drupal Was Chosen**: 3-5 paragraphs with specific module references

4. **Project Description**:
   - Goals (bullet list)
   - Requirements (bullet list)
   - Outcome (narrative paragraph)

5. **Key Features & Technologies**: Grouped by category with explanations

6. **Technical Specifications**: Table format with links

## Step 5: Capture Screenshots

If live URL provided, use Playwright to capture screenshots:

```
mcp__playwright__browser_navigate to [project URL]
mcp__playwright__browser_take_screenshot for homepage (full page)
mcp__playwright__browser_navigate to key feature page
mcp__playwright__browser_take_screenshot for feature showcase
```

**Screenshot recommendations:**
- Homepage (above fold)
- Key feature or content page
- Mobile view (resize browser)
- Admin interface (if accessible)

Save screenshots with descriptive names:
- `[project]-homepage.png`
- `[project]-feature.png`

## Step 6: Output Final Sections

Output each section separately, clearly labeled for copy-paste into Drupal.org submission form:

```
=== TITLE ===
[Title text]

=== EXECUTIVE SUMMARY ===
[Summary text]

=== WHY DRUPAL WAS CHOSEN ===
[Why Drupal text]

... etc
```

Provide clear instructions for submission.
</process>

<success_criteria>
This workflow is complete when:

- [ ] Codebase analyzed and technical details extracted
- [ ] All project context questions answered
- [ ] "Why Drupal" section crafted with specific module references
- [ ] All required sections generated
- [ ] Screenshots captured (if URL provided)
- [ ] Output formatted for Drupal.org submission
- [ ] User has all sections ready for copy-paste
</success_criteria>
