#!/bin/bash
# Send a prompt to Gemini CLI and get response
# Uses yolo mode (-y) for autonomous operation

PROMPT="$1"
TIMEOUT="${2:-120}"  # Default 2 minute timeout

if [ -z "$PROMPT" ]; then
  echo "Usage: ask-gemini.sh <prompt> [timeout_seconds]"
  echo ""
  echo "Options:"
  echo "  prompt          The prompt to send to Gemini"
  echo "  timeout_seconds Timeout in seconds (default: 120)"
  exit 1
fi

# Check if Gemini is available
if ! which gemini >/dev/null 2>&1; then
  echo "SKIP: Gemini CLI not available"
  exit 0
fi

# Run Gemini with yolo mode and timeout
echo "Sending to Gemini (timeout: ${TIMEOUT}s)..."
timeout "$TIMEOUT" gemini -y "$PROMPT"
EXIT_CODE=$?

if [ $EXIT_CODE -eq 124 ]; then
  echo ""
  echo "WARNING: Gemini request timed out after ${TIMEOUT}s"
  echo "Continuing without Gemini response..."
  exit 0
elif [ $EXIT_CODE -ne 0 ]; then
  echo ""
  echo "WARNING: Gemini returned error code $EXIT_CODE"
  echo "Continuing without Gemini response..."
  exit 0
fi
