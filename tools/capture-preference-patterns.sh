#!/bin/bash
# ABOUTME: Script triggered by Claude Code PostToolUse hook to capture preference patterns

# Read JSON input from stdin (Claude Code hook format)
input=$(cat)

# Debug: log what we receive (temporary)
debug_file="/tmp/hook-debug-$$.json"
echo "$input" > "$debug_file"

# Extract relevant information from hook input
tool_name=$(echo "$input" | grep -o '"toolName":"[^"]*"' | sed 's/"toolName":"//g' | sed 's/"//g')
project_path=$(pwd)

# Check if this session shows learning patterns
check_for_patterns() {
    local input_text="$1"
    
    # Look for frustration/inefficiency indicators
    if echo "$input_text" | grep -qi "frustrating\|inefficient\|broke\|failed\|wrong approach\|wasted.*time\|took.*too.*long"; then
        return 0
    fi
    
    # Look for preference indicators  
    if echo "$input_text" | grep -qi "prefer\|like.*better\|instead.*do\|rather.*have\|better.*way"; then
        return 0
    fi
    
    # Look for avoidance patterns
    if echo "$input_text" | grep -qi "don't.*do.*that\|avoid\|never.*again\|not.*like.*that"; then
        return 0
    fi
    
    # Look for communication style feedback
    if echo "$input_text" | grep -qi "confusing\|unclear\|hard.*to.*follow\|explain.*better"; then
        return 0
    fi
    
    return 1
}

# Create journal entry with extracted patterns
log_patterns() {
    local summary="Preference learning opportunity detected:

## Session Context
- Tool: $tool_name
- Project: $project_path  
- Timestamp: $(date)

## Pattern Analysis
This session contained signals about Braydon's preferences or frustrations that could inform future interactions.

## Learning Focus
- What approaches worked vs didn't work
- Communication styles that were clear vs confusing  
- Technical choices that were efficient vs wasteful
- Workflow patterns to repeat vs avoid

This pattern recognition enables better collaboration in future sessions."

    # Try to log via journal MCP
    if command -v claude >/dev/null 2>&1; then
        # Write summary to temp file to avoid shell escaping issues
        temp_file="/tmp/claude-pattern-$$.txt"
        echo "$summary" > "$temp_file"
        
        # Use simple MCP call
        if claude --print "mcp__journal__log_agent_activity(\"preference-learning-hook\", \"$(cat "$temp_file")\", \"$project_path\")" 2>/dev/null; then
            echo "✅ Pattern logged to journal MCP"
            rm -f "$temp_file"
        else
            rm -f "$temp_file"
            log_to_file "$summary"
        fi
    else
        log_to_file "$summary"
    fi
}

# Fallback file logging
log_to_file() {
    local summary="$1"
    local log_file="$HOME/.claude-workspace/patterns/$(date +%Y-%m-%d-%H%M%S)-preferences.md"
    mkdir -p "$(dirname "$log_file")"
    echo "$summary" > "$log_file"
    echo "✅ Pattern saved to $log_file"
}

# Main execution - only log if patterns detected
if check_for_patterns "$input"; then
    log_patterns
fi

# Always exit successfully to not interfere with tool execution
exit 0