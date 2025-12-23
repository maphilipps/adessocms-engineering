#!/usr/bin/env python3
"""PostToolUse hook that triggers compound documentation on milestone commands.

Triggers on Drupal/adesso CMS specific milestones:
- DDEV commands (ddev drush, ddev composer, ddev exec)
- Git commits (completed work unit)
- Drupal cache rebuilds (drush cr/cache:rebuild)
- Test runs (phpunit, pest, phpstan, phpcs)
- Build processes (npm run build, composer install)
- Config exports (drush cex)
"""

import json
import re
import sys


# Patterns that indicate a milestone worth documenting
MILESTONE_PATTERNS = [
    # Git commits
    r'git\s+commit',
    # DDEV commands
    r'ddev\s+drush',
    r'ddev\s+composer',
    r'ddev\s+exec',
    # Drupal cache rebuild (indicates fix verification)
    r'drush\s+(cr|cache[:-]rebuild)',
    r'drush\s+cache:rebuild',
    # Test runs
    r'phpunit',
    r'pest',
    r'phpstan',
    r'phpcs',
    r'ddev\s+.*test',
    r'npm\s+(run\s+)?test',
    # Build processes
    r'npm\s+run\s+build',
    r'npm\s+run\s+storybook',
    r'composer\s+install',
    r'ddev\s+composer\s+install',
    # Config management
    r'drush\s+cex',
    r'drush\s+config:export',
]

# Patterns in output that suggest success after problem
SUCCESS_INDICATORS = [
    r'OK\s+\(\d+\s+test',
    r'Tests:\s+\d+\s+passed',
    r'\[\d+m\s*\d+\s+passed',
    r'PHPStan.*OK',
    r'No errors',
    r'Successfully',
    r'Build successful',
    r'Cache rebuild complete',
    r'Configuration exported',
    r'✓',
    r'\[OK\]',
    r'PASS',
]

# Drupal-specific anti-pattern indicators in output
ANTIPATTERN_INDICATORS = [
    r'deprecated',
    r'N\+1\s+query',
    r'memory.*exceeded',
    r'max_execution_time',
    r'cache\s+miss',
    r'uncached\s+render',
    r'missing.*cache.*tag',
    r'circular\s+dependency',
]


def is_milestone_command(command: str) -> bool:
    """Check if the command is a milestone command."""
    command_lower = command.lower()
    return any(re.search(pattern, command_lower) for pattern in MILESTONE_PATTERNS)


def has_success_indicator(output: str) -> bool:
    """Check if output indicates success (especially after fixing something)."""
    return any(re.search(pattern, output, re.IGNORECASE) for pattern in SUCCESS_INDICATORS)


def has_antipattern_indicator(output: str) -> bool:
    """Check if output indicates anti-patterns that should be documented."""
    return any(re.search(pattern, output, re.IGNORECASE) for pattern in ANTIPATTERN_INDICATORS)


def main():
    """Main entry point for PostToolUse hook."""
    try:
        # Read input from stdin
        input_data = json.load(sys.stdin)

        # Extract tool input and output
        tool_input = input_data.get('tool_input', {})
        tool_output = input_data.get('tool_output', '')
        tool_output_str = str(tool_output)

        command = tool_input.get('command', '')

        # Check if this is a milestone command
        if is_milestone_command(command):
            # For commits, always trigger
            if re.search(r'git\s+commit', command.lower()):
                result = {
                    "systemMessage": (
                        "A git commit just completed. Consider spawning the compound-documenter agent "
                        "in background to check if this commit contains learnings worth documenting. "
                        "Use: Task tool with subagent_type='adessocms-engineering:compound-documenter', "
                        "run_in_background=true, model='haiku'. Skip if routine work."
                    )
                }
                print(json.dumps(result), file=sys.stdout)
                sys.exit(0)

            # For config exports, trigger documentation
            if re.search(r'drush\s+(cex|config:export)', command.lower()):
                result = {
                    "systemMessage": (
                        "Drupal configuration was exported. If this involved solving a config-related issue, "
                        "consider documenting the solution with /acms-compound. "
                        "Skip if routine config export."
                    )
                }
                print(json.dumps(result), file=sys.stdout)
                sys.exit(0)

            # For tests/builds, only trigger on success
            if has_success_indicator(tool_output_str):
                result = {
                    "systemMessage": (
                        "Tests/build succeeded. If this was fixing a previous failure, "
                        "spawn compound-documenter agent in background to document the learning. "
                        "Use: Task tool with subagent_type='adessocms-engineering:compound-documenter', "
                        "run_in_background=true, model='haiku'. Skip if routine work."
                    )
                }
                print(json.dumps(result), file=sys.stdout)
                sys.exit(0)

        # Check for anti-pattern indicators regardless of command type
        if has_antipattern_indicator(tool_output_str):
            result = {
                "systemMessage": (
                    "Anti-pattern or performance issue detected in output. "
                    "This should be documented using /acms-compound once resolved. "
                    "Consider checking: N+1 queries, missing cache tags, memory issues, deprecations."
                )
            }
            print(json.dumps(result), file=sys.stdout)
            sys.exit(0)

        # No milestone detected, return empty response
        print(json.dumps({}), file=sys.stdout)

    except Exception as e:
        # On error, just continue without blocking
        print(json.dumps({}), file=sys.stdout)

    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
