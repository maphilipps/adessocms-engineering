# glab Commands Reference

## Authentication

| Command | Description |
|---------|-------------|
| `glab auth login` | Login to GitLab |
| `glab auth status` | Check auth status |
| `glab config set -g token <PAT>` | Set Personal Access Token |

---

## Merge Requests

| Command | Description |
|---------|-------------|
| `glab mr create` | Create MR |
| `glab mr create -i` | Interactive create |
| `glab mr list` | List MRs |
| `glab mr view <id>` | View MR details |
| `glab mr view --web` | Open in browser |
| `glab mr checkout <id>` | Checkout MR branch |
| `glab mr merge <id>` | Merge MR |
| `glab mr close <id>` | Close MR |
| `glab mr reopen <id>` | Reopen MR |
| `glab mr approve <id>` | Approve MR |
| `glab mr revoke <id>` | Revoke approval |
| `glab mr diff <id>` | Show diff |
| `glab mr note <id>` | Add comment |

---

## CI/CD Pipelines

| Command | Description |
|---------|-------------|
| `glab ci status` | Pipeline status |
| `glab ci view` | Detailed view |
| `glab ci list` | List pipelines |
| `glab ci trace <job>` | Job logs |
| `glab ci retry` | Retry pipeline |
| `glab ci cancel` | Cancel pipeline |
| `glab ci run <job>` | Run manual job |
| `glab ci lint` | Validate .gitlab-ci.yml |
| `glab ci artifact download <job>` | Download artifacts |
| `glab ci trigger` | Trigger pipeline |

---

## Issues

| Command | Description |
|---------|-------------|
| `glab issue create` | Create issue |
| `glab issue list` | List issues |
| `glab issue view <id>` | View issue |
| `glab issue close <id>` | Close issue |
| `glab issue reopen <id>` | Reopen issue |
| `glab issue update <id>` | Update issue |
| `glab issue note <id>` | Add comment |

---

## Repository

| Command | Description |
|---------|-------------|
| `glab repo clone <repo>` | Clone repository |
| `glab repo view` | View repo info |
| `glab repo fork` | Fork repository |

---

## Project

| Command | Description |
|---------|-------------|
| `glab project list` | List projects |
| `glab project view` | View project |
| `glab project search <query>` | Search projects |

---

## Labels

| Command | Description |
|---------|-------------|
| `glab label list` | List labels |
| `glab label create <name>` | Create label |

---

## Milestones

| Command | Description |
|---------|-------------|
| `glab milestone list` | List milestones |
| `glab milestone create` | Create milestone |

---

## Release

| Command | Description |
|---------|-------------|
| `glab release list` | List releases |
| `glab release create <tag>` | Create release |
| `glab release view <tag>` | View release |

---

## Config

| Command | Description |
|---------|-------------|
| `glab config set <key> <value>` | Set config |
| `glab config get <key>` | Get config value |
| `glab alias set <alias> <command>` | Create alias |

---

## Common Flags

| Flag | Description |
|------|-------------|
| `-R, --repo` | Specify repository |
| `-g, --group` | Specify group |
| `-w, --web` | Open in browser |
| `-F, --output` | Output format (json, text) |
