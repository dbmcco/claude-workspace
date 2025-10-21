#!/bin/bash

# ABOUTME: Deploy Apple Notes MCP across the Claude workspace
# This script builds and deploys the Apple Notes MCP to standard locations

set -e

# Configuration
NOTES_MCP_DIR="/Users/braydon/projects/experiments/mcp/notes_mcp"
CLAUDE_CONFIG_DIR="$HOME/.config/claude_desktop"
BACKUP_DIR="/Users/braydon/projects/claude-workspace/backup/settings"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[$(date +'%Y-%m-%d %H:%M:%S')] WARNING: $1${NC}"
}

error() {
    echo -e "${RED}[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1${NC}"
    exit 1
}

# Verify Notes MCP directory exists
if [ ! -d "$NOTES_MCP_DIR" ]; then
    error "Notes MCP directory not found: $NOTES_MCP_DIR"
fi

log "Starting Apple Notes MCP deployment..."

# Build Notes MCP
log "Building Notes MCP..."
cd "$NOTES_MCP_DIR"
if [ ! -f "package.json" ]; then
    error "package.json not found in Notes MCP directory"
fi

npm install
npm run build

# Verify build output
if [ ! -f "dist/index.js" ]; then
    error "Build failed - dist/index.js not found"
fi

log "Notes MCP built successfully"

# Create backup of existing Claude config
if [ -f "$CLAUDE_CONFIG_DIR/claude_desktop.json" ]; then
    log "Backing up existing Claude configuration..."
    mkdir -p "$BACKUP_DIR"
    cp "$CLAUDE_CONFIG_DIR/claude_desktop.json" "$BACKUP_DIR/claude_desktop_backup_$(date +%Y%m%d_%H%M%S).json"
fi

# Deploy Notes MCP configuration
log "Deploying Notes MCP configuration..."
mkdir -p "$CLAUDE_CONFIG_DIR"

# Use the standardized MCP configuration
cp "/Users/braydon/projects/mcp-standard.json" "$CLAUDE_CONFIG_DIR/claude_desktop.json"

log "Notes MCP deployed successfully!"
log "Configuration applied to: $CLAUDE_CONFIG_DIR/claude_desktop.json"

# Test Notes MCP deployment
log "Testing Notes MCP deployment..."
if node -e "
const config = require('$CLAUDE_CONFIG_DIR/claude_desktop.json');
if (!config.mcpServers || !config.mcpServers.notes) {
    console.error('Notes MCP not found in configuration');
    process.exit(1);
}
console.log('Notes MCP configuration validated');
"; then
    log "Notes MCP deployment test passed"
else
    error "Notes MCP deployment test failed"
fi

log "Apple Notes MCP deployment completed successfully!"
log "Available MCP functions:"
log "  - mcp__notes__list_notes"
log "  - mcp__notes__get_note"
log "  - mcp__notes__create_note"
log "  - mcp__notes__update_note"
log "  - mcp__notes__search_notes"
log ""
log "Restart Claude Desktop to activate the new configuration."