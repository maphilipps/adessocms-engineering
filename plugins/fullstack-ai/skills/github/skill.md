---
name: github
description: Work with GitHub using gh CLI. Use for pull requests, issues, actions, releases, and repository management.
---

# GitHub CLI (gh)

Interact with GitHub from the command line.

## Authentication

```bash
# Login
gh auth login

# Check status
gh auth status
```

## Pull Requests

### Create PR

```bash
# Interactive
gh pr create

# With options
gh pr create --title "Add feature X" --body "Description" --base main

# Draft PR
gh pr create --draft

# From template
gh pr create --template feature.md
```

### List PRs

```bash
# Your PRs
gh pr list --author @me

# All open PRs
gh pr list --state open

# By label
gh pr list --label "bug"

# JSON output
gh pr list --json number,title,author
```

### View & Checkout

```bash
# View PR details
gh pr view 123

# View in browser
gh pr view 123 --web

# Checkout PR locally
gh pr checkout 123
```

### Review & Merge

```bash
# Add review
gh pr review 123 --approve
gh pr review 123 --request-changes --body "Please fix X"
gh pr review 123 --comment --body "Looks good!"

# Merge
gh pr merge 123 --squash
gh pr merge 123 --rebase
gh pr merge 123 --merge
```

### PR Comments

```bash
# Add comment
gh pr comment 123 --body "Thanks for the contribution!"

# View comments
gh pr view 123 --comments
```

## Issues

### Create Issue

```bash
# Interactive
gh issue create

# With options
gh issue create --title "Bug: X not working" --body "Steps to reproduce..."

# With labels and assignee
gh issue create --title "Feature request" --label "enhancement" --assignee "@me"
```

### List Issues

```bash
# All open issues
gh issue list

# By assignee
gh issue list --assignee @me

# By label
gh issue list --label "bug"

# Search
gh issue list --search "auth in:title"
```

### Manage Issues

```bash
# View issue
gh issue view 456

# Close issue
gh issue close 456

# Reopen
gh issue reopen 456

# Edit
gh issue edit 456 --add-label "priority:high"
```

## Actions (Workflows)

### List Workflows

```bash
# All workflows
gh workflow list

# Run status
gh run list
```

### Run Workflow

```bash
# Trigger workflow
gh workflow run deploy.yml

# With inputs
gh workflow run deploy.yml -f environment=production

# From specific branch
gh workflow run deploy.yml --ref feature-branch
```

### View Run Status

```bash
# List runs
gh run list --workflow=deploy.yml

# View specific run
gh run view 12345

# Watch live
gh run watch 12345

# View logs
gh run view 12345 --log
```

### Cancel/Rerun

```bash
# Cancel run
gh run cancel 12345

# Rerun failed jobs
gh run rerun 12345 --failed
```

## Releases

### Create Release

```bash
# Create from tag
gh release create v1.0.0

# With notes
gh release create v1.0.0 --notes "Release notes here"

# With files
gh release create v1.0.0 ./dist/*.zip

# Draft release
gh release create v1.0.0 --draft

# Generate notes from commits
gh release create v1.0.0 --generate-notes
```

### List Releases

```bash
gh release list
```

### Download Assets

```bash
gh release download v1.0.0
gh release download v1.0.0 --pattern "*.zip"
```

## Repository

### Clone

```bash
gh repo clone owner/repo
gh repo clone owner/repo -- --depth 1
```

### Create

```bash
# Interactive
gh repo create

# Public repo
gh repo create my-project --public

# From template
gh repo create my-project --template owner/template
```

### Fork

```bash
gh repo fork owner/repo
gh repo fork owner/repo --clone
```

### View

```bash
gh repo view
gh repo view owner/repo
gh repo view --web
```

## Gists

```bash
# Create gist
gh gist create file.txt
gh gist create --public file.txt

# List gists
gh gist list

# View gist
gh gist view abc123
```

## API

Direct API access for advanced use cases.

```bash
# GET request
gh api repos/owner/repo

# POST request
gh api repos/owner/repo/issues -f title="Bug" -f body="Description"

# With pagination
gh api repos/owner/repo/issues --paginate

# GraphQL
gh api graphql -f query='{ viewer { login } }'
```

## Configuration

```bash
# Set default repo
gh repo set-default owner/repo

# Configure editor
gh config set editor vim

# Set protocol
gh config set git_protocol ssh
```

## Common Workflows

### Feature Development

```bash
# 1. Create branch
git checkout -b feature/new-feature

# 2. Make changes, commit
git add .
git commit -m "Add new feature"

# 3. Push and create PR
git push -u origin feature/new-feature
gh pr create --fill

# 4. After review, merge
gh pr merge --squash --delete-branch
```

### Bug Fix from Issue

```bash
# 1. View issue
gh issue view 456

# 2. Create branch
git checkout -b fix/issue-456

# 3. Fix and commit
git add .
git commit -m "Fix: resolve issue #456"

# 4. Create PR linking issue
gh pr create --title "Fix #456: Description" --body "Closes #456"
```

### Release Process

```bash
# 1. Ensure main is up to date
git checkout main
git pull

# 2. Create tag
git tag v1.2.0
git push --tags

# 3. Create release with notes
gh release create v1.2.0 --generate-notes

# 4. Upload artifacts
gh release upload v1.2.0 ./dist/*.zip
```

## JSON Output

Most commands support `--json` for machine-readable output:

```bash
# PR list as JSON
gh pr list --json number,title,author,labels

# Filter with jq
gh pr list --json number,title | jq '.[] | select(.title | contains("fix"))'
```

## Environment Variables

```bash
GH_TOKEN=...         # Authentication token
GH_HOST=...          # GitHub host (for Enterprise)
GH_REPO=owner/repo   # Default repository
GH_EDITOR=...        # Editor for interactive commands
```
