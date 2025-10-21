#!/bin/bash

# ABOUTME: Direct PAIA automation without agent references
# ABOUTME: Uses MCP functions directly to scan and execute @paia instructions

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
LOG_FILE="$HOME/Library/Logs/claude-paia-daily-scanner.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-daily-scanner-error.log"

cd "$WORK_DIR" || exit 1

echo "$(date): Starting direct PAIA automation..." >> "$LOG_FILE"

# Check for MCP servers
MCP_RUNNING=$(ps aux | grep "obsidian_mcp/dist/index.js" | grep -v grep | wc -l)
if [ "$MCP_RUNNING" -eq 0 ]; then
    echo "$(date): ERROR - No MCP server running" >> "$ERROR_FILE"
    exit 1
fi

echo "$(date): Found $MCP_RUNNING MCP server(s) running" >> "$LOG_FILE"

# Direct command without agent references
"$CLAUDE_CMD" --continue --print "Search my vault for any @paia instructions in daily notes, analyze their context, and execute the requested actions by updating notes accordingly. Focus on today's and upcoming daily notes." >> "$LOG_FILE" 2>> "$ERROR_FILE"

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "$(date): Direct PAIA automation completed successfully" >> "$LOG_FILE"
else
    echo "$(date): Direct PAIA automation failed with exit code $EXIT_CODE" >> "$ERROR_FILE"
fi

echo "$(date): Direct PAIA automation finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"

exit $EXIT_CODE