#!/bin/bash
# Re-enable Mac sleep after Claude Code session ends

PID_FILE="/tmp/claude-caffeinate.pid"

# Kill caffeinate process
if [ -f "$PID_FILE" ]; then
    kill $(cat "$PID_FILE") 2>/dev/null
    rm -f "$PID_FILE"
fi

# Return success for hook
echo '{"continue": true}'
