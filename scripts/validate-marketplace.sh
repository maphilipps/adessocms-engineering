#!/bin/bash

#################################################################################
# Marketplace Plugin Registration Validator
#
# Purpose: Verify that all plugin directories are registered in marketplace.json
#          and that all registered entries have corresponding directories.
#
# Usage:   ./scripts/validate-marketplace.sh
#
# Returns: 0 if all validations pass
#          1 if any validation fails
#################################################################################

set -e

MARKETPLACE_FILE="./.claude-plugin/marketplace.json"
PLUGINS_DIR="./plugins"
ERRORS=0
WARNINGS=0

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if running from repo root
if [[ ! -f "$MARKETPLACE_FILE" ]]; then
  echo -e "${RED}ERROR: marketplace.json not found at $MARKETPLACE_FILE${NC}"
  echo "Please run this script from the marketplace repository root."
  exit 1
fi

echo -e "${BLUE}Validating marketplace plugin registration...${NC}"
echo "=================================================="

# Validate marketplace.json is valid JSON
echo -e "${BLUE}Checking marketplace.json syntax...${NC}"
if ! jq empty "$MARKETPLACE_FILE" 2>/dev/null; then
  echo -e "${RED}ERROR: marketplace.json is not valid JSON${NC}"
  exit 1
fi
echo -e "${GREEN}✓ marketplace.json is valid JSON${NC}"
echo

# Get all registered plugin names from marketplace.json
REGISTERED_PLUGINS=$(jq -r '.plugins[]?.name // empty' "$MARKETPLACE_FILE" 2>/dev/null | sort)

if [[ -z "$REGISTERED_PLUGINS" ]]; then
  echo -e "${YELLOW}WARNING: No plugins found in marketplace.json${NC}"
fi

# Get all actual plugin directories
if [[ ! -d "$PLUGINS_DIR" ]]; then
  echo -e "${YELLOW}WARNING: No plugins directory found at $PLUGINS_DIR${NC}"
  ACTUAL_PLUGINS=""
else
  ACTUAL_PLUGINS=$(find "$PLUGINS_DIR" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; 2>/dev/null | sort)
fi

echo -e "${BLUE}Registered plugins in marketplace.json:${NC}"
if [[ -z "$REGISTERED_PLUGINS" ]]; then
  echo "  (none)"
else
  echo "$REGISTERED_PLUGINS" | sed 's/^/  - /'
fi
echo

echo -e "${BLUE}Actual plugin directories:${NC}"
if [[ -z "$ACTUAL_PLUGINS" ]]; then
  echo "  (none)"
else
  echo "$ACTUAL_PLUGINS" | sed 's/^/  - /'
fi
echo

# Check for unregistered plugins (directories without marketplace.json entry)
echo -e "${BLUE}Checking for unregistered plugins...${NC}"
UNREGISTERED_COUNT=0
for plugin_dir in $ACTUAL_PLUGINS; do
  if ! echo "$REGISTERED_PLUGINS" | grep -q "^${plugin_dir}$"; then
    echo -e "${RED}  ✗ UNREGISTERED: $plugin_dir${NC}"
    echo "    Location: $PLUGINS_DIR/$plugin_dir"
    echo "    Action: Add entry to marketplace.json"
    ((ERRORS++))
    ((UNREGISTERED_COUNT++))
  else
    echo -e "${GREEN}  ✓ $plugin_dir${NC}"
  fi
done

if [[ $UNREGISTERED_COUNT -eq 0 && -n "$ACTUAL_PLUGINS" ]]; then
  echo -e "${GREEN}All plugin directories are registered!${NC}"
fi
echo

# Check for orphaned entries (marketplace.json entries without directories)
echo -e "${BLUE}Checking for orphaned marketplace entries...${NC}"
ORPHANED_COUNT=0
for plugin_name in $REGISTERED_PLUGINS; do
  if [[ ! -d "$PLUGINS_DIR/$plugin_name" ]]; then
    echo -e "${RED}  ✗ ORPHANED: $plugin_name${NC}"
    echo "    Action: Remove from marketplace.json or create plugin directory"
    ((ERRORS++))
    ((ORPHANED_COUNT++))
  fi
done

if [[ $ORPHANED_COUNT -eq 0 && -n "$REGISTERED_PLUGINS" ]]; then
  echo -e "${GREEN}No orphaned entries found!${NC}"
fi
echo

