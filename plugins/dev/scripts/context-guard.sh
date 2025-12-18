#!/bin/bash
# Context guard hook: Remind to check claude_code_context/ before editing

# Read input JSON from stdin
input=$(cat)

# Extract file path from tool input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.path // ""')

# If no file path, check if context folder exists and remind for Task tool
tool_name=$(echo "$input" | jq -r '.tool_name // ""')
if [ -z "$file_path" ]; then
  # For Task tool, remind about context
  if [ "$tool_name" = "Task" ] && [ -d "claude_code_context" ]; then
    echo '{"systemMessage": "CONTEXT: claude_code_context/ exists. Relevant context files may help this task."}'
  fi
  exit 0
fi

# Check if claude_code_context exists
if [ ! -d "claude_code_context" ]; then
  exit 0
fi

filename=$(basename "$file_path")

# ============================================
# Editing claude_code_context/ -> remind to update CLAUDE.md
# ============================================
if [[ "$file_path" == *"claude_code_context"* ]]; then
  echo '{"systemMessage": "CONTEXT: You are editing claude_code_context/. Remember to update CLAUDE.md if this changes how developers should use these context files."}'
  exit 0
fi

# Determine which context file is relevant
context_hint=""

# Test files -> test context
if [[ "$file_path" == *"test"* ]] || [[ "$filename" == test_* ]] || [[ "$filename" == *_test.* ]] || [[ "$filename" == *.test.* ]] || [[ "$filename" == *.spec.* ]]; then
  if [ -f "claude_code_context/test/standards.md" ]; then
    context_hint="Check claude_code_context/test/standards.md for test patterns."
  fi
# Source code files -> code context
elif [[ "$file_path" == *.py ]] || [[ "$file_path" == *.ts ]] || [[ "$file_path" == *.tsx ]] || [[ "$file_path" == *.js ]] || [[ "$file_path" == *.jsx ]] || [[ "$file_path" == *.dart ]] || [[ "$file_path" == *.go ]] || [[ "$file_path" == *.rs ]]; then
  if [ -f "claude_code_context/code/standards.md" ]; then
    context_hint="Check claude_code_context/code/standards.md for coding patterns."
  fi
fi

# Output reminder if we have a hint
if [ -n "$context_hint" ]; then
  echo "{\"systemMessage\": \"CONTEXT: $context_hint\"}"
fi

exit 0
