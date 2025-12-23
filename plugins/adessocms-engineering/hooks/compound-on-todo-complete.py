#!/usr/bin/env python3
"""PostToolUse hook that triggers compound documentation when todos are completed.

Triggers when:
- A todo is marked as "completed"
- Multiple todos are completed at once
- Todo content suggests a fix or problem resolution
"""

import json
import re
import sys


# Keywords in todo content that suggest documentation-worthy work
DOCUMENTATION_KEYWORDS = [
    r'fix',
    r'bug',
    r'error',
    r'issue',
    r'resolve',
    r'patch',
    r'anti[- ]?pattern',
    r'refactor',
    r'performance',
    r'security',
    r'cache',
    r'deprecat',
    r'migration',
    r'upgrade',
    r'debug',
]


def count_completed_todos(todos: list) -> int:
    """Count how many todos are marked as completed."""
    return sum(1 for todo in todos if todo.get('status') == 'completed')


def get_completed_todo_names(todos: list) -> list:
    """Get names of completed todos."""
    return [todo.get('content', 'Unknown') for todo in todos if todo.get('status') == 'completed']


def has_documentation_keyword(todos: list) -> bool:
    """Check if any completed todo contains documentation-worthy keywords."""
    completed = [todo.get('content', '').lower() for todo in todos if todo.get('status') == 'completed']
    for content in completed:
        if any(re.search(pattern, content, re.IGNORECASE) for pattern in DOCUMENTATION_KEYWORDS):
            return True
    return False


def main():
    """Main entry point for PostToolUse hook on TodoWrite."""
    try:
        # Read input from stdin
        input_data = json.load(sys.stdin)

        # Extract tool input (the todos being written)
        tool_input = input_data.get('tool_input', {})
        todos = tool_input.get('todos', [])

        # Count completed todos
        completed_count = count_completed_todos(todos)

        # Only trigger if there are completed todos
        if completed_count > 0:
            completed_names = get_completed_todo_names(todos)

            # Check if keywords suggest documentation-worthy work
            if has_documentation_keyword(todos):
                result = {
                    "systemMessage": (
                        f"Todo(s) completed: {', '.join(completed_names[:3])}{'...' if len(completed_names) > 3 else ''}. "
                        "Keywords suggest this involved fixing an issue or addressing an anti-pattern. "
                        "Consider documenting with /acms-compound or spawn compound-documenter agent. "
                        "Use: Task tool with subagent_type='adessocms-engineering:compound-documenter', "
                        "run_in_background=true, model='haiku'. Skip if routine work."
                    )
                }
                print(json.dumps(result), file=sys.stdout)
                sys.exit(0)

            # For todos without specific keywords, still offer gentle reminder
            if completed_count >= 2:
                result = {
                    "systemMessage": (
                        f"Multiple todos completed: {', '.join(completed_names[:3])}{'...' if len(completed_names) > 3 else ''}. "
                        "If this work involved learnings worth documenting, consider using /acms-compound. "
                        "Skip if routine work."
                    )
                }
                print(json.dumps(result), file=sys.stdout)
                sys.exit(0)

        # No completed todos or not documentation-worthy, return empty
        print(json.dumps({}), file=sys.stdout)

    except Exception as e:
        # On error, continue without blocking
        print(json.dumps({}), file=sys.stdout)

    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
