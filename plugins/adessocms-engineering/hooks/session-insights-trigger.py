#!/usr/bin/env python3
"""SessionEnd hook that triggers session-insights agent to generate analytics.

Runs at session end to create insights report in docs/insights/
"""

import json
import sys
from datetime import datetime


def main():
    """Main entry point for session insights trigger hook."""
    try:
        input_data = json.load(sys.stdin)

        event = input_data.get('hook_event_name', '')
        reason = input_data.get('reason', 'unknown')

        # Only trigger on actual session end, not on interrupts
        if event == 'SessionEnd' and reason in ['clear', 'logout', 'prompt_input_exit', 'other']:
            timestamp = datetime.now().strftime('%Y-%m-%d %H:%M')
            result = {
                "continue": True,
                "systemMessage": (
                    f"Session ending ({reason}). "
                    "Spawn session-insights agent to generate session analytics report. "
                    "Use: Task tool with subagent_type='adessocms-engineering:session-insights', "
                    "run_in_background=false, model='haiku'. "
                    f"Write report to docs/insights/session-{datetime.now().strftime('%Y-%m-%d-%H%M')}.md"
                )
            }
            print(json.dumps(result), file=sys.stdout)
        else:
            print(json.dumps({"continue": True}), file=sys.stdout)

    except Exception as e:
        print(json.dumps({"continue": True}), file=sys.stdout)

    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
