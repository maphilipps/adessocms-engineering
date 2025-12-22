#!/usr/bin/env python3
"""PostToolUse hook that triggers compound documentation when todos are completed.

Triggers when:
- A todo is marked as "completed"
- Multiple todos are completed at once
"""

import json
import sys


def count_completed_todos(todos: list) -> int:
    """Count how many todos are marked as completed."""
    return sum(1 for todo in todos if todo.get('status') == 'completed')


def get_completed_todo_names(todos: list) -> list:
    """Get names of completed todos."""
    return [todo.get('content', 'Unknown') for todo in todos if todo.get('status') == 'completed']


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

            result = {
                "systemMessage": (
                    f"Todo(s) completed: {', '.join(completed_names[:3])}{'...' if len(completed_names) > 3 else ''}. "
                    "If solving these todos involved learning something non-trivial, "
                    "spawn compound-documenter agent in background. "
                    "Use: Task tool with subagent_type='bd-app-engineering:compound-documenter', "
                    "run_in_background=true, model='haiku'. Skip if routine work."
                )
            }
            print(json.dumps(result), file=sys.stdout)
            sys.exit(0)

        # No completed todos, return empty
        print(json.dumps({}), file=sys.stdout)

    except Exception as e:
        # On error, continue without blocking
        print(json.dumps({}), file=sys.stdout)

    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
