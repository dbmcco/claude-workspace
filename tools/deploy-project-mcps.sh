#!/bin/bash

# ABOUTME: Deploy all MCPs to individual projects across the workspace
# This script updates .mcp.json files in projects to include all 5 MCPs

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
: "${TODOIST_TOKEN:?Set TODOIST_TOKEN in the environment (export TODOIST_TOKEN=<your token>)}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

info() {
    echo -e "${BLUE}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
}

success() {
    echo -e "${GREEN}✅ $1${NC}"
}

# Function to add all MCPs to a project's .mcp.json
deploy_mcps_to_project() {
    local project_path="$1"
    local mcp_file="$project_path/.mcp.json"
    
    info "Processing: $project_path"
    
    # Skip if no .mcp.json exists
    if [[ ! -f "$mcp_file" ]]; then
        warn "No .mcp.json found, skipping"
        return
    fi
    
    # Backup original
    cp "$mcp_file" "$mcp_file.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Update with all MCPs using Python script
    python3 -c "
import json
import sys

try:
    with open('$mcp_file', 'r') as f:
        config = json.load(f)
except json.JSONDecodeError as e:
    print('❌ Invalid JSON in $mcp_file:', e)
    sys.exit(1)

# Ensure mcpServers section exists
if 'mcpServers' not in config:
    config['mcpServers'] = {}

# Add all 5 MCPs
mcps = {
    'obsidian': {
        'command': 'node',
        'args': ['/Users/braydon/projects/experiments/mcp/obsidian_mcp/dist/index.js'],
        'env': {
            'OBSIDIAN_VAULT_PATH': '/users/braydon/obsidian/bvault'
        }
    },
    'journal': {
        'command': 'node',
        'args': ['/Users/braydon/projects/experiments/mcp/journal-mcp/dist/server.js'],
        'env': {}
    },
    'todoist': {
        'command': 'node',
        'args': ['/Users/braydon/projects/experiments/mcp/todoist_mcp/dist/index.js'],
        'env': {
            'TODOIST_API_TOKEN': '$TODOIST_TOKEN'
        }
    },
    'reminders': {
        'command': 'node',
        'args': ['/Users/braydon/projects/experiments/mcp/reminders_mcp/dist/index.js']
    },
    'canva-dev': {
        'command': 'npx',
        'args': ['-y', '@canva/cli@latest', 'mcp']
    },
    'notes': {
        'command': 'node',
        'args': ['/Users/braydon/projects/experiments/mcp/notes_mcp/dist/index.js']
    }
}

# Add each MCP if not already present
added_mcps = []
updated_mcps = []

for mcp_name, mcp_config in mcps.items():
    if mcp_name not in config['mcpServers']:
        config['mcpServers'][mcp_name] = mcp_config
        added_mcps.append(mcp_name)
    else:
        # Update existing configuration
        config['mcpServers'][mcp_name] = mcp_config
        updated_mcps.append(mcp_name)

# Ensure permissions section exists and includes MCP permissions
if 'permissions' not in config:
    config['permissions'] = {'allow': [], 'deny': []}

mcp_permissions = [
    'mcp__obsidian__*',
    'mcp__journal__*',
    'mcp__todoist__*',
    'mcp__reminders__*',
    'mcp__notes__*'
]

for perm in mcp_permissions:
    if perm not in config['permissions']['allow']:
        config['permissions']['allow'].append(perm)

# Add enableAllProjectMcpServers flag
config['enableAllProjectMcpServers'] = True

try:
    with open('$mcp_file', 'w') as f:
        json.dump(config, f, indent=2)
    
    if added_mcps:
        print('✅ Added MCPs:', ', '.join(added_mcps))
    if updated_mcps:
        print('🔄 Updated MCPs:', ', '.join(updated_mcps))
    print('✅ MCP permissions configured')
    
except Exception as e:
    print('❌ Failed to write configuration:', e)
    sys.exit(1)
"
    
    if [ $? -eq 0 ]; then
        success "All MCPs deployed to project"
    else
        error "Failed to deploy MCPs to project"
    fi
}

log "🚀 Deploying all MCPs to projects across workspace..."

# If specific project path provided, process only that project
if [[ $# -eq 1 ]]; then
    deploy_mcps_to_project "$1"
    exit 0
fi

# Otherwise, process all projects with .mcp.json files
info "🔍 Finding projects with .mcp.json files..."

projects_found=0
projects_updated=0

find "$WORKSPACE_ROOT" -name ".mcp.json" -not -path "*/archive/*" -not -path "*/node_modules/*" -not -path "*/.git/*" | while read -r mcp_file; do
    project_dir="$(dirname "$mcp_file")"
    projects_found=$((projects_found + 1))
    
    if deploy_mcps_to_project "$project_dir"; then
        projects_updated=$((projects_updated + 1))
    fi
done

log ""
log "🎉 MCP deployment complete!"
log ""
log "📋 All MCPs now available:"
log "  • Obsidian: Vault access and note intelligence"
log "  • Journal: Agent coordination and session memory"
log "  • Todoist: Task creation and project management"
log "  • Reminders: Apple Reminders integration"
log "  • Notes: Apple Notes integration"
log "  • Canva: Design and creative tools"
log ""
log "🔧 Available function patterns:"
log "  • mcp__obsidian__* (query_vault, create_note, search_notes)"
log "  • mcp__journal__* (log_agent_activity, store_session_memory)"
log "  • mcp__todoist__* (create_task, get_tasks, update_task)"
log "  • mcp__reminders__* (create_reminder, list_reminder_lists)"
log "  • mcp__notes__* (create_note, search_notes, list_notes)"
log ""
log "💡 Test deployment with: mcp__obsidian__query_vault or mcp__todoist__create_task"
