#!/bin/bash
# Post-edit validator hook: Check for quality issues after editing

# Read input JSON from stdin
input=$(cat)

# Extract file path from tool input
file_path=$(echo "$input" | jq -r '.tool_input.file_path // .tool_input.path // ""')

# If no file path, skip validation
if [ -z "$file_path" ]; then
  exit 0
fi

# ============================================
# Domain Knowledge Citation Validator
# ============================================
if [[ "$file_path" == *"domain_knowledge"* ]]; then
  # Check if file exists and validate citations
  if [ -f "$file_path" ]; then
    # Count citation markers [^n] in text
    markers=$(grep -o '\[\^[0-9]\+\]' "$file_path" 2>/dev/null | sort -u | wc -l | tr -d ' ')

    # Count citation definitions [^n]:
    definitions=$(grep -o '^\[\^[0-9]\+\]:' "$file_path" 2>/dev/null | sort -u | wc -l | tr -d ' ')

    issues=""

    # Check if any citations exist
    if [ "$markers" -eq 0 ]; then
      issues="WARNING: No citations found in domain knowledge file. All factual claims need [^n] citations."
    elif [ "$markers" -ne "$definitions" ]; then
      issues="WARNING: Citation mismatch - $markers markers but $definitions definitions. Check for orphan markers or unused references."
    fi

    # Check for uncited claims (sentences ending with period not followed by citation)
    # This is a heuristic - look for periods followed by space and capital letter without citation
    uncited=$(grep -E '\.[[:space:]]+[A-Z]' "$file_path" | grep -v '\[\^[0-9]\+\]\.' | head -3)
    if [ -n "$uncited" ]; then
      if [ -n "$issues" ]; then
        issues="$issues Also, some statements may be missing citations."
      else
        issues="NOTE: Some statements may be missing citations. Review factual claims."
      fi
    fi

    if [ -n "$issues" ]; then
      echo "{\"systemMessage\": \"$issues\"}"
      exit 0
    fi
  fi
fi

# ============================================
# Debug Statement Warning
# ============================================
if [[ "$file_path" == *.py ]] || [[ "$file_path" == *.ts ]] || [[ "$file_path" == *.js ]] || [[ "$file_path" == *.dart ]]; then
  if [ -f "$file_path" ]; then
    # Check for DEBUG: statements that might have been accidentally left
    debug_count=$(grep -c 'DEBUG:' "$file_path" 2>/dev/null || echo "0")
    if [ "$debug_count" -gt 0 ]; then
      echo "{\"systemMessage\": \"NOTE: File contains $debug_count DEBUG: statement(s). Remember to run /dev:debug clean before committing.\"}"
      exit 0
    fi
  fi
fi

# Default: success with no message
exit 0
