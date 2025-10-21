#!/bin/bash

# ABOUTME: Sequential PAIA automation - analyzer then updater
# ABOUTME: Runs each agent separately in sequence

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
LOG_FILE="$HOME/Library/Logs/claude-paia-sequential.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-sequential-error.log"

cd "$WORK_DIR" || exit 1

echo "$(date): Starting sequential PAIA automation..." >> "$LOG_FILE"

# Step 1: Run analyzer
echo "$(date): Running @paia-analyzer..." >> "$LOG_FILE"
"$CLAUDE_CMD" --print --dangerously-skip-permissions "Act as @paia-analyzer: scan today's daily note and upcoming daily notes for @paia instructions; analyze context around each instruction; follow any cross-references; prepare comprehensive action brief and write findings to a note for @paia-updater to process" >> "$LOG_FILE" 2>> "$ERROR_FILE"

ANALYZER_EXIT=$?
echo "$(date): Analyzer completed with exit code $ANALYZER_EXIT" >> "$LOG_FILE"

if [ $ANALYZER_EXIT -eq 0 ]; then
    # Step 2: Run updater  
    echo "$(date): Running @paia-updater..." >> "$LOG_FILE"
    "$CLAUDE_CMD" --print --dangerously-skip-permissions "Act as @paia-updater: find the action brief from @paia-analyzer and execute all requested actions with full context awareness and completion tracking" >> "$LOG_FILE" 2>> "$ERROR_FILE"
    
    UPDATER_EXIT=$?
    echo "$(date): Updater completed with exit code $UPDATER_EXIT" >> "$LOG_FILE"
else
    echo "$(date): Skipping updater due to analyzer failure" >> "$LOG_FILE"
fi

echo "$(date): Sequential PAIA automation finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"