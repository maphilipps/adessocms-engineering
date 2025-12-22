#!/usr/bin/env python3
"""PostToolUse hook that triggers compound documentation on milestone commands.

Triggers on:
- git commit (completed work unit)
- test success (problem solved)
- build success after errors
"""

import json
import re
import sys


# Patterns that indicate a milestone worth documenting
MILESTONE_PATTERNS = [
    # Git commits
    r'git\s+commit',
    # Test runs
    r'artisan\s+test',
    r'phpunit',
    r'pest',
    r'npm\s+(run\s+)?test',
    # Builds
    r'npm\s+run\s+build',
    r'composer\s+install',
]

# Patterns in output that suggest success after problem
SUCCESS_INDICATORS = [
    r'Tests:\s+\d+\s+passed',
    r'OK\s+\(\d+\s+test',
    r'\[\d+m\d+\s+passed',
    r'Successfully',
    r'Build successful',
]


def is_milestone_command(command: str) -> bool:
    """Check if the command is a milestone command."""
    command_lower = command.lower()
    return any(re.search(pattern, command_lower) for pattern in MILESTONE_PATTERNS)


def has_success_indicator(output: str) -> bool:
    """Check if output indicates success (especially after fixing something)."""
    return any(re.search(pattern, output, re.IGNORECASE) for pattern in SUCCESS_INDICATORS)


def main():
    """Main entry point for PostToolUse hook."""
    try:
        # Read input from stdin
        input_data = json.load(sys.stdin)

        # Extract tool input and output
        tool_input = input_data.get('tool_input', {})
        tool_output = input_data.get('tool_output', '')

        command = tool_input.get('command', '')

        # Check if this is a milestone command
        if is_milestone_command(command):
            # For commits, always trigger
            if re.search(r'git\s+commit', command.lower()):
                result = {
                    "systemMessage": (
                        "A git commit just completed. Spawn the compound-documenter agent "
                        "in background to check if this commit contains learnings worth documenting. "
                        "Use: Task tool with subagent_type='bd-app-engineering:compound-documenter', "
                        "run_in_background=true, model='haiku'."
                    )
                }
                print(json.dumps(result), file=sys.stdout)
                sys.exit(0)

            # For tests/builds, only trigger on success
            if has_success_indicator(str(tool_output)):
                result = {
                    "systemMessage": (
                        "Tests/build succeeded. If this was fixing a previous failure, "
                        "spawn compound-documenter agent in background to document the learning. "
                        "Use: Task tool with subagent_type='bd-app-engineering:compound-documenter', "
                        "run_in_background=true, model='haiku'. Skip if this was routine work."
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
