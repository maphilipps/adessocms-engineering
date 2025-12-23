#!/bin/bash
# Prevent Mac from sleeping during Claude Code sessions
# Uses caffeinate with 1-hour timeout, auto-renews on each prompt

PID_FILE="/tmp/claude-caffeinate.pid"

# Kill existing caffeinate if running
if [ -f "$PID_FILE" ]; then
    kill $(cat "$PID_FILE") 2>/dev/null
    rm -f "$PID_FILE"
fi

# Start new caffeinate with 1-hour timeout
# -d: prevent display sleep
# -i: prevent idle sleep
# -s: prevent system sleep (on AC power)
caffeinate -dis -t 3600 &
echo $! > "$PID_FILE"

# Return success for hook
echo '{"continue": true}'
