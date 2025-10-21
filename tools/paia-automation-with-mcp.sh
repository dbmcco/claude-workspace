#!/bin/bash

# ABOUTME: PAIA automation script that works with existing MCP server
# ABOUTME: Connects to running Obsidian MCP server for vault access

# Configuration
CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
LOG_FILE="$HOME/Library/Logs/claude-paia-daily-scanner.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-daily-scanner-error.log"

# Change to working directory
cd "$WORK_DIR" || exit 1

# Log start time
echo "$(date): Starting PAIA daily scanner..." >> "$LOG_FILE"

# Check if MCP server is running
MCP_RUNNING=$(ps aux | grep "obsidian_mcp/dist/index.js" | grep -v grep | wc -l)

if [ "$MCP_RUNNING" -eq 0 ]; then
    echo "$(date): ERROR - No MCP server running" >> "$ERROR_FILE"
    exit 1
fi

echo "$(date): Found $MCP_RUNNING MCP server(s) running" >> "$LOG_FILE"

# Run PAIA analysis and execution
# This assumes Claude CLI can connect to the MCP server when run from workspace
"$CLAUDE_CMD" "@paia-analyzer specifically scan today's daily note and upcoming daily notes for @paia instructions; @paia-updater execute all action briefs from daily notes scan" >> "$LOG_FILE" 2>> "$ERROR_FILE"

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "$(date): PAIA scan completed successfully" >> "$LOG_FILE"
else
    echo "$(date): PAIA scan failed with exit code $EXIT_CODE" >> "$ERROR_FILE"
fi

echo "$(date): PAIA daily scanner finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"

exit $EXIT_CODE