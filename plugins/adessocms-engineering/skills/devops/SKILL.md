---
name: devops
description: |
  DDEV local development, Composer dependency management, Docker/Podman, CI/CD pipelines.
  Automatically invoked when feature.skill = "devops" in Ralph Loop.
---

<essential_principles>
## DevOps for adesso CMS

### 1. DDEV-First

All local development uses DDEV:

```bash
ddev start              # Start environment
ddev stop               # Stop environment
ddev restart            # Restart
ddev ssh                # Shell access
ddev exec <command>     # Run command
ddev drush <command>    # Drush shortcut
ddev composer <command> # Composer shortcut
```

### 2. Git Outside DDEV

**CRITICAL: Git operations run on host, not in container:**

```bash
# OUTSIDE DDEV
git add .
git commit -m "message"
git push

# INSIDE DDEV - everything else
ddev ssh
composer install
drush cr
```

### 3. Composer Best Practices

- Use `^` for semver constraints
- Lock file always committed
- `--with-all-dependencies` for updates

### 4. Environment Parity

Dev/Staging/Prod should be as similar as possible:
- Same PHP version
- Same database version
- Same webserver configuration
</essential_principles>

<intake>
**What would you like to do?**

1. Set up DDEV for a project
2. Manage Composer dependencies
3. Configure Docker/services
4. Set up CI/CD pipeline
5. Debug environment issues
6. Something else

**Wait for response before proceeding.**
</intake>

<routing>
| Response | Workflow |
|----------|----------|
| 1, "ddev", "setup", "local" | `workflows/ddev-setup.md` |
| 2, "composer", "dependency", "package" | `workflows/composer-management.md` |
| 3, "docker", "service", "container" | `workflows/docker-services.md` |
| 4, "ci", "cd", "pipeline", "deploy" | `workflows/ci-cd-setup.md` |
| 5, "debug", "troubleshoot", "issue" | `workflows/debug-environment.md` |
| 6, other | Clarify, then select workflow |
</routing>

<reference_index>
## References

All in `references/`:

- ddev-commands.md - Complete DDEV command reference
- composer-patterns.md - Dependency management patterns
- docker-services.md - Additional services configuration
- environment-setup.md - Environment configuration
</reference_index>

<workflows_index>
## Workflows

| File | Purpose |
|------|---------|
| ddev-setup.md | Initialize/configure DDEV |
| composer-management.md | Dependency management |
| docker-services.md | Additional services (Redis, Solr, etc.) |
| ci-cd-setup.md | Pipeline configuration |
| debug-environment.md | Troubleshooting |
</workflows_index>
