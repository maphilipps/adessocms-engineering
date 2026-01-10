# Workflow: Update Case Study

<required_reading>
**Read these reference files NOW:**
1. references/drupal-org-format.md
</required_reading>

<process>
## Step 1: Load Existing Draft

Ask the user to provide the existing case study draft:
- File path to draft document
- Or paste the content directly

Read and analyze the current state:
- Which sections are complete?
- Which sections need work?
- What information is missing?

## Step 2: Identify Gaps

Compare against required Drupal.org format:

**Check for:**
- [ ] Title - Is it engaging and descriptive?
- [ ] Executive Summary - Is it 2-3 sentences?
- [ ] Why Drupal - Does it have specific module references?
- [ ] Goals - Are there 3-5 concrete goals?
- [ ] Requirements - Are there 3-5 specific requirements?
- [ ] Outcome - Is there a narrative with metrics?
- [ ] Technical Specs - Are modules linked correctly?
- [ ] Team Members - Are Drupal.org usernames included?
- [ ] Screenshots - Are visuals mentioned/included?

Report gaps to user.

## Step 3: Gather Missing Information

For each gap, use AskUserQuestion to collect:
- Specific details needed
- Clarifications on existing content
- Additional context for expansion

## Step 4: Enhance Content

For weak sections, offer improvements:

**Title Enhancement:**
- Suggest 2-3 alternative titles
- Ensure it captures project essence

**Why Drupal Enhancement:**
- Add specific module references
- Strengthen technical justifications
- Link to Drupal.org module pages

**Technical Specs Enhancement:**
- Add missing modules
- Format as table with links
- Include infrastructure details

## Step 5: Polish & Format

Apply final polish:
- Ensure consistent tone (professional, third-person)
- Add concrete metrics where available
- Format all module names as links
- Verify all sections flow well together

## Step 6: Output Updated Sections

Output only the changed/enhanced sections, clearly marked:

```
=== UPDATED: TITLE ===
[New title]

=== UPDATED: WHY DRUPAL ===
[Enhanced content]

... etc
```

Provide summary of changes made.
</process>

<success_criteria>
This workflow is complete when:

- [ ] Existing draft analyzed
- [ ] Gaps identified and reported
- [ ] Missing information gathered
- [ ] Weak sections enhanced
- [ ] Content polished and formatted
- [ ] Updated sections output for user
</success_criteria>
