#!/usr/bin/env python3
"""UserPromptSubmit hook that suggests prompt optimization for complex prompts.

Only triggers for prompts that could benefit from optimization:
- Long prompts (>100 chars)
- Vague language detected
- Missing structure indicators
"""

import json
import re
import sys


# Indicators of prompts that need optimization
VAGUE_PATTERNS = [
    r'\bmach\s*(mal|das|es)\b',  # "mach mal", "mach das"
    r'\bfix\s*(this|it|das)\b',
    r'\bmake\s*it\s*(better|good|nice)\b',
    r'\bverbessere?\b',
    r'\birgendwie\b',
    r'\beinfach\s+mal\b',
    r'\bschnell\s+mal\b',
    r'\bkannst\s+du\s*\?\s*$',  # ends with "kannst du?"
    r'\bhelp\s+me\s+with\b',
]

# Indicators of already well-structured prompts (skip optimization)
STRUCTURED_PATTERNS = [
    r'<context>',
    r'<task>',
    r'<requirements>',
    r'^##\s+',  # Markdown headers
    r'^\d+\.\s+',  # Numbered lists
    r'^-\s+',  # Bullet lists
]

# Minimum length to consider for optimization
MIN_LENGTH_FOR_OPTIMIZATION = 50


def should_optimize(prompt: str) -> tuple[bool, str]:
    """Determine if a prompt would benefit from optimization."""

    # Skip very short prompts
    if len(prompt) < MIN_LENGTH_FOR_OPTIMIZATION:
        return False, "too_short"

    # Skip already well-structured prompts
    for pattern in STRUCTURED_PATTERNS:
        if re.search(pattern, prompt, re.MULTILINE | re.IGNORECASE):
            return False, "already_structured"

    # Check for vague language
    prompt_lower = prompt.lower()
    for pattern in VAGUE_PATTERNS:
        if re.search(pattern, prompt_lower):
            return True, "vague_language"

    # Long prompts without structure might benefit
    if len(prompt) > 200 and not any(c in prompt for c in [':', '-', '•', '1.', '2.']):
        return True, "long_unstructured"

    return False, "looks_good"


def main():
    """Main entry point for prompt optimizer trigger hook."""
    try:
        input_data = json.load(sys.stdin)

        prompt = input_data.get('prompt', '')

        should_opt, reason = should_optimize(prompt)

        if should_opt:
            result = {
                "continue": True,
                "systemMessage": (
                    f"User prompt could benefit from optimization ({reason}). "
                    "Consider spawning prompt-optimizer agent in background to suggest improvements. "
                    "Use: Task tool with subagent_type='adessocms-engineering:prompt-optimizer', "
                    "run_in_background=true, model='haiku'. "
                    "Pass the original prompt for analysis."
                )
            }
            print(json.dumps(result), file=sys.stdout)
        else:
            print(json.dumps({"continue": True}), file=sys.stdout)

    except Exception as e:
        # On error, just continue without blocking
        print(json.dumps({"continue": True}), file=sys.stdout)

    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
