#!/bin/bash

# ABOUTME: PAIA automation using Claude Code best practices from research
# ABOUTME: Uses --continue --print for proper MCP access in automation mode

# Configuration
CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
LOG_FILE="$HOME/Library/Logs/claude-paia-daily-scanner.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-daily-scanner-error.log"

# Change to working directory
cd "$WORK_DIR" || exit 1

# Log start time
echo "$(date): Starting PAIA automation with --continue --print..." >> "$LOG_FILE"

# Check if MCP server is running
MCP_RUNNING=$(ps aux | grep "obsidian_mcp/dist/index.js" | grep -v grep | wc -l)

if [ "$MCP_RUNNING" -eq 0 ]; then
    echo "$(date): ERROR - No MCP server running" >> "$ERROR_FILE"
    exit 1
fi

echo "$(date): Found $MCP_RUNNING MCP server(s) running" >> "$LOG_FILE"

# Use --continue --print for automation with MCP access preserved
"$CLAUDE_CMD" --continue --print "@paia-analyzer specifically scan today's daily note and upcoming daily notes for @paia instructions; @paia-updater execute all action briefs from daily notes scan" >> "$LOG_FILE" 2>> "$ERROR_FILE"
EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "$(date): PAIA automation completed successfully" >> "$LOG_FILE"
else
    echo "$(date): PAIA automation failed with exit code $EXIT_CODE" >> "$ERROR_FILE"
fi

echo "$(date): PAIA automation finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"

exit $EXIT_CODE