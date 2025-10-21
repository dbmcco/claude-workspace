#!/bin/bash

# ABOUTME: PAIA automation that captures Claude output and writes to state file
# ABOUTME: Works around headless mode file writing limitations

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
STATE_FILE="$HOME/.paia-capture-state.json"
LOG_FILE="$HOME/Library/Logs/claude-paia-capture.log"

cd "$WORK_DIR" || exit 1

echo "$(date): Starting PAIA automation with output capture..." >> "$LOG_FILE"

# Step 1: Get analysis results and capture output
echo "$(date): Running analyzer with output capture..." >> "$LOG_FILE"

ANALYZER_OUTPUT=$("$CLAUDE_CMD" --print --dangerously-skip-permissions "Search my vault for @paia instructions and completed tasks. Output only this JSON format: {\"status\":\"analysis_complete\",\"findings\":COUNT,\"actions_pending\":DIRECT_COUNT,\"sync_needed\":SYNC_COUNT} where COUNT is total @paia found, DIRECT_COUNT is actionable instructions, SYNC_COUNT is tasks needing project sync.")

echo "$(date): Analyzer output: $ANALYZER_OUTPUT" >> "$LOG_FILE"

# Write the captured output to state file
echo "$ANALYZER_OUTPUT" > "$STATE_FILE"
echo "$(date): State file written to $STATE_FILE" >> "$LOG_FILE"

# Step 2: If we found work, run updater
if [[ "$ANALYZER_OUTPUT" == *"analysis_complete"* ]]; then
    echo "$(date): Analysis found work, running updater..." >> "$LOG_FILE"
    
    "$CLAUDE_CMD" --print --dangerously-skip-permissions "Based on previous analysis, execute direct @paia instructions and sync completed tasks to project masters. Avoid duplicating existing content." >> "$LOG_FILE" 2>&1
    
    echo "$(date): Updater completed" >> "$LOG_FILE"
else
    echo "$(date): No valid analysis results, skipping updater" >> "$LOG_FILE"
fi

echo "$(date): PAIA automation with output capture completed" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"