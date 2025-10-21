#!/bin/bash

# ABOUTME: PAIA automation using headless Claude with sub-agent spawning
# ABOUTME: Replicates @paia-analyzer → @paia-updater workflow in headless mode

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
LOG_FILE="$HOME/Library/Logs/claude-paia-agents.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-agents-error.log"

cd "$WORK_DIR" || exit 1

echo "$(date): Starting PAIA headless agent automation..." >> "$LOG_FILE"

# Check for MCP servers
MCP_RUNNING=$(ps aux | grep "obsidian_mcp/dist/index.js" | grep -v grep | wc -l)
if [ "$MCP_RUNNING" -eq 0 ]; then
    echo "$(date): ERROR - No MCP server running" >> "$ERROR_FILE"
    exit 1
fi

echo "$(date): Found $MCP_RUNNING MCP server(s) running" >> "$LOG_FILE"

# Headless command that spawns the PAIA agent sequence
PAIA_PROMPT="Execute the PAIA agent workflow:

1. First, spawn @paia-analyzer:
   Task('@paia-analyzer', 'specifically scan today\'s daily note and upcoming daily notes for @paia instructions; analyze context around each instruction; follow any cross-references to gather complete context; prepare comprehensive action briefs for immediate processing')

2. After analyzer completes, spawn @paia-updater:  
   Task('@paia-updater', 'execute all action briefs from daily notes scan with full context awareness and completion tracking; focus on task scheduling, redistribution, and optimization')

Execute this full PAIA agent sequence now."

"$CLAUDE_CMD" --print --dangerously-skip-permissions "$PAIA_PROMPT" >> "$LOG_FILE" 2>> "$ERROR_FILE"

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    echo "$(date): PAIA headless agents completed successfully" >> "$LOG_FILE"
else
    echo "$(date): PAIA headless agents failed with exit code $EXIT_CODE" >> "$ERROR_FILE"
fi

echo "$(date): PAIA headless agents finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"

exit $EXIT_CODE