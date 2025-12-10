#!/bin/bash
# Check if Gemini CLI is available and return status

check_gemini() {
  if which gemini >/dev/null 2>&1; then
    echo "available"
    return 0
  else
    echo "unavailable"
    return 1
  fi
}

# If run directly, show detailed status
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  echo "=== Gemini CLI Status ==="

  if which gemini >/dev/null 2>&1; then
    echo "Status: AVAILABLE"
    echo "Path: $(which gemini)"
    echo "Version: $(gemini --version 2>/dev/null || echo 'unknown')"
  else
    echo "Status: NOT AVAILABLE"
    echo ""
    echo "To install Gemini CLI:"
    echo "  npm install -g @google/generative-ai-cli"
    echo "  # or"
    echo "  pip install google-generativeai"
  fi

  echo ""
  echo "=== Typora Status ==="
  if [ -d "/Applications/Typora.app" ]; then
    echo "Status: AVAILABLE"
    echo "Path: /Applications/Typora.app"
  else
    echo "Status: NOT AVAILABLE"
    echo "Download: https://typora.io/"
  fi
fi
