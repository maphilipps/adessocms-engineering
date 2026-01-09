# gh Commands Reference

## Authentication

| Command | Description |
|---------|-------------|
| `gh auth login` | Login to GitHub |
| `gh auth status` | Check auth status |
| `gh auth logout` | Logout |
| `gh auth token` | Print auth token |
| `gh auth refresh` | Refresh token |

---

## Pull Requests

| Command | Description |
|---------|-------------|
| `gh pr create` | Create PR |
| `gh pr list` | List PRs |
| `gh pr view <id>` | View PR details |
| `gh pr view --web` | Open in browser |
| `gh pr checkout <id>` | Checkout PR branch |
| `gh pr merge <id>` | Merge PR |
| `gh pr close <id>` | Close PR |
| `gh pr reopen <id>` | Reopen PR |
| `gh pr review <id>` | Review PR |
| `gh pr diff <id>` | Show diff |
| `gh pr comment <id>` | Add comment |
| `gh pr checks <id>` | Show checks |
| `gh pr status` | PR status for current branch |
| `gh pr ready <id>` | Mark ready (un-draft) |

---

## Issues

| Command | Description |
|---------|-------------|
| `gh issue create` | Create issue |
| `gh issue list` | List issues |
| `gh issue view <id>` | View issue |
| `gh issue close <id>` | Close issue |
| `gh issue reopen <id>` | Reopen issue |
| `gh issue edit <id>` | Edit issue |
| `gh issue comment <id>` | Add comment |
| `gh issue develop <id>` | Create branch for issue |
| `gh issue pin <id>` | Pin issue |
| `gh issue unpin <id>` | Unpin issue |
| `gh issue transfer <id> <repo>` | Transfer issue |

---

## Actions / Workflows

| Command | Description |
|---------|-------------|
| `gh run list` | List workflow runs |
| `gh run view <id>` | View run details |
| `gh run watch <id>` | Watch run |
| `gh run rerun <id>` | Rerun workflow |
| `gh run cancel <id>` | Cancel run |
| `gh run download <id>` | Download artifacts |
| `gh workflow list` | List workflows |
| `gh workflow run <name>` | Trigger workflow |
| `gh workflow view <name>` | View workflow |
| `gh workflow enable <name>` | Enable workflow |
| `gh workflow disable <name>` | Disable workflow |

---

## Repository

| Command | Description |
|---------|-------------|
| `gh repo create` | Create repository |
| `gh repo clone <repo>` | Clone repository |
| `gh repo fork` | Fork repository |
| `gh repo view` | View repo info |
| `gh repo view --web` | Open in browser |
| `gh repo list` | List user's repos |
| `gh repo sync` | Sync fork |
| `gh repo rename <new>` | Rename repo |
| `gh repo delete` | Delete repo |
| `gh repo archive` | Archive repo |

---

## Releases

| Command | Description |
|---------|-------------|
| `gh release list` | List releases |
| `gh release create <tag>` | Create release |
| `gh release view <tag>` | View release |
| `gh release download <tag>` | Download assets |
| `gh release delete <tag>` | Delete release |
| `gh release upload <tag> <files>` | Upload assets |

---

## Gist

| Command | Description |
|---------|-------------|
| `gh gist create` | Create gist |
| `gh gist list` | List gists |
| `gh gist view <id>` | View gist |
| `gh gist edit <id>` | Edit gist |
| `gh gist delete <id>` | Delete gist |

---

## Labels

| Command | Description |
|---------|-------------|
| `gh label list` | List labels |
| `gh label create <name>` | Create label |
| `gh label delete <name>` | Delete label |
| `gh label edit <name>` | Edit label |

---

## API

| Command | Description |
|---------|-------------|
| `gh api <endpoint>` | Call GitHub API |
| `gh api graphql` | GraphQL query |

---

## Config

| Command | Description |
|---------|-------------|
| `gh config set <key> <val>` | Set config |
| `gh config get <key>` | Get config value |
| `gh alias set <alias> <cmd>` | Create alias |
| `gh alias list` | List aliases |

---

## Common Flags

| Flag | Description |
|------|-------------|
| `-R, --repo` | Specify repository |
| `-w, --web` | Open in browser |
| `--json` | JSON output |
| `-q, --jq` | Filter JSON with jq |
| `-t, --template` | Format with Go template |
