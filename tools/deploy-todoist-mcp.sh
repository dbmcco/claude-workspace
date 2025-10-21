#!/bin/bash

# Deploy Todoist MCP to projects across the workspace
# Usage: ./deploy-todoist-mcp.sh [project_path] or run without args for all projects

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
TODOIST_TOKEN="Todoist API Token e4df4a7450a48c58b173f2851753a2998b2a8841"

echo "🚀 Deploying Todoist MCP to projects..."

# Function to add Todoist MCP to a project's .mcp.json
add_todoist_to_project() {
    local project_path="$1"
    local mcp_file="$project_path/.mcp.json"
    
    echo "📁 Processing: $project_path"
    
    # Skip if no .mcp.json exists
    if [[ ! -f "$mcp_file" ]]; then
        echo "  ⚠️  No .mcp.json found, skipping"
        return
    fi
    
    # Check if todoist already configured
    if grep -q '"todoist"' "$mcp_file"; then
        echo "  ✅ Todoist MCP already configured"
        return
    fi
    
    # Backup original
    cp "$mcp_file" "$mcp_file.backup"
    
    # Add todoist MCP server
    # This is a simple approach - add before the closing brace
    if grep -q '"mcpServers"' "$mcp_file"; then
        # Find the last server entry and add todoist after it
        python3 -c "
import json
import sys

with open('$mcp_file', 'r') as f:
    config = json.load(f)

if 'mcpServers' not in config:
    config['mcpServers'] = {}

config['mcpServers']['todoist'] = {
    'command': 'node',
    'args': ['/Users/braydon/projects/experiments/mcp/todoist_mcp/dist/index.js'],
    'env': {
        'TODOIST_API_TOKEN': '$TODOIST_TOKEN'
    }
}

with open('$mcp_file', 'w') as f:
    json.dump(config, f, indent=2)
"
        echo "  ✅ Added Todoist MCP configuration"
    else
        echo "  ❌ Invalid .mcp.json format"
    fi
}

# If specific project path provided, process only that project
if [[ $# -eq 1 ]]; then
    add_todoist_to_project "$1"
    exit 0
fi

# Otherwise, process all projects with .mcp.json files
echo "🔍 Finding projects with .mcp.json files..."

find "$WORKSPACE_ROOT" -name ".mcp.json" -not -path "*/archive/*" -not -path "*/node_modules/*" | while read -r mcp_file; do
    project_dir="$(dirname "$mcp_file")"
    add_todoist_to_project "$project_dir"
done

echo ""
echo "🎉 Todoist MCP deployment complete!"
echo ""
echo "📋 Todoist MCP provides:"
echo "  • Task creation and management"
echo "  • Project organization"
echo "  • Label and priority handling"
echo "  • Advanced filtering and search"
echo "  • Due date management"
echo ""
echo "💡 Available tools: create_task, get_tasks, list_projects, complete_task, update_task, delete_task, search_tasks"
echo "🔧 Test with: mcp__todoist__create_task"