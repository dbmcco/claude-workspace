#!/bin/bash

# ABOUTME: PAIA orchestrated automation with state machine polling
# ABOUTME: Script manages agent sequence based on status written to JSON state file

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
STATE_FILE="$HOME/.paia-state.json"
LOG_FILE="$HOME/Library/Logs/claude-paia-orchestrated.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-orchestrated-error.log"

cd "$WORK_DIR" || exit 1

# Initialize state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo '{"status": "ready", "timestamp": "", "findings": 0, "actions_pending": false}' > "$STATE_FILE"
fi

echo "$(date): Starting PAIA orchestrated automation..." >> "$LOG_FILE"

# Function to read status from JSON
get_status() {
    python3 -c "import json; print(json.load(open('$STATE_FILE'))['status'])"
}

# Function to wait for status change with timeout
wait_for_status_change() {
    local target_status="$1"
    local timeout="${2:-120}"  # 2 minute default timeout
    local elapsed=0
    local poll_interval=5
    
    while [ $elapsed -lt $timeout ]; do
        local current_status=$(get_status)
        if [ "$current_status" = "$target_status" ]; then
            return 0
        fi
        sleep $poll_interval
        elapsed=$((elapsed + poll_interval))
        echo "$(date): Waiting for status '$target_status', current: '$current_status' (${elapsed}s)" >> "$LOG_FILE"
    done
    
    echo "$(date): Timeout waiting for status '$target_status'" >> "$ERROR_FILE"
    return 1
}

# Step 1: Trigger analyzer
echo "$(date): Triggering @paia-analyzer..." >> "$LOG_FILE"
"$CLAUDE_CMD" --print --dangerously-skip-permissions "Act as @paia-analyzer: 

1. Search today's daily note and upcoming daily notes for @paia instructions
2. Analyze context around each instruction and follow cross-references  
3. Count total @paia instructions found
4. Write status to $STATE_FILE with this JSON structure:
   - If @paia instructions found: {\"status\": \"analysis_complete\", \"timestamp\": \"$(date -Iseconds)\", \"findings\": <count>, \"actions_pending\": true}
   - If no @paia instructions: {\"status\": \"no_work\", \"timestamp\": \"$(date -Iseconds)\", \"findings\": 0, \"actions_pending\": false}
5. If actions are pending, also create a detailed action brief note for @paia-updater

Complete the analysis and update the state file." >> "$LOG_FILE" 2>> "$ERROR_FILE" &

# Wait for analyzer to complete
if wait_for_status_change "analysis_complete" 180; then
    echo "$(date): Analyzer found work, triggering @paia-updater..." >> "$LOG_FILE"
    
    # Step 2: Trigger updater
    "$CLAUDE_CMD" --print --dangerously-skip-permissions "Act as @paia-updater:

1. Read the action brief created by @paia-analyzer  
2. Execute all requested actions with full context awareness
3. Mark completed @paia instructions appropriately
4. Update state file to: {\"status\": \"complete\", \"timestamp\": \"$(date -Iseconds)\", \"findings\": <count>, \"actions_pending\": false}

Complete all actions and update the state file." >> "$LOG_FILE" 2>> "$ERROR_FILE"
    
    echo "$(date): PAIA orchestration completed successfully" >> "$LOG_FILE"

elif wait_for_status_change "no_work" 60; then
    echo "$(date): Analyzer found no @paia instructions to process" >> "$LOG_FILE"
    
else
    echo "$(date): Analyzer did not complete within timeout" >> "$ERROR_FILE"
fi

# Reset for next run
echo '{"status": "ready", "timestamp": "", "findings": 0, "actions_pending": false}' > "$STATE_FILE"

echo "$(date): PAIA orchestrated automation finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"