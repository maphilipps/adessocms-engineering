#!/usr/bin/env python3
"""PostToolUse hook that reminds to update plugin version after commits.

Triggers after git commit commands and checks if plugin.json was updated.
If not, reminds to bump the version.
"""

import json
import sys


def main():
    """Main entry point for version reminder hook."""
    try:
        input_data = json.load(sys.stdin)

        tool_input = input_data.get('tool_input', {})
        command = tool_input.get('command', '')
        tool_result = input_data.get('tool_result', {})
        stdout = tool_result.get('stdout', '')

        # Only trigger for git commit commands that succeeded
        if 'git commit' not in command.lower():
            print(json.dumps({}), file=sys.stdout)
            return

        # Check if commit was successful
        if 'nothing to commit' in stdout or 'error' in stdout.lower():
            print(json.dumps({}), file=sys.stdout)
            return

        # Check if plugin.json was part of the commit
        if 'plugin.json' in stdout:
            # Version was likely updated
            print(json.dumps({}), file=sys.stdout)
            return

        # Remind to update version
        result = {
            "continue": True,
            "systemMessage": (
                "⚠️ **Version Reminder**: You just committed changes but plugin.json "
                "was not updated. Consider bumping the version:\n"
                "- **Patch** (x.x.1): Bug fixes\n"
                "- **Minor** (x.1.0): New features/agents\n"
                "- **Major** (1.0.0): Breaking changes\n\n"
                "Update `.claude-plugin/plugin.json` version field, then commit and push."
            )
        }

        print(json.dumps(result), file=sys.stdout)

    except Exception:
        print(json.dumps({"continue": True}), file=sys.stdout)
    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
