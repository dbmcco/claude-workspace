#!/bin/bash

# ABOUTME: Working PAIA automation using headless Claude with permissions bypass
# ABOUTME: Uses --print --dangerously-skip-permissions for full MCP access

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
LOG_FILE="$HOME/Library/Logs/claude-paia-working.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-working-error.log"

cd "$WORK_DIR" || exit 1

echo "$(date): Starting working PAIA automation..." >> "$LOG_FILE"

# Check for MCP servers
MCP_RUNNING=$(ps aux | grep "obsidian_mcp/dist/index.js" | grep -v grep | wc -l)
if [ "$MCP_RUNNING" -eq 0 ]; then
    echo "$(date): ERROR - No MCP server running" >> "$ERROR_FILE"
    exit 1
fi

echo "$(date): Found $MCP_RUNNING MCP server(s) running" >> "$LOG_FILE"

# Working headless command with full MCP access
"$CLAUDE_CMD" --print --dangerously-skip-permissions "Search for @paia instructions in my vault, analyze their context, and execute the requested actions by updating notes accordingly. Focus on today's and upcoming daily notes." >> "$LOG_FILE" 2>> "$ERROR_FILE"

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "$(date): Working PAIA automation completed successfully" >> "$LOG_FILE"
else
    echo "$(date): Working PAIA automation failed with exit code $EXIT_CODE" >> "$ERROR_FILE"
fi

echo "$(date): Working PAIA automation finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"

exit $EXIT_CODE