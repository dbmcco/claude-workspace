#!/bin/bash

# ABOUTME: Comprehensive PAIA system with task/project sync integration
# ABOUTME: Handles @paia instructions + task synchronization + project updates

CLAUDE_CMD="/opt/homebrew/bin/claude"
WORK_DIR="/Users/braydon/projects/claude-workspace"
STATE_FILE="$HOME/.paia-comprehensive-state.json"
BRIEFS_FILE="$HOME/.paia-comprehensive-briefs.json"
LOG_FILE="$HOME/Library/Logs/claude-paia-comprehensive.log"
ERROR_FILE="$HOME/Library/Logs/claude-paia-comprehensive-error.log"

cd "$WORK_DIR" || exit 1

# Initialize state
echo '{"status": "ready", "timestamp": "", "paia_findings": 0, "sync_gaps": 0, "actions_pending": 0}' > "$STATE_FILE"

echo "$(date): Starting comprehensive PAIA system..." >> "$LOG_FILE"

# Function to read status
get_status() {
    python3 -c "import json; print(json.load(open('$STATE_FILE'))['status'])" 2>/dev/null || echo "error"
}

# Function to wait for status change
wait_for_status_change() {
    local target_status="$1"
    local timeout="${2:-300}"
    local elapsed=0
    local poll_interval=15
    
    while [ $elapsed -lt $timeout ]; do
        local current_status=$(get_status)
        if [ "$current_status" = "$target_status" ]; then
            return 0
        fi
        sleep $poll_interval
        elapsed=$((elapsed + poll_interval))
        echo "$(date): Waiting for '$target_status', current: '$current_status' (${elapsed}s)" >> "$LOG_FILE"
    done
    
    return 1
}

# Comprehensive Analyzer
echo "$(date): Running comprehensive PAIA analyzer..." >> "$LOG_FILE"

ANALYZER_PROMPT="You are the comprehensive PAIA analyzer integrating multiple workflows:

## Your Integrated Analysis Tasks:

### 1. @paia Instruction Discovery
- Search entire vault for @paia tags with surrounding context
- Classify direct actions vs dialog/feedback requests
- Follow cross-references to gather complete context

### 2. Task/Project Sync Detection  
- Find completed tasks in daily notes (marked with ✅ and dates)
- Check if these completions exist in corresponding project master lists
- Identify bidirectional sync gaps between daily notes and masters

### 3. Project Status Assessment
- Review project master lists for outdated status
- Identify projects needing progress updates based on task completions

## Required Structured Output:

### State File ($STATE_FILE):
{\"status\": \"analysis_complete\", \"timestamp\": \"$(date -Iseconds)\", \"paia_findings\": <count>, \"sync_gaps\": <count>, \"project_updates\": <count>, \"actions_pending\": <total_actions>, \"dialog_pending\": <feedback_requests>}

### Action Briefs ($BRIEFS_FILE):
JSON array with comprehensive action items:
{
  \"action_id\": \"unique_id\",
  \"action_category\": \"paia_instruction|task_sync|project_update\",
  \"source_note\": \"path/to/note.md\",
  \"instruction_text\": \"exact command or description\",
  \"execution_mode\": \"direct|dialog\",
  \"actionable_brief\": \"specific instructions for updater\",
  \"target_locations\": [\"where updates should be made\"],
  \"duplication_risk\": \"high|medium|low\",
  \"priority\": \"high|medium|low\"
}

## Quality Focus:
- Identify ALL sync gaps systematically  
- Flag duplication risks before execution
- Classify feedback requests accurately
- Provide comprehensive context for execution

Execute this comprehensive analysis and write both structured output files."

"$CLAUDE_CMD" --print --dangerously-skip-permissions "$ANALYZER_PROMPT" >> "$LOG_FILE" 2>> "$ERROR_FILE" &

# Wait for comprehensive analysis
if wait_for_status_change "analysis_complete" 400; then
    echo "$(date): Analysis complete, running comprehensive updater..." >> "$LOG_FILE"
    
    UPDATER_PROMPT="You are the comprehensive PAIA updater with integrated task/project sync capabilities:

## Your Integrated Execution Tasks:

### 1. @paia Instruction Execution
- Execute direct @paia instructions with quality safeguards
- Route dialog/feedback requests to 'PAIA Pending Feedback.md'
- Prevent duplications through pre-execution checks

### 2. Task/Project Synchronization
- Sync completed tasks from daily notes to project masters
- Update completion dates and status consistently
- Maintain bidirectional consistency

### 3. Project Status Updates  
- Update project progress based on completed tasks
- Refresh master list status and priorities
- Maintain cross-reference integrity

## Enhanced Quality Controls:
- **Duplication Prevention**: Check existing content before adding
- **Format Consistency**: Follow established note patterns  
- **Sync Verification**: Confirm tasks exist before marking complete
- **Dialog Routing**: Queue feedback items properly

## Processing Instructions:
1. Load action briefs from $BRIEFS_FILE
2. Group actions by category for efficient execution
3. Execute with quality controls and deduplication checks
4. Update project masters with task completion sync
5. Route dialog items to pending feedback note

## Required Output:
Update $STATE_FILE with comprehensive results:
{\"status\": \"complete|awaiting_feedback\", \"timestamp\": \"$(date -Iseconds)\", \"paia_executed\": <count>, \"tasks_synced\": <count>, \"projects_updated\": <count>, \"duplications_prevented\": <count>, \"dialog_items\": <count>}

Execute all actions with comprehensive quality controls."

    "$CLAUDE_CMD" --print --dangerously-skip-permissions "$UPDATER_PROMPT" >> "$LOG_FILE" 2>> "$ERROR_FILE"
    
    echo "$(date): Comprehensive PAIA system completed" >> "$LOG_FILE"

elif wait_for_status_change "no_work" 60; then
    echo "$(date): No work found to process" >> "$LOG_FILE"
else
    echo "$(date): Analysis timeout or failure" >> "$ERROR_FILE"
fi

echo "$(date): Comprehensive PAIA system finished" >> "$LOG_FILE"
echo "---" >> "$LOG_FILE"