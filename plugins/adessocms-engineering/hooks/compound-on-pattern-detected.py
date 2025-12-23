#!/usr/bin/env python3
"""PostResponse hook that triggers compound documentation when anti-patterns are discussed.

Triggers when Claude's response contains:
- Anti-pattern terminology
- Violation mentions
- Problem-solution discussions
- Learning moments
"""

import json
import re
import sys


# Patterns in Claude's response that suggest documentation opportunity
PATTERN_TRIGGERS = [
    # Anti-pattern and violation mentions
    r'anti[- ]?pattern',
    r'violation',
    r'best\s+practice',
    r'bad\s+practice',
    r'code\s+smell',
    r'technical\s+debt',
    # Drupal-specific anti-patterns
    r'N\+1\s+query',
    r'missing\s+cache\s+tag',
    r'uncached\s+render',
    r'hook.*deprecated',
    r'should\s+use.*instead',
    r'avoid\s+using',
    r'do\s+not\s+use',
    # Problem-solution language
    r'the\s+issue\s+was',
    r'root\s+cause',
    r'this\s+fixed',
    r'the\s+solution\s+is',
    r'that\s+resolved',
    r'now\s+working',
    # adesso styleguide violations
    r'styleguide\s+violation',
    r'brand\s+violation',
    r'adesso[- ]?blau',
    r'fa[- ]?thin',
    r'klavika',
]

# Exclusion patterns to avoid false positives
EXCLUSION_PATTERNS = [
    r'documentation\s+already',
    r'documented\s+in',
    r'see\s+docs/',
    r'/acms-compound',  # Already suggesting documentation
    r'compound-documenter',  # Already invoking
]


def should_trigger(response_text: str) -> tuple[bool, list]:
    """Check if response contains patterns worth documenting."""
    response_lower = response_text.lower()

    # Check exclusions first
    for pattern in EXCLUSION_PATTERNS:
        if re.search(pattern, response_lower):
            return False, []

    # Find matching patterns
    matched_patterns = []
    for pattern in PATTERN_TRIGGERS:
        if re.search(pattern, response_lower):
            matched_patterns.append(pattern)

    # Need at least 2 matches to be confident this is documentation-worthy
    return len(matched_patterns) >= 2, matched_patterns


def main():
    """Main entry point for PostResponse hook."""
    try:
        # Read input from stdin
        input_data = json.load(sys.stdin)

        # Get response content
        response = input_data.get('response', '')
        response_text = str(response)

        # Check if this response warrants documentation
        should_doc, patterns = should_trigger(response_text)

        if should_doc:
            result = {
                "systemMessage": (
                    "Anti-patterns or problem-solution discussion detected in this response. "
                    "Consider documenting with /acms-compound if a notable learning emerged. "
                    f"Detected patterns: {', '.join(patterns[:3])}. "
                    "Skip if already documented or if routine discussion."
                )
            }
            print(json.dumps(result), file=sys.stdout)
            sys.exit(0)

        # No patterns detected, return empty
        print(json.dumps({}), file=sys.stdout)

    except Exception as e:
        # On error, continue without blocking
        print(json.dumps({}), file=sys.stdout)

    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
