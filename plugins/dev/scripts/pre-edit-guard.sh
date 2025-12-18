#!/bin/bash
# Pre-edit guard hook: Remind about project conventions before editing

# Read input JSON from stdin
input=$(cat)

# Extract file path from tool input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.path // ""')

# If no file path, allow the operation
if [ -z "$file_path" ]; then
  exit 0
fi

# Get just the filename/path portion
filename=$(basename "$file_path")
dirpath=$(dirname "$file_path")

# ============================================
# Domain Knowledge Guard
# ============================================
if [[ "$file_path" == *"domain_knowledge"* ]]; then
  # Check if the content being written has citations
  content=$(echo "$input" | jq -r '.tool_input.content // ""')
  new_string=$(echo "$input" | jq -r '.tool_input.new_string // ""')

  # For Write tool, check content; for Edit tool, we just remind
  if [ -n "$content" ]; then
    # Writing a new file - check for citation markers
    if ! echo "$content" | grep -q '\[\^[0-9]\+\]'; then
      echo '{"systemMessage": "REMINDER: Domain knowledge files require citations. Every factual claim needs [^n] reference with corresponding [^n]: definition in References section."}'
      exit 0
    fi
  else
    # Editing - just remind
    echo '{"systemMessage": "REMINDER: Ensure all factual claims in domain_knowledge/ have citations [^n]."}'
    exit 0
  fi
fi

# ============================================
# TDD Style Guard
# ============================================
if [[ "$file_path" == *"test"* ]] || [[ "$filename" == test_* ]] || [[ "$filename" == *_test.* ]] || [[ "$filename" == *.test.* ]] || [[ "$filename" == *.spec.* ]]; then
  echo '{"systemMessage": "REMINDER: Before writing tests, check existing test patterns in the project. Match naming, fixtures, and assertion styles exactly."}'
  exit 0
fi

# Check for implementation files (non-test Python/JS/TS/Dart)
if [[ "$file_path" == *.py ]] || [[ "$file_path" == *.ts ]] || [[ "$file_path" == *.tsx ]] || [[ "$file_path" == *.js ]] || [[ "$file_path" == *.jsx ]] || [[ "$file_path" == *.dart ]]; then
  # Skip if it's a test file (already handled above)
  if [[ "$file_path" != *"test"* ]] && [[ "$filename" != test_* ]]; then
    echo '{"systemMessage": "REMINDER: Check CLAUDE.md and similar existing files for coding patterns before implementing."}'
    exit 0
  fi
fi

# Default: allow without message
exit 0
