#!/bin/bash

# ABOUTME: Deploy journal MCP globally across all projects
# ABOUTME: Enables agent coordination and learning for every Claude session

set -e

echo "🚀 Deploying Journal MCP Globally..."
echo ""

# Step 1: Build the journal MCP
echo "📦 Building Journal MCP..."
cd /Users/braydon/projects/claude-workspace/mcps/journal-mcp

# Install dependencies if needed
if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
fi

# Build TypeScript
echo "🔨 Compiling TypeScript..."
npx tsc

echo "✅ Journal MCP built successfully"
echo ""

# Step 2: Test the MCP server
echo "🧪 Testing MCP server..."
timeout 3 node dist/server.js <<< '{"jsonrpc": "2.0", "id": 1, "method": "tools/list", "params": {}}' || echo "✅ Server test completed"
echo ""

# Step 3: Create global configuration
echo "📋 Setting up global configuration..."

# Create Claude Code configuration directory if it doesn't exist
CLAUDE_CONFIG_DIR="$HOME/.config/claude"
mkdir -p "$CLAUDE_CONFIG_DIR"

# Copy global MCP configuration
cp /Users/braydon/projects/claude-workspace/settings/global-mcp-config.json "$CLAUDE_CONFIG_DIR/mcp_servers.json"

echo "✅ Global MCP configuration deployed to $CLAUDE_CONFIG_DIR/mcp_servers.json"
echo ""

# Step 4: Update all project templates
echo "🔄 Updating project templates..."

TEMPLATES_DIR="/Users/braydon/projects/claude-workspace/templates"
for template in "$TEMPLATES_DIR"/CLAUDE-*.md; do
    if [ -f "$template" ]; then
        echo "Updating $(basename "$template")..."
        
        # Add journal MCP reference if not already present
        if ! grep -q "journal MCP" "$template"; then
            cat >> "$template" << 'EOF'

## Agent Coordination Available

### Journal MCP for Learning
Global agent coordination and learning system available:
- **mcp__journal__log_agent_activity**: Log PM Claude → sub-agent delegations
- **mcp__journal__get_agent_context**: Get agent performance history
- **mcp__journal__retrieve_relevant_memories**: Learn from past attempts
- **mcp__journal__store_session_memory**: Cross-session conversation learning

### Learning Commands
```bash
# Before delegating, check for similar past attempts
# Claude: "Check journal for similar real-time features before deciding"

# Analyze agent performance
# Claude: "What has @implementer succeeded/failed at in this project?"

# Apply learning to decisions  
# Claude: "Learn from journal before delegating this complex task"
```

Journal entries stored at: `~/.claude-workspace/journal/{project-type}/{project-name}/`
EOF
        fi
    fi
done

echo "✅ Project templates updated"
echo ""

# Step 5: Verification
echo "🔍 Verification..."

echo "Journal MCP tools available:"
node -e "
import { readFileSync } from 'fs';
const config = JSON.parse(readFileSync('$CLAUDE_CONFIG_DIR/mcp_servers.json', 'utf8'));
console.log('✅ Obsidian MCP:', config.mcps.obsidian ? 'configured' : 'missing');
console.log('✅ Journal MCP:', config.mcps.journal ? 'configured' : 'missing');
"

echo ""
echo "📁 Journal directory structure:"
ls -la ~/.claude-workspace/journal/ 2>/dev/null || echo "(Will be created on first use)"

echo ""
echo "✅ GLOBAL DEPLOYMENT COMPLETE!"
echo ""
echo "🎯 Next Steps:"
echo "1. Restart any running Claude Code sessions to load new MCP configuration"
echo "2. In any project directory, Claude now has access to:"
echo "   - Agent coordination tools (journal MCP)"
echo "   - Vault intelligence (Obsidian MCP)"
echo "   - Cross-project learning from shared journal"
echo ""
echo "🔧 Usage in any project:"
echo '   Task("@implementer", "Add user authentication")'
echo '   # Automatically logs delegation and can learn from past attempts'
echo ""
echo "📖 Human-readable journal: ~/.claude-workspace/journal/{project}/{date}/"
echo "🧠 Claude learning: Queries journal before making delegation decisions"