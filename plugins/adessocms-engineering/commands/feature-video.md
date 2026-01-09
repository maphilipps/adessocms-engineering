---
name: feature-video
description: Record a video demonstration of a feature for PR documentation
argument-hint: "[feature name or empty for current feature]"
---

# /feature-video - Feature Demo Recording

Record a video demonstration of implemented features for PR documentation.

## Purpose

Create visual documentation of features to:
1. Show reviewers exactly what changed
2. Document expected behavior
3. Serve as living documentation
4. Speed up PR reviews

## Workflow

### Phase 1: Prepare Demo Script

Create a demo script covering:
- Starting state (before)
- User actions to perform
- Expected results (after)
- Edge cases to demonstrate

```markdown
## Demo Script: [Feature Name]

### Setup
- Navigate to [URL]
- Ensure [precondition]

### Actions
1. Click [element]
2. Fill [form field] with [value]
3. Submit

### Expected Results
- See [success message]
- Data appears in [location]
- Email sent to [recipient]
```

### Phase 2: Start Recording

Use Claude in Chrome GIF creator:

```
mcp__claude-in-chrome__tabs_context_mcp()
mcp__claude-in-chrome__gif_creator(action: "start_recording", tabId: X)
```

### Phase 3: Execute Demo

Navigate and perform the demo actions:

```
# Navigate to starting point
mcp__claude-in-chrome__navigate(url: "https://mysite.ddev.site/feature-page", tabId: X)

# Take initial screenshot
mcp__claude-in-chrome__computer(action: "screenshot", tabId: X)

# Perform actions
mcp__claude-in-chrome__computer(action: "left_click", coordinate: [X, Y], tabId: X)
mcp__claude-in-chrome__fill(ref: "ref_1", value: "Demo input", tabId: X)

# Capture result
mcp__claude-in-chrome__computer(action: "screenshot", tabId: X)
```

### Phase 4: Stop Recording

```
mcp__claude-in-chrome__gif_creator(action: "stop_recording", tabId: X)
```

### Phase 5: Export GIF

```
mcp__claude-in-chrome__gif_creator(
  action: "export",
  tabId: X,
  filename: "feature-demo.gif",
  download: true,
  options: {
    showClickIndicators: true,
    showActionLabels: true,
    showProgressBar: true,
    quality: 10
  }
)
```

### Phase 6: Add to PR

Include the video in PR description:

```markdown
## Demo

![Feature Demo](./feature-demo.gif)

### What's shown:
1. User navigates to [page]
2. Fills out [form]
3. Submits and sees [result]
```

## Recording Best Practices

### Before Recording
- Clear browser cache
- Use consistent test data
- Remove personal information
- Set consistent window size

### During Recording
- Move slowly and deliberately
- Pause on important elements
- Show both success and error states
- Demonstrate edge cases

### After Recording
- Review for clarity
- Trim unnecessary parts
- Add annotations if needed
- Compress if too large

## GIF Options

| Option | Default | Description |
|--------|---------|-------------|
| `showClickIndicators` | true | Orange circles at click locations |
| `showDragPaths` | true | Red arrows for drag actions |
| `showActionLabels` | true | Black labels describing actions |
| `showProgressBar` | true | Orange progress bar at bottom |
| `showWatermark` | true | Claude logo watermark |
| `quality` | 10 | 1-30 (lower = better quality) |

## File Size Guidelines

| Size | Use Case |
|------|----------|
| < 1MB | Inline in PR, README |
| 1-5MB | Linked attachment |
| > 5MB | Convert to video, host externally |

## Integration

This command is typically run:
1. After `/playwright-test` passes
2. Before creating PR
3. As part of `/lfg` workflow

## Alternative: Playwright Video

For longer recordings, use Playwright's built-in video:

```typescript
// playwright.config.ts
export default defineConfig({
  use: {
    video: 'on-first-retry'
  }
});
```

Then reference in PR:
```markdown
## Test Recording
See [test-video.webm](./test-results/video.webm)
```
