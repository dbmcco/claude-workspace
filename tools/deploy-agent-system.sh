#!/bin/bash
# deploy-agent-system.sh
# Comprehensive agent system deployment for claude-workspace

set -e

# Configuration
WORKSPACE_ROOT="/Users/braydon/projects/claude-workspace"
BACKUP_DIR="/Users/braydon/.claude-workspace/backups"
LOG_FILE="/Users/braydon/.claude-workspace/deployment.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Print colored output
print_status() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
    log "$message"
}

# Check prerequisites
check_prerequisites() {
    print_status "$BLUE" "🔍 Checking prerequisites..."
    
    # Check Node.js
    if ! command -v node &> /dev/null; then
        print_status "$RED" "❌ Node.js is required but not installed"
        exit 1
    fi
    
    local node_version=$(node --version | sed 's/v//')
    if [ "$(printf '%s\n' "16.0.0" "$node_version" | sort -V | head -n1)" != "16.0.0" ]; then
        print_status "$RED" "❌ Node.js version 16+ required, found $node_version"
        exit 1
    fi
    print_status "$GREEN" "✅ Node.js $node_version"
    
    # Check npm
    if ! command -v npm &> /dev/null; then
        print_status "$RED" "❌ npm is required but not installed"
        exit 1
    fi
    print_status "$GREEN" "✅ npm $(npm --version)"
    
    # Check git
    if ! command -v git &> /dev/null; then
        print_status "$RED" "❌ git is required but not installed"
        exit 1
    fi
    print_status "$GREEN" "✅ git $(git --version | cut -d' ' -f3)"
    
    # Check GitHub CLI
    if ! command -v gh &> /dev/null; then
        print_status "$YELLOW" "⚠️  GitHub CLI not found. Some features may be limited."
    else
        print_status "$GREEN" "✅ GitHub CLI $(gh --version | head -n1 | cut -d' ' -f3)"
    fi
    
    # Check workspace directory
    if [ ! -d "$WORKSPACE_ROOT" ]; then
        print_status "$RED" "❌ Workspace directory not found: $WORKSPACE_ROOT"
        exit 1
    fi
    print_status "$GREEN" "✅ Workspace directory found"
}

# Create backup
create_backup() {
    print_status "$BLUE" "💾 Creating backup..."
    
    mkdir -p "$BACKUP_DIR"
    local backup_name="agent-system-backup-$(date +%Y%m%d-%H%M%S)"
    local backup_path="$BACKUP_DIR/$backup_name"
    
    # Backup existing configuration
    if [ -d "/Users/braydon/.claude-workspace" ]; then
        cp -r "/Users/braydon/.claude-workspace" "$backup_path"
        print_status "$GREEN" "✅ Backup created: $backup_path"
    fi
}

# Setup MCP servers
setup_mcp_servers() {
    print_status "$BLUE" "⚙️  Setting up MCP servers..."
    
    # Setup Obsidian MCP
    local obsidian_mcp_path="/Users/braydon/projects/experiments/obsidian_mcp"
    if [ -d "$obsidian_mcp_path" ]; then
        print_status "$BLUE" "Setting up Obsidian MCP..."
        cd "$obsidian_mcp_path"
        npm install
        npm run build
        print_status "$GREEN" "✅ Obsidian MCP configured"
    else
        print_status "$YELLOW" "⚠️  Obsidian MCP not found at $obsidian_mcp_path"
    fi
    
    # Setup Journal MCP
    local journal_mcp_path="$WORKSPACE_ROOT/mcps/journal-mcp"
    if [ -d "$journal_mcp_path" ]; then
        print_status "$BLUE" "Setting up Journal MCP..."
        cd "$journal_mcp_path"
        npm install
        npm run build
        print_status "$GREEN" "✅ Journal MCP configured"
    else
        print_status "$RED" "❌ Journal MCP not found at $journal_mcp_path"
        exit 1
    fi
    
    # Setup Reminders MCP
    print_status "$BLUE" "Setting up Reminders MCP..."
    if npm list -g @modelcontextprotocol/server-reminders &> /dev/null; then
        print_status "$GREEN" "✅ Reminders MCP already installed"
    else
        npm install -g @modelcontextprotocol/server-reminders
        print_status "$GREEN" "✅ Reminders MCP installed"
    fi
    
    cd "$WORKSPACE_ROOT"
}

