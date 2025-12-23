#!/usr/bin/env python3
"""PostToolUse hook that triggers various background agents based on command patterns.

Triggers:
- pattern-collector: After solutions are documented
- config-drift-detector: After Drupal entity/config operations
- test-gap-detector: After PHP file modifications
- dependency-health-monitor: After composer/npm operations
- learning-extractor: When errors are detected in output
- session-insights: At session end
"""

import json
import re
import sys


# Command patterns and their corresponding agents
AGENT_TRIGGERS = {
    # Config drift detection - Drupal config/entity operations
    'config-drift-detector': [
        r'drush\s+(en|pm:enable)',  # Module enable
        r'drush\s+config:set',
        r'drush\s+cset',
        r'entity.*create',
        r'field.*add',
    ],

    # Dependency health - Package management
    'dependency-health-monitor': [
        r'composer\s+install',
        r'composer\s+update',
        r'composer\s+require',
        r'ddev\s+composer',
        r'npm\s+install',
        r'npm\s+update',
    ],

    # Test gap detection - After code changes committed
    'test-gap-detector': [
        r'git\s+commit',
    ],

    # Pattern collector - After documentation created
    'pattern-collector': [
        r'Write.*docs/solutions/',
    ],
}

# Error patterns that trigger learning-extractor
ERROR_PATTERNS = [
    r'Exception',
    r'Error:',
    r'Fatal',
    r'Warning:',
    r'SQLSTATE',
    r'Uncaught',
    r'Stack trace:',
    r'Traceback',
]


def get_triggered_agents(command: str, output: str) -> list:
    """Determine which agents should be triggered based on command and output."""
    triggered = []
    command_lower = command.lower()

    # Check command-based triggers
    for agent, patterns in AGENT_TRIGGERS.items():
        for pattern in patterns:
            if re.search(pattern, command_lower):
                triggered.append(agent)
                break

    # Check output for errors (learning-extractor)
    for pattern in ERROR_PATTERNS:
        if re.search(pattern, output, re.IGNORECASE):
            if 'learning-extractor' not in triggered:
                triggered.append('learning-extractor')
            break

    return list(set(triggered))  # Remove duplicates


def format_agent_message(agents: list) -> str:
    """Format the system message for triggered agents."""
    if not agents:
        return ""

    messages = []

    for agent in agents:
        if agent == 'config-drift-detector':
            messages.append(
                "Drupal config/entity operation detected. "
                "Spawn config-drift-detector in background to check for uncommitted config changes. "
                f"Use: Task tool with subagent_type='adessocms-engineering:{agent}', "
                "run_in_background=true, model='haiku'."
            )
        elif agent == 'dependency-health-monitor':
            messages.append(
                "Package management operation detected. "
                "Spawn dependency-health-monitor in background to check for security issues. "
                f"Use: Task tool with subagent_type='adessocms-engineering:{agent}', "
                "run_in_background=true, model='haiku'."
            )
        elif agent == 'test-gap-detector':
            messages.append(
                "Code committed. Spawn test-gap-detector in background to check test coverage. "
                f"Use: Task tool with subagent_type='adessocms-engineering:{agent}', "
                "run_in_background=true, model='haiku'. Skip if tests were already verified."
            )
        elif agent == 'pattern-collector':
            messages.append(
                "Documentation created. Spawn pattern-collector in background to check for recurring patterns. "
                f"Use: Task tool with subagent_type='adessocms-engineering:{agent}', "
                "run_in_background=true, model='haiku'."
            )
        elif agent == 'learning-extractor':
            messages.append(
                "Error detected in output. Spawn learning-extractor in background to analyze and check existing solutions. "
                f"Use: Task tool with subagent_type='adessocms-engineering:{agent}', "
                "run_in_background=true, model='haiku'."
            )

    return " ".join(messages)


def main():
    """Main entry point for background agents trigger hook."""
    try:
        input_data = json.load(sys.stdin)

        tool_input = input_data.get('tool_input', {})
        tool_output = str(input_data.get('tool_output', ''))

        command = tool_input.get('command', '')

        # Get triggered agents
        agents = get_triggered_agents(command, tool_output)

        if agents:
            message = format_agent_message(agents)
            result = {"systemMessage": message}
            print(json.dumps(result), file=sys.stdout)
        else:
            print(json.dumps({}), file=sys.stdout)

    except Exception as e:
        print(json.dumps({}), file=sys.stdout)

    finally:
        sys.exit(0)


if __name__ == '__main__':
    main()
