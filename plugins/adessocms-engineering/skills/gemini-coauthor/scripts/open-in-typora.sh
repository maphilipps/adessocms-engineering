#!/bin/bash
# Open a markdown file in Typora if available, otherwise use default app

FILE_PATH="$1"

if [ -z "$FILE_PATH" ]; then
  echo "Usage: open-in-typora.sh <file_path>"
  exit 1
fi

if [ ! -f "$FILE_PATH" ]; then
  echo "Error: File not found: $FILE_PATH"
  exit 1
fi

# Check if Typora is available
if [ -d "/Applications/Typora.app" ]; then
  echo "Opening in Typora: $FILE_PATH"
  open -a Typora "$FILE_PATH"
else
  echo "Typora not available, opening with default app: $FILE_PATH"
  open "$FILE_PATH"
fi
