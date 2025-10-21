#!/bin/bash

# ABOUTME: Validate MCP deployment across the entire workspace
# This script checks that all 5 MCPs are properly configured and accessible

set -e

# Configuration
CLAUDE_CONFIG_DIR="$HOME/.config/claude_desktop"
WORKSPACE_DIR="/Users/braydon/projects/claude-workspace"
MCP_BASE_DIR="/Users/braydon/projects/experiments/mcp"

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
    echo -e "${GREEN}✓ $1${NC}"
}

fail() {
    echo -e "${RED}✗ $1${NC}"
}

validate_file_exists() {
    local file="$1"
    local description="$2"
    
    if [ -f "$file" ]; then
        success "$description exists: $file"
        return 0
    else
        fail "$description missing: $file"
        return 1
    fi
}

validate_mcp_build() {
    local mcp_name="$1"
    local build_path="$2"
    
    if [ -f "$build_path" ]; then
        success "$mcp_name MCP build found: $build_path"
        return 0
    else
        fail "$mcp_name MCP build missing: $build_path"
        return 1
    fi
}

validate_claude_config() {
    local config_file="$1"
    
    if [ ! -f "$config_file" ]; then
        fail "Claude configuration missing: $config_file"
        return 1
    fi
    
    local validation_result=$(node -e "
try {
    const config = require('$config_file');
    const requiredMcps = ['obsidian', 'todoist', 'notes', 'reminders', 'journal'];
    const availableMcps = Object.keys(config.mcpServers || {});
    
    console.log('Available MCPs:', availableMcps.join(', '));
    
    const missing = requiredMcps.filter(mcp => !availableMcps.includes(mcp));
    if (missing.length > 0) {
        console.log('Missing MCPs:', missing.join(', '));
        process.exit(1);
    }
    
    // Validate each MCP configuration
    for (const mcp of requiredMcps) {
        const mcpConfig = config.mcpServers[mcp];
        if (!mcpConfig.command) {
            console.log('MCP', mcp, 'missing command');
            process.exit(1);
        }
        if (!mcpConfig.args || mcpConfig.args.length === 0) {
            console.log('MCP', mcp, 'missing args');
            process.exit(1);
        }
    }
    
    console.log('All MCPs properly configured');
    process.exit(0);
} catch (error) {
    console.log('Configuration validation error:', error.message);
    process.exit(1);
}
" 2>&1)
    
    local exit_code=$?
    echo "$validation_result"
    
    if [ $exit_code -eq 0 ]; then
        success "Claude configuration validation passed"
        return 0
    else
        fail "Claude configuration validation failed"
        return 1
    fi
}

validate_project_settings() {
    local settings_file="$1"
    local project_type="$2"
    
    if [ ! -f "$settings_file" ]; then
        fail "$project_type project settings missing: $settings_file"
        return 1
    fi
    
    if grep -q "mcp__" "$settings_file"; then
        success "$project_type project settings include MCP permissions"
        return 0
    else
        fail "$project_type project settings missing MCP permissions"
        return 1
    fi
}

log "Starting comprehensive MCP deployment validation..."

# Track validation results
total_checks=0
passed_checks=0

# Validate MCP builds
info "Validating MCP builds..."
mcp_builds=(
    "Obsidian:$MCP_BASE_DIR/obsidian_mcp/dist/index.js"
    "Todoist:$MCP_BASE_DIR/todoist_mcp/dist/index.js"
    "Notes:$MCP_BASE_DIR/notes_mcp/dist/index.js"
    "Reminders:$MCP_BASE_DIR/reminders_mcp/dist/index.js"
    "Journal:$MCP_BASE_DIR/journal-mcp/dist/server.js"
)

for build in "${mcp_builds[@]}"; do
    IFS=':' read -r name path <<< "$build"
    total_checks=$((total_checks + 1))
    if validate_mcp_build "$name" "$path"; then
        passed_checks=$((passed_checks + 1))
    fi
done

# Validate Claude configuration
info "Validating Claude Desktop configuration..."
total_checks=$((total_checks + 1))
if validate_claude_config "$CLAUDE_CONFIG_DIR/claude_desktop.json"; then
    passed_checks=$((passed_checks + 1))
fi

# Validate master configuration files
info "Validating master configuration files..."
config_files=(
    "MCP Standard Config:/Users/braydon/projects/mcp-standard.json"
    "Global MCP Config:$WORKSPACE_DIR/settings/global-mcp-config.json"
    "MCP Template:$WORKSPACE_DIR/templates/mcp-config-with-journal.json"
    "Claude Desktop Template:$WORKSPACE_DIR/templates/claude_desktop.json"
)

for config in "${config_files[@]}"; do
    IFS=':' read -r name path <<< "$config"
    total_checks=$((total_checks + 1))
    if validate_file_exists "$path" "$name"; then
        passed_checks=$((passed_checks + 1))
    fi
done

# Validate project settings
info "Validating project settings..."
project_settings=(
    "JavaScript:$WORKSPACE_DIR/settings/javascript-project.json"
    "Python:$WORKSPACE_DIR/settings/python-project.json"
)

for setting in "${project_settings[@]}"; do
    IFS=':' read -r type path <<< "$setting"
    total_checks=$((total_checks + 1))
    if validate_project_settings "$path" "$type"; then
        passed_checks=$((passed_checks + 1))
    fi
done

# Validate deployment scripts
info "Validating deployment scripts..."
deployment_scripts=(
    "All MCPs Deploy:$WORKSPACE_DIR/tools/deploy-all-mcps.sh"
    "Notes MCP Deploy:$WORKSPACE_DIR/tools/deploy-notes-mcp.sh"
    "Validation Script:$WORKSPACE_DIR/tools/validate-mcp-deployment.sh"
)

for script in "${deployment_scripts[@]}"; do
    IFS=':' read -r name path <<< "$script"
    total_checks=$((total_checks + 1))
    if validate_file_exists "$path" "$name"; then
        if [ -x "$path" ]; then
            passed_checks=$((passed_checks + 1))
            success "$name is executable"
        else
            fail "$name is not executable"
        fi
    fi
done

# Summary
log ""
log "=== VALIDATION SUMMARY ==="
log "Total checks: $total_checks"
log "Passed checks: $passed_checks"
log "Failed checks: $((total_checks - passed_checks))"

if [ $passed_checks -eq $total_checks ]; then
    log ""
    success "All MCP deployment validations passed!"
    log ""
    log "✓ All 5 MCPs are built and ready"
    log "✓ Claude Desktop configuration is valid"
    log "✓ Project settings include MCP permissions"
    log "✓ Deployment scripts are ready"
    log ""
    log "MCP system is fully deployed and operational."
    exit 0
else
    log ""
    error "MCP deployment validation failed!"
    log "Please address the failed checks above before using the MCP system."
    exit 1
fi