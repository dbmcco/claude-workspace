#!/bin/bash

# ABOUTME: Fixed PAIA automation with properly escaped prompts
# ABOUTME: Single-line prompts without line breaks for CLI compatibility

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
STATE_FILE="$HOME/.paia-working-state.json"
LOG_FILE="$HOME/Library/Logs/claude-paia-working-fixed.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-working-fixed-error.log"

cd "$WORK_DIR" || exit 1

echo "$(date): Starting fixed PAIA automation..." >> "$LOG_FILE"

# Check for MCP servers
MCP_RUNNING=$(ps aux | grep "obsidian_mcp/dist/index.js" | grep -v grep | wc -l)
if [ "$MCP_RUNNING" -eq 0 ]; then
    echo "$(date): ERROR - No MCP server running" >> "$ERROR_FILE"
    exit 1
fi

echo "$(date): Found $MCP_RUNNING MCP server(s) running" >> "$LOG_FILE"

# Step 1: Simple working analyzer (single line, no breaks)
echo "$(date): Running PAIA analyzer..." >> "$LOG_FILE"

"$CLAUDE_CMD" --print --dangerously-skip-permissions "Search my vault for @paia instructions and completed tasks needing sync. Then write this exact JSON to the file $STATE_FILE: {\"status\":\"analysis_complete\",\"timestamp\":\"$(date -Iseconds)\",\"findings\":COUNT,\"actions_pending\":DIRECT_ACTIONS,\"sync_needed\":SYNC_COUNT}. Replace COUNT, DIRECT_ACTIONS, and SYNC_COUNT with actual numbers found." >> "$LOG_FILE" 2>> "$ERROR_FILE"

ANALYZER_EXIT=$?
echo "$(date): Analyzer completed with exit code $ANALYZER_EXIT" >> "$LOG_FILE"

if [ $ANALYZER_EXIT -eq 0 ]; then
    echo "$(date): Running PAIA updater..." >> "$LOG_FILE"
    
    # Step 2: Simple working updater (single line, no breaks)  
    "$CLAUDE_CMD" --print --dangerously-skip-permissions "Act as @paia-updater: Read any findings from the analyzer and execute direct @paia instructions. For feedback requests, create or update 'PAIA Pending Feedback.md' note. For task sync needs, update the appropriate project master lists with completed task status. Avoid duplicating existing content. Mark completed @paia instructions with timestamps." >> "$LOG_FILE" 2>> "$ERROR_FILE"
    
    UPDATER_EXIT=$?
    echo "$(date): Updater completed with exit code $UPDATER_EXIT" >> "$LOG_FILE"
else
    echo "$(date): Skipping updater due to analyzer failure" >> "$LOG_FILE"
fi

echo "$(date): Fixed PAIA automation finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"