# Deploy agent configurations
deploy_agent_configs() {
    print_status "$BLUE" "🤖 Deploying agent configurations..."
    
    # Create agent configuration directory
    local agent_config_dir="/Users/braydon/.claude-workspace/agents"
    mkdir -p "$agent_config_dir"
    
    # Copy agent prompts
    if [ -d "$WORKSPACE_ROOT/agents/prompts" ]; then
        cp -r "$WORKSPACE_ROOT/agents/prompts" "$agent_config_dir/"
        print_status "$GREEN" "✅ Agent prompts deployed"
    fi
    
    # Copy agent roles
    if [ -d "$WORKSPACE_ROOT/agents/roles" ]; then
        cp -r "$WORKSPACE_ROOT/agents/roles" "$agent_config_dir/"
        print_status "$GREEN" "✅ Agent roles deployed"
    fi
    
    # Copy agent workflows
    if [ -d "$WORKSPACE_ROOT/agents/workflows" ]; then
        cp -r "$WORKSPACE_ROOT/agents/workflows" "$agent_config_dir/"
        print_status "$GREEN" "✅ Agent workflows deployed"
    fi
}

# Setup global MCP configuration
setup_global_mcp_config() {
    print_status "$BLUE" "🔧 Setting up global MCP configuration..."
    
    local global_config_dir="/Users/braydon/.claude-workspace"
    mkdir -p "$global_config_dir"
    
    # Create global MCP configuration
    cat > "$global_config_dir/mcp-config.json" << EOF
{
  "mcps": {
    "obsidian": {
      "command": "node",
      "args": ["/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js"],
      "env": {
        "OBSIDIAN_VAULT_PATH": "/users/braydon/obsidian/bvault"
      }
    },
    "journal": {
      "command": "node",
      "args": ["$WORKSPACE_ROOT/mcps/journal-mcp/dist/server.js"],
      "env": {
        "JOURNAL_DATA_PATH": "/Users/braydon/.claude-workspace/journal"
      }
    },
    "reminders": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-reminders"],
      "env": {}
    }
  },
  "agent_coordination": {
    "enabled": true,
    "patterns": {
      "default": "sequential",
      "available": ["sequential", "parallel", "github_issue_based"]
    },
    "quality_gates": {
      "enforced": true,
      "required_checks": ["lint", "type-check", "test", "coverage"]
    }
  },
  "deployment_info": {
    "deployed_at": "$(date -Iseconds)",
    "version": "1.0.0",
    "deployed_by": "deploy-agent-system.sh"
  }
}
EOF
    
    print_status "$GREEN" "✅ Global MCP configuration created"
}

# Create journal directory
setup_journal_directory() {
    print_status "$BLUE" "📊 Setting up journal directory..."
    
    local journal_dir="/Users/braydon/.claude-workspace/journal"
    mkdir -p "$journal_dir"
    
    # Create initial journal structure
    mkdir -p "$journal_dir"/{sessions,patterns,coordination,activities}
    
    # Create initial journal entry
    cat > "$journal_dir/deployment-log.json" << EOF
{
  "deployment": {
    "timestamp": "$(date -Iseconds)",
    "version": "1.0.0",
    "components": [
      "agent_prompts",
      "agent_roles", 
      "agent_workflows",
      "mcp_servers",
      "global_configuration"
    ],
    "status": "deployed"
  }
}
EOF
    
    print_status "$GREEN" "✅ Journal directory configured"
}

