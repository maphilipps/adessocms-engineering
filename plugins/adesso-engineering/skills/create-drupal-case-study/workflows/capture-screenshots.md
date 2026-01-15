# Workflow: Capture Screenshots

<process>
## Step 1: Get Project URL

Ask the user for:
- Live site URL
- Any specific pages to capture
- Login credentials (if admin screenshots needed)

## Step 2: Plan Screenshots

Recommend standard screenshot set for Drupal.org case studies:

1. **Homepage (Desktop)** - Full page, above fold focus
2. **Homepage (Mobile)** - 375px width, responsive view
3. **Feature Page** - Key functionality showcase
4. **Content Detail** - Article, event, or product page
5. **Search/Listing** - If Solr or advanced search exists

Ask user which screenshots to capture.

## Step 3: Navigate and Capture

**Use Claude in Chrome (PRIMARY):**

```
# Get tab context first
mcp__claude-in-chrome__tabs_context_mcp

# Desktop Homepage (1440x900)
mcp__claude-in-chrome__resize_window(width=1440, height=900, tabId=<tab_id>)
mcp__claude-in-chrome__navigate(url="[URL]", tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="wait", duration=2, tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
# Save as: [project]-homepage-desktop.png

# Mobile Homepage (375x812)
mcp__claude-in-chrome__resize_window(width=375, height=812, tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
# Save as: [project]-homepage-mobile.png

# Feature Page
mcp__claude-in-chrome__resize_window(width=1440, height=900, tabId=<tab_id>)
mcp__claude-in-chrome__navigate(url="[feature URL]", tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="wait", duration=2, tabId=<tab_id>)
mcp__claude-in-chrome__computer(action="screenshot", tabId=<tab_id>)
# Save as: [project]-feature.png
```

**Fallback (only if Claude in Chrome unavailable):** Use Playwright MCP tools.

## Step 4: Review Screenshots

Show user the captured screenshots:
- Verify they represent the project well
- Check for any sensitive information
- Confirm quality is sufficient (1200px+ width recommended)

## Step 5: Suggest Captions

For each screenshot, suggest a caption:

```
Homepage: "The responsive homepage showcases the championship schedule
and latest news with a dynamic hero section."

Feature Page: "The advanced search interface enables users to filter
matches by date, team, and venue with Solr-powered instant results."
```

## Step 6: Output Screenshot Summary

Provide final summary:

```
=== SCREENSHOTS CAPTURED ===

1. [project]-homepage-desktop.png
   Caption: [suggested caption]
   Dimensions: [width x height]

2. [project]-homepage-mobile.png
   Caption: [suggested caption]
   Dimensions: [width x height]

3. [project]-feature.png
   Caption: [suggested caption]
   Dimensions: [width x height]

Files saved to: [directory path]

**Drupal.org Requirements:**
- Minimum width: 1200px (desktop shots meet this)
- Format: PNG or JPEG
- Upload limit: 2-4 images per case study
```
</process>

<success_criteria>
This workflow is complete when:

- [ ] Project URL obtained
- [ ] Screenshot plan agreed with user
- [ ] Screenshots captured via Playwright
- [ ] Quality verified (1200px+ width)
- [ ] Captions suggested
- [ ] Files saved with descriptive names
- [ ] Summary provided to user
</success_criteria>
