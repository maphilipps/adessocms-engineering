#!/usr/bin/env python3
"""Context persistence hook that saves/restores session context.

Handles multiple events:
- SessionStart: Reads last-context.md and provides it as additionalContext
- PreCompact: Saves current context before it gets compressed
- Stop: Saves final context after response completes
- PostToolUse (git commit): Saves context after commits

Writes to: $PROJECT_DIR/.claude/last-context.md
"""

import json
import os
import sys
from datetime import datetime
from pathlib import Path


def get_context_file_path(cwd: str) -> Path:
    """Get the path to the last-context.md file."""
    project_dir = Path(cwd)
    claude_dir = project_dir / '.claude'
    claude_dir.mkdir(exist_ok=True)
    return claude_dir / 'last-context.md'


def read_last_context(context_file: Path) -> str:
    """Read the last context from file."""
    if context_file.exists():
        return context_file.read_text(encoding='utf-8')
    return ""


def format_context_for_save(event: str, data: dict) -> str:
    """Format context data for saving to markdown."""
    timestamp = datetime.now().strftime('%Y-%m-%d %H:%M:%S')

    content = f"""---
last_updated: {timestamp}
event: {event}
session_id: {data.get('session_id', 'unknown')}
---

# Last Session Context

**Updated:** {timestamp}
**Event:** {event}
**Working Directory:** {data.get('cwd', 'unknown')}

## What We Were Working On

<!-- This will be filled by the context-summarizer agent -->

"""
    return content


def handle_session_start(data: dict) -> dict:
    """Handle SessionStart event - restore previous context."""
    cwd = data.get('cwd', os.getcwd())
    context_file = get_context_file_path(cwd)

    last_context = read_last_context(context_file)

    if last_context:
        # SessionStart hooks use ONLY hookSpecificOutput with additionalContext
        # No "continue" or "systemMessage" needed
        return {
            "hookSpecificOutput": {
                "hookEventName": "SessionStart",
                "additionalContext": (
                    f"\n\n<previous_session_context>\n{last_context}\n</previous_session_context>\n\n"
                    "The above shows what was worked on in the previous session. "
                    "Use this context to continue seamlessly if the user's request relates to it."
                )
            }
        }

    # Return empty dict if no context to restore
    return {}


def handle_pre_compact(data: dict) -> dict:
    """Handle PreCompact event - trigger context save."""
    return {
        "continue": True,
        "systemMessage": (
            "Context is about to be compacted. "
            "Spawn context-summarizer agent to save current work context to .claude/last-context.md. "
            "Use: Task tool with subagent_type='adessocms-engineering:context-summarizer', "
            "run_in_background=true, model='haiku'. "
            "This preserves what we're working on before context compression."
        )
    }


def handle_stop(data: dict) -> dict:
    """Handle Stop event - trigger context save after response."""
    # Only trigger on significant responses (not for every tiny response)
    return {
        "continue": True,
        "systemMessage": (
            "Response complete. Consider updating .claude/last-context.md with current work context. "
            "Use context-summarizer agent (haiku, background) if significant progress was made. "
            "Skip for trivial responses."
        )
    }


def handle_session_end(data: dict) -> dict:
    """Handle SessionEnd event - final context save."""
    return {
        "continue": True,
        "systemMessage": (
            "Session ending. Spawn context-summarizer agent to save final context to .claude/last-context.md. "
            "Use: Task tool with subagent_type='adessocms-engineering:context-summarizer', "
            "run_in_background=false, model='haiku'. "
            "This ensures context is preserved for the next session."
        )
    }


def handle_post_commit(data: dict) -> dict:
    """Handle post-commit - save context with commit info."""
    tool_input = data.get('tool_input', {})
    command = tool_input.get('command', '')

    # Only trigger for git commit commands
    if 'git commit' not in command.lower():
        return {}

    return {
        "systemMessage": (
            "Git commit completed. Update .claude/last-context.md with commit context. "
            "Use context-summarizer agent (haiku, background) to document what was committed. "
            "This helps track progress across sessions."
        )
    }


def main():
    """Main entry point for context persistence hook."""
    try:
        # Read input from stdin
        input_data = json.load(sys.stdin)

        event = input_data.get('hook_event_name', '')

        if event == 'SessionStart':
            result = handle_session_start(input_data)
        elif event == 'PreCompact':
            result = handle_pre_compact(input_data)
        elif event == 'Stop':
            result = handle_stop(input_data)
        elif event == 'SessionEnd':
            result = handle_session_end(input_data)
        elif event == 'PostToolUse':
            result = handle_post_commit(input_data)
        else:
            result = {}

        print(json.dumps(result), file=sys.stdout)

    except Exception as e:
        # On error, continue without blocking
        print(json.dumps({"continue": True}), file=sys.stdout)

    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