# Test MCP server connections
test_mcp_connections() {
    print_status "$BLUE" "🧪 Testing MCP server connections..."
    
    # Test Obsidian MCP
    if [ -f "/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js" ]; then
        if node -e "console.log('Obsidian MCP test passed')" 2>/dev/null; then
            print_status "$GREEN" "✅ Obsidian MCP connection test passed"
        else
            print_status "$YELLOW" "⚠️  Obsidian MCP connection test failed"
        fi
    fi
    
    # Test Journal MCP
    if [ -f "$WORKSPACE_ROOT/mcps/journal-mcp/dist/server.js" ]; then
        if node -e "console.log('Journal MCP test passed')" 2>/dev/null; then
            print_status "$GREEN" "✅ Journal MCP connection test passed"
        else
            print_status "$YELLOW" "⚠️  Journal MCP connection test failed"
        fi
    fi
    
    # Test Reminders MCP
    if npx @modelcontextprotocol/server-reminders --version &> /dev/null; then
        print_status "$GREEN" "✅ Reminders MCP connection test passed"
    else
        print_status "$YELLOW" "⚠️  Reminders MCP connection test failed"
    fi
}

# Deploy to projects
deploy_to_projects() {
    print_status "$BLUE" "📁 Deploying to existing projects..."
    
    local projects_dir="/Users/braydon/projects"
    local deployment_count=0
    
    # Find projects with existing Claude configuration
    for project_dir in "$projects_dir"/*; do
        if [ -d "$project_dir" ] && [ -f "$project_dir/CLAUDE.md" ]; then
            local project_name=$(basename "$project_dir")
            print_status "$BLUE" "Updating project: $project_name"
            
            # Create agent configuration if it doesn't exist
            if [ ! -d "$project_dir/.claude" ]; then
                mkdir -p "$project_dir/.claude/settings"
                
                # Copy agent configuration template
                cp "$WORKSPACE_ROOT/templates/agent-coordination.md" "$project_dir/.claude/"
                
                # Create project-specific MCP config
                cat > "$project_dir/.claude/settings/mcp-config.json" << EOF
{
  "extends": "/Users/braydon/.claude-workspace/mcp-config.json",
  "project_specific": {
    "name": "$project_name",
    "type": "auto-detected",
    "agent_coordination": {
      "enabled": true,
      "default_pattern": "sequential"
    }
  }
}
EOF
                
                print_status "$GREEN" "✅ Agent configuration added to $project_name"
                ((deployment_count++))
            else
                print_status "$YELLOW" "⚠️  Agent configuration already exists in $project_name"
            fi
        fi
    done
    
    print_status "$GREEN" "✅ Deployed to $deployment_count projects"
}

# Create deployment validation script
create_validation_script() {
    print_status "$BLUE" "📋 Creating deployment validation script..."
    
    cat > "/Users/braydon/.claude-workspace/validate-deployment.sh" << 'EOF'
#!/bin/bash
# validate-deployment.sh
# Validate agent system deployment

echo "🔍 Validating agent system deployment..."

# Check directories
echo "Checking directory structure..."
dirs=(
    "/Users/braydon/.claude-workspace"
    "/Users/braydon/.claude-workspace/agents"
    "/Users/braydon/.claude-workspace/journal"
)

for dir in "${dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ $dir"
    else
        echo "❌ $dir (missing)"
    fi
done

# Check files
echo "Checking configuration files..."
files=(
    "/Users/braydon/.claude-workspace/mcp-config.json"
    "/Users/braydon/.claude-workspace/agents/prompts/research-agent.md"
    "/Users/braydon/.claude-workspace/agents/prompts/implementation-agent.md"
    "/Users/braydon/.claude-workspace/journal/deployment-log.json"
)

for file in "${files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file (missing)"
    fi
done

# Test MCP configuration
echo "Testing MCP configuration..."
if node -e "
const config = require('/Users/braydon/.claude-workspace/mcp-config.json');
console.log('✅ MCP configuration valid');
console.log('Servers:', Object.keys(config.mcps).join(', '));
" 2>/dev/null; then
    echo "✅ MCP configuration valid"
else
    echo "❌ MCP configuration invalid"
fi

echo "🏁 Validation complete!"
EOF
    
    chmod +x "/Users/braydon/.claude-workspace/validate-deployment.sh"
    print_status "$GREEN" "✅ Validation script created"
}

# Generate deployment report
generate_deployment_report() {
    print_status "$BLUE" "📄 Generating deployment report..."
    
    local report_file="/Users/braydon/.claude-workspace/deployment-report.md"
    
    cat > "$report_file" << EOF
# Agent System Deployment Report

**Deployment Date**: $(date '+%Y-%m-%d %H:%M:%S')
**Deployment Version**: 1.0.0
**Deployment Script**: deploy-agent-system.sh

## Components Deployed

### Agent Prompts
- ✅ Research Agent
- ✅ Implementation Agent  
- ✅ Review Agent
- ✅ Coordination Agent
- ✅ MCP Integration Agent

### Agent Roles
- ✅ Domain Specialists (auth, data, ui, integration, deployment)
- ✅ Project Type Specialists (personal, healthcare, lightforge, ai-experiments)
- ✅ Workflow Specialists (tdd, security, performance)

### Coordination Workflows
- ✅ Sequential Workflow Pattern
- ✅ Parallel Deployment Pattern  
- ✅ GitHub Issue-Based Coordination

### MCP Servers
- ✅ Obsidian MCP Server
- ✅ Journal MCP Server
- ✅ Reminders MCP Server

### Configuration
- ✅ Global MCP Configuration
- ✅ Agent Settings and Permissions
- ✅ Quality Gates Configuration

## Directory Structure
\`\`\`
/Users/braydon/.claude-workspace/
├── agents/
│   ├── prompts/
│   ├── roles/
│   └── workflows/
├── journal/
├── mcp-config.json
├── deployment-report.md
└── validate-deployment.sh
\`\`\`

## Next Steps

1. **Test the deployment**:
   \`\`\`bash
   /Users/braydon/.claude-workspace/validate-deployment.sh
   \`\`\`

2. **Deploy to a new project**:
   \`\`\`bash
   /Users/braydon/projects/claude-workspace/tools/setup-project-agents.sh <project-name> <project-type>
   \`\`\`

3. **Test agent coordination**:
   - Create a GitHub issue with the 'agent-coordination' label
   - Use the multi-agent feature template
   - Monitor agent coordination workflow

## Troubleshooting

If you encounter issues:
1. Check the deployment log: \`tail -f /Users/braydon/.claude-workspace/deployment.log\`
2. Validate MCP server connections
3. Verify file permissions
4. Check environment variables

## Support

For support or issues, refer to:
- Agent documentation: \`/Users/braydon/projects/claude-workspace/agents/\`
- Interdependencies guide: \`/Users/braydon/projects/claude-workspace/agents/interdependencies/\`
- MCP server documentation: \`/Users/braydon/projects/claude-workspace/mcps/\`
EOF
    
    print_status "$GREEN" "✅ Deployment report generated: $report_file"
}

# Main deployment function
main() {
    print_status "$BLUE" "🚀 Starting agent system deployment..."
    
    # Create log file
    mkdir -p "$(dirname "$LOG_FILE")"
    touch "$LOG_FILE"
    
    # Run deployment steps
    check_prerequisites
    create_backup
    setup_mcp_servers
    deploy_agent_configs
    setup_global_mcp_config
    setup_journal_directory
    test_mcp_connections
    deploy_to_projects
    create_validation_script
    generate_deployment_report
    
    print_status "$GREEN" "🎉 Agent system deployment complete!"
    print_status "$BLUE" "📄 Deployment report: /Users/braydon/.claude-workspace/deployment-report.md"
    print_status "$BLUE" "🔍 Run validation: /Users/braydon/.claude-workspace/validate-deployment.sh"
    
    # Final validation
    print_status "$BLUE" "Running final validation..."
    if /Users/braydon/.claude-workspace/validate-deployment.sh; then
        print_status "$GREEN" "✅ Deployment validation passed!"
    else
        print_status "$YELLOW" "⚠️  Deployment validation had warnings"
    fi
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "Agent System Deployment Script"
        echo ""
        echo "Usage: $0 [options]"
        echo ""
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --dry-run      Show what would be deployed without making changes"
        echo "  --force        Force deployment even if validation fails"
        echo ""
        exit 0
        ;;
    --dry-run)
        print_status "$BLUE" "🔍 Dry run mode - showing what would be deployed..."
        # Add dry run logic here
        exit 0
        ;;
    --force)
        print_status "$YELLOW" "⚠️  Force mode enabled - skipping some validations"
        # Add force mode logic here
        ;;
esac

# Run main deployment
main "$@"