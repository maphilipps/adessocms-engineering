# DDEV Commands Reference

## Lifecycle

| Command | Description |
|---------|-------------|
| `ddev start` | Start containers |
| `ddev stop` | Stop containers |
| `ddev restart` | Restart containers |
| `ddev poweroff` | Stop all DDEV projects |
| `ddev delete` | Delete project (keeps files) |
| `ddev delete --omit-snapshot` | Delete without snapshot |

---

## Project Info

| Command | Description |
|---------|-------------|
| `ddev describe` | Show project info |
| `ddev list` | List all projects |
| `ddev status` | Quick status |

---

## Execution

| Command | Description |
|---------|-------------|
| `ddev exec <cmd>` | Run command in web container |
| `ddev ssh` | SSH into web container |
| `ddev ssh -d` | SSH into db container |
| `ddev drush <cmd>` | Run Drush command |
| `ddev composer <cmd>` | Run Composer |
| `ddev npm <cmd>` | Run npm |
| `ddev yarn <cmd>` | Run yarn |

---

## Database

| Command | Description |
|---------|-------------|
| `ddev mysql` | MySQL CLI |
| `ddev export-db` | Export database |
| `ddev export-db --file=dump.sql.gz` | Export to file |
| `ddev import-db` | Import database (interactive) |
| `ddev import-db --file=dump.sql.gz` | Import from file |

---

## Files

| Command | Description |
|---------|-------------|
| `ddev import-files --source=files.tar.gz` | Import files |
| `ddev export-files` | Export files directory |

---

## URLs & Services

| Command | Description |
|---------|-------------|
| `ddev launch` | Open site in browser |
| `ddev launch -m` | Open Mailhog |
| `ddev launch -p` | Open phpMyAdmin |

---

## Debugging

| Command | Description |
|---------|-------------|
| `ddev xdebug on` | Enable Xdebug |
| `ddev xdebug off` | Disable Xdebug |
| `ddev xdebug status` | Check Xdebug status |
| `ddev logs` | Show logs |
| `ddev logs -f` | Follow logs |
| `ddev logs --all` | All container logs |

---

## Configuration

| Command | Description |
|---------|-------------|
| `ddev config` | Configure project |
| `ddev config --project-type=drupal` | Set project type |
| `ddev config --php-version=8.3` | Set PHP version |
| `ddev config --docroot=web` | Set docroot |

---

## Add-ons

| Command | Description |
|---------|-------------|
| `ddev get --list` | List available add-ons |
| `ddev get ddev/ddev-redis` | Install Redis |
| `ddev get ddev/ddev-solr` | Install Solr |

---

## Mutagen (macOS)

| Command | Description |
|---------|-------------|
| `ddev mutagen status` | Mutagen sync status |
| `ddev mutagen reset` | Reset Mutagen |
| `ddev mutagen sync` | Force sync |

---

## Snapshots

| Command | Description |
|---------|-------------|
| `ddev snapshot` | Create snapshot |
| `ddev snapshot --name=before-update` | Named snapshot |
| `ddev snapshot restore` | Restore latest |
| `ddev snapshot restore --name=before-update` | Restore named |
| `ddev snapshot --list` | List snapshots |

---

## Maintenance

| Command | Description |
|---------|-------------|
| `ddev clean` | Clean up Docker resources |
| `ddev debug` | Debug information |
| `ddev debug router` | Router debug |
| `ddev version` | Show DDEV version |
| `ddev self-upgrade` | Upgrade DDEV |
