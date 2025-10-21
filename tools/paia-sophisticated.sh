#!/bin/bash

# ABOUTME: Sophisticated PAIA orchestration with proper agent prompts and structured output
# ABOUTME: Uses full PAIA agent specifications from memory system

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
STATE_FILE="$HOME/.paia-state.json"
BRIEFS_FILE="$HOME/.paia-action-briefs.json"
LOG_FILE="$HOME/Library/Logs/claude-paia-sophisticated.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-sophisticated-error.log"

cd "$WORK_DIR" || exit 1

# Initialize state file
echo '{"status": "ready", "timestamp": "", "findings": 0, "actions_pending": false}' > "$STATE_FILE"

echo "$(date): Starting sophisticated PAIA orchestration..." >> "$LOG_FILE"

# Function to read status from JSON
get_status() {
    python3 -c "import json; print(json.load(open('$STATE_FILE'))['status'])" 2>/dev/null || echo "error"
}

# Function to wait for status change
wait_for_status_change() {
    local target_status="$1"
    local timeout="${2:-180}"
    local elapsed=0
    local poll_interval=10
    
    while [ $elapsed -lt $timeout ]; do
        local current_status=$(get_status)
        if [ "$current_status" = "$target_status" ]; then
            return 0
        fi
        sleep $poll_interval
        elapsed=$((elapsed + poll_interval))
        echo "$(date): Polling status '$target_status', current: '$current_status' (${elapsed}s)" >> "$LOG_FILE"
    done
    
    return 1
}

# Step 1: Sophisticated @paia-analyzer
echo "$(date): Triggering sophisticated @paia-analyzer..." >> "$LOG_FILE"

ANALYZER_PROMPT="$(cat prompts/paia-analyzer-enhanced.md)

## File Output Requirements:
You MUST write two files with structured data:

### 1. State File ($STATE_FILE):
Write JSON with this exact structure:
- If @paia instructions found: {\"status\": \"analysis_complete\", \"timestamp\": \"$(date -Iseconds)\", \"findings\": <count>, \"actions_pending\": <direct_action_count>, \"dialog_pending\": <feedback_request_count>}
- If no @paia instructions: {\"status\": \"no_work\", \"timestamp\": \"$(date -Iseconds)\", \"findings\": 0, \"actions_pending\": 0, \"dialog_pending\": 0}

### 2. Action Briefs File ($BRIEFS_FILE):
Write JSON array following the enhanced structure with execution_mode, dialog_questions, duplication_risk, and format_requirements fields.

Execute this enhanced @paia analysis now and write both structured output files."

"$CLAUDE_CMD" --print --dangerously-skip-permissions "$ANALYZER_PROMPT" >> "$LOG_FILE" 2>> "$ERROR_FILE" &

# Wait for analyzer to complete
if wait_for_status_change "analysis_complete" 300; then
    echo "$(date): Analyzer completed, triggering sophisticated @paia-updater..." >> "$LOG_FILE"
    
    # Step 2: Enhanced @paia-updater
    UPDATER_PROMPT="$(cat prompts/paia-updater-enhanced.md)

## File Processing:
1. **Read Action Briefs**: Load and process $BRIEFS_FILE with enhanced structure
2. **Quality Pre-Check**: Verify no duplications and understand target formats
3. **Execution Routing**: Handle direct actions vs dialog items appropriately

## Required Output:
Update state file ($STATE_FILE) with enhanced tracking:
{\"status\": \"complete|awaiting_feedback\", \"timestamp\": \"$(date -Iseconds)\", \"findings\": <count>, \"actions_pending\": false, \"actions_completed\": <count>, \"duplications_prevented\": <count>, \"format_adaptations\": <count>, \"feedback_items\": <count>}

Execute all action briefs with enhanced quality controls and update the state file."

    "$CLAUDE_CMD" --print --dangerously-skip-permissions "$UPDATER_PROMPT" >> "$LOG_FILE" 2>> "$ERROR_FILE"
    
    echo "$(date): Sophisticated PAIA orchestration completed" >> "$LOG_FILE"

elif wait_for_status_change "no_work" 60; then
    echo "$(date): No @paia instructions found to process" >> "$LOG_FILE"
else
    echo "$(date): Analyzer timeout or failure" >> "$ERROR_FILE"
fi

echo "$(date): Sophisticated PAIA orchestration finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"