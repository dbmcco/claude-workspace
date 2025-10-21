#!/bin/bash

# ABOUTME: Setup script for shared journal MCP server deployment
# ABOUTME: Builds and configures journal MCP for all projects in claude-workspace

set -e

echo "🏗️  Setting up Journal MCP for Claude Workspace..."

# Build the journal MCP
cd /Users/braydon/projects/claude-workspace/mcps/journal-mcp

echo "📦 Installing dependencies..."
npm install

echo "🔨 Building TypeScript..."
npm run build

echo "✅ Build complete"

# Create the data directory
echo "📁 Creating data directory..."
mkdir -p ~/.claude-workspace

# Test the MCP server
echo "🧪 Testing MCP server..."
timeout 5 node dist/server.js <<< '{"jsonrpc": "2.0", "id": 1, "method": "tools/list", "params": {}}' || echo "Server test completed"

echo ""
echo "✅ Journal MCP setup complete!"
echo ""
echo "📋 Next steps:"
echo "1. Add to your Claude Code MCP configuration:"
echo '   {' 
echo '     "mcps": {'
echo '       "journal": {'
echo '         "command": "node",'
echo '         "args": ["/Users/braydon/projects/claude-workspace/mcps/journal-mcp/dist/server.js"]'
echo '       }'
echo '     }'
echo '   }'
echo ""
echo "2. Restart Claude Code CLI to load the MCP"
echo "3. Use journal MCP tools in any project under /Users/braydon/projects"
echo ""
echo "🎯 Tools available:"
echo "   - mcp__journal__log_agent_activity"
echo "   - mcp__journal__store_session_memory" 
echo "   - mcp__journal__retrieve_relevant_memories"
echo "   - mcp__journal__get_agent_context"
echo "   - mcp__journal__update_user_pattern"
echo "   - mcp__journal__get_user_patterns"