# Validate each registered plugin has required files
echo -e "${BLUE}Validating plugin metadata files...${NC}"
for plugin_name in $REGISTERED_PLUGINS; do
  plugin_path="$PLUGINS_DIR/$plugin_name"
  plugin_json="$plugin_path/.claude-plugin/plugin.json"
  readme="$plugin_path/README.md"

  # Check plugin.json exists
  if [[ ! -f "$plugin_json" ]]; then
    echo -e "${RED}  ✗ $plugin_name: Missing .claude-plugin/plugin.json${NC}"
    ((ERRORS++))
    continue
  fi

  # Validate plugin.json is valid JSON
  if ! jq empty "$plugin_json" 2>/dev/null; then
    echo -e "${RED}  ✗ $plugin_name: plugin.json is not valid JSON${NC}"
    ((ERRORS++))
    continue
  fi

  # Verify name consistency
  json_name=$(jq -r '.name // empty' "$plugin_json" 2>/dev/null)
  if [[ -z "$json_name" ]]; then
    echo -e "${RED}  ✗ $plugin_name: Missing 'name' field in plugin.json${NC}"
    ((ERRORS++))
    continue
  fi

  if [[ "$json_name" != "$plugin_name" ]]; then
    echo -e "${RED}  ✗ $plugin_name: Name mismatch${NC}"
    echo "    Directory name: $plugin_name"
    echo "    plugin.json 'name': $json_name"
    ((ERRORS++))
    continue
  fi

  # Verify required fields in plugin.json
  required_fields=("name" "version" "description")
  for field in "${required_fields[@]}"; do
    field_value=$(jq -r ".${field} // empty" "$plugin_json" 2>/dev/null)
    if [[ -z "$field_value" ]]; then
      echo -e "${YELLOW}  ⚠ $plugin_name: Missing '${field}' in plugin.json${NC}"
      ((WARNINGS++))
    fi
  done

  # Check README.md exists
  if [[ ! -f "$readme" ]]; then
    echo -e "${YELLOW}  ⚠ $plugin_name: Missing README.md (recommended)${NC}"
    ((WARNINGS++))
  else
    echo -e "${GREEN}  ✓ $plugin_name (complete)${NC}"
  fi
done

if [[ -z "$REGISTERED_PLUGINS" ]]; then
  echo "  (no plugins to validate)"
fi
echo

# Validate marketplace.json structure
echo -e "${BLUE}Validating marketplace.json structure...${NC}"
marketplace_name=$(jq -r '.name // empty' "$MARKETPLACE_FILE" 2>/dev/null)
marketplace_version=$(jq -r '.metadata.version // empty' "$MARKETPLACE_FILE" 2>/dev/null)

if [[ -z "$marketplace_name" ]]; then
  echo -e "${YELLOW}  ⚠ Missing 'name' field in marketplace.json${NC}"
  ((WARNINGS++))
else
  echo -e "${GREEN}  ✓ Marketplace name: $marketplace_name${NC}"
fi

if [[ -z "$marketplace_version" ]]; then
  echo -e "${YELLOW}  ⚠ Missing 'metadata.version' in marketplace.json${NC}"
  ((WARNINGS++))
else
  echo -e "${GREEN}  ✓ Marketplace version: $marketplace_version${NC}"
fi
echo

# Check for duplicate plugin names in marketplace.json
echo -e "${BLUE}Checking for duplicate plugin names...${NC}"
duplicates=$(jq -r '.plugins[]?.name // empty' "$MARKETPLACE_FILE" 2>/dev/null | sort | uniq -d)
if [[ -n "$duplicates" ]]; then
  echo -e "${RED}  ✗ Duplicate plugin names found:${NC}"
  echo "$duplicates" | sed 's/^/    - /'
  ((ERRORS++))
else
  echo -e "${GREEN}  ✓ No duplicate plugin names${NC}"
fi
echo

# Summary
echo "=================================================="
echo

if [[ $ERRORS -eq 0 && $WARNINGS -eq 0 ]]; then
  echo -e "${GREEN}✓ All validations passed!${NC}"
  echo "  The marketplace is properly configured."
  exit 0
elif [[ $ERRORS -eq 0 ]]; then
  echo -e "${YELLOW}⚠ Validations passed with $WARNINGS warning(s)${NC}"
  echo "  These are non-critical but recommended to fix."
  exit 0
else
  echo -e "${RED}✗ Validations failed with $ERRORS error(s)${NC}"
  if [[ $WARNINGS -gt 0 ]]; then
    echo -e "${YELLOW}  Plus $WARNINGS warning(s)${NC}"
  fi
  echo
  echo "To fix:"
  echo "  1. Ensure all plugins in /plugins are registered in marketplace.json"
  echo "  2. Ensure all marketplace.json entries have corresponding directories"
  echo "  3. Verify plugin.json files are present and valid"
  echo "  4. Verify plugin names are consistent across files"
  echo "  5. Run: ./scripts/validate-marketplace.sh again"
  echo
  exit 1
fi
