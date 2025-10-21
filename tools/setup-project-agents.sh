#!/bin/bash
# setup-project-agents.sh
# Set up agent coordination for a specific project

set -e

# Configuration
WORKSPACE_ROOT="/Users/braydon/projects/claude-workspace"
AGENT_CONFIG_DIR="/Users/braydon/.claude-workspace/agents"
LOG_FILE="/Users/braydon/.claude-workspace/project-setup.log"

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

# Show usage
show_usage() {
    cat << EOF
Agent Coordination Project Setup

Usage: $0 <project_path> <project_type> [options]

Arguments:
  project_path    Path to the project directory
  project_type    Type of project (personal, work, experiments)

Options:
  --pattern       Coordination pattern (sequential, parallel, github_issue_based)
  --agents        Comma-separated list of required agents
  --force         Overwrite existing configuration
  --dry-run       Show what would be created without making changes
  --help, -h      Show this help message

Project Types:
  personal        Personal productivity projects (React, Next.js)
  work           Work projects (healthcare, lightforge, enterprise)
  experiments    AI experiments and research projects

Examples:
  $0 /Users/braydon/projects/my-app personal
  $0 /Users/braydon/projects/healthcare-dashboard work --pattern parallel
  $0 /Users/braydon/projects/ai-experiment experiments --agents research,coordination,ai
EOF
}

# Parse command line arguments
parse_arguments() {
    PROJECT_PATH=""
    PROJECT_TYPE=""
    COORDINATION_PATTERN="sequential"
    REQUIRED_AGENTS=""
    FORCE_OVERWRITE=false
    DRY_RUN=false
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            --pattern)
                COORDINATION_PATTERN="$2"
                shift 2
                ;;
            --agents)
                REQUIRED_AGENTS="$2"
                shift 2
                ;;
            --force)
                FORCE_OVERWRITE=true
                shift
                ;;
            --dry-run)
                DRY_RUN=true
                shift
                ;;
            --help|-h)
                show_usage
                exit 0
                ;;
            -*)
                echo "Unknown option: $1"
                show_usage
                exit 1
                ;;
            *)
                if [ -z "$PROJECT_PATH" ]; then
                    PROJECT_PATH="$1"
                elif [ -z "$PROJECT_TYPE" ]; then
                    PROJECT_TYPE="$1"
                else
                    echo "Too many arguments"
                    show_usage
                    exit 1
                fi
                shift
                ;;
        esac
    done
    
    # Validate required arguments
    if [ -z "$PROJECT_PATH" ] || [ -z "$PROJECT_TYPE" ]; then
        echo "Error: PROJECT_PATH and PROJECT_TYPE are required"
        show_usage
        exit 1
    fi
    
    # Validate project type
    case "$PROJECT_TYPE" in
        personal|work|experiments)
            ;;
        *)
            echo "Error: Invalid project type '$PROJECT_TYPE'"
            echo "Valid types: personal, work, experiments"
            exit 1
            ;;
    esac
    
    # Validate coordination pattern
    case "$COORDINATION_PATTERN" in
        sequential|parallel|github_issue_based)
            ;;
        *)
            echo "Error: Invalid coordination pattern '$COORDINATION_PATTERN'"
            echo "Valid patterns: sequential, parallel, github_issue_based"
            exit 1
            ;;
    esac
}

# Validate project directory
validate_project() {
    print_status "$BLUE" "🔍 Validating project directory..."
    
    # Check if directory exists
    if [ ! -d "$PROJECT_PATH" ]; then
        print_status "$RED" "❌ Project directory does not exist: $PROJECT_PATH"
        exit 1
    fi
    
    # Get project name
    PROJECT_NAME=$(basename "$PROJECT_PATH")
    print_status "$GREEN" "✅ Project directory found: $PROJECT_NAME"
    
    # Check if it looks like a development project
    if [ -f "$PROJECT_PATH/package.json" ]; then
        print_status "$GREEN" "✅ Node.js project detected"
        HAS_PACKAGE_JSON=true
    elif [ -f "$PROJECT_PATH/requirements.txt" ]; then
        print_status "$GREEN" "✅ Python project detected"
        HAS_PYTHON=true
    else
        print_status "$YELLOW" "⚠️  No package.json or requirements.txt found"
    fi
    
    # Check for existing Claude configuration
    if [ -f "$PROJECT_PATH/CLAUDE.md" ]; then
        if [ "$FORCE_OVERWRITE" = true ]; then
            print_status "$YELLOW" "⚠️  Existing CLAUDE.md will be overwritten"
        else
            print_status "$RED" "❌ CLAUDE.md already exists. Use --force to overwrite"
            exit 1
        fi
    fi
    
    if [ -d "$PROJECT_PATH/.claude" ]; then
        if [ "$FORCE_OVERWRITE" = true ]; then
            print_status "$YELLOW" "⚠️  Existing .claude directory will be updated"
        else
            print_status "$YELLOW" "⚠️  .claude directory exists. Configuration will be merged"
        fi
    fi
}

# Determine required agents based on project type
determine_agents() {
    print_status "$BLUE" "🤖 Determining required agents..."
    
    if [ -n "$REQUIRED_AGENTS" ]; then
        AGENTS_LIST="$REQUIRED_AGENTS"
        print_status "$GREEN" "✅ Using specified agents: $AGENTS_LIST"
        return
    fi
    
    # Default agents for each project type
    case "$PROJECT_TYPE" in
        personal)
            AGENTS_LIST="research,implementation,review"
            OPTIONAL_AGENTS="ui,deployment"
            ;;
        work)
            AGENTS_LIST="research,implementation,security,review,deployment"
            OPTIONAL_AGENTS="auth,data,ui"
            ;;
        experiments)
            AGENTS_LIST="research,coordination,implementation,review"
            OPTIONAL_AGENTS="ai,data"
            ;;
    esac
    
    print_status "$GREEN" "✅ Required agents: $AGENTS_LIST"
    if [ -n "$OPTIONAL_AGENTS" ]; then
        print_status "$BLUE" "ℹ️  Optional agents: $OPTIONAL_AGENTS"
    fi
}

# Detect tech stack
detect_tech_stack() {
    print_status "$BLUE" "🔧 Detecting technology stack..."
    
    TECH_STACK=""
    
    # Check package.json for Node.js dependencies
    if [ -f "$PROJECT_PATH/package.json" ]; then
        if grep -q '"react"' "$PROJECT_PATH/package.json"; then
            TECH_STACK="$TECH_STACK,React"
        fi
        if grep -q '"next"' "$PROJECT_PATH/package.json"; then
            TECH_STACK="$TECH_STACK,Next.js"
        fi
        if grep -q '"typescript"' "$PROJECT_PATH/package.json"; then
            TECH_STACK="$TECH_STACK,TypeScript"
        fi
        if grep -q '"express"' "$PROJECT_PATH/package.json"; then
            TECH_STACK="$TECH_STACK,Express"
        fi
    fi
    
    # Check for Python
    if [ -f "$PROJECT_PATH/requirements.txt" ]; then
        TECH_STACK="$TECH_STACK,Python"
        if grep -q "fastapi" "$PROJECT_PATH/requirements.txt"; then
            TECH_STACK="$TECH_STACK,FastAPI"
        fi
        if grep -q "langchain" "$PROJECT_PATH/requirements.txt"; then
            TECH_STACK="$TECH_STACK,LangChain"
        fi
    fi
    
    # Remove leading comma
    TECH_STACK="${TECH_STACK#,}"
    
    if [ -n "$TECH_STACK" ]; then
        print_status "$GREEN" "✅ Detected tech stack: $TECH_STACK"
    else
        TECH_STACK="Unknown"
        print_status "$YELLOW" "⚠️  Could not detect tech stack"
    fi
}

# Create Claude directory structure
create_claude_structure() {
    print_status "$BLUE" "📁 Creating Claude directory structure..."
    
    if [ "$DRY_RUN" = true ]; then
        print_status "$BLUE" "[DRY RUN] Would create directory structure"
        return
    fi
    
    # Create .claude directory structure
    mkdir -p "$PROJECT_PATH/.claude"/{memories/{base,workflows,project-specific},settings}
    
    # Copy base memory files
    cp -r "$WORKSPACE_ROOT/memories/base"/* "$PROJECT_PATH/.claude/memories/base/"
    cp -r "$WORKSPACE_ROOT/memories/workflows"/* "$PROJECT_PATH/.claude/memories/workflows/"
    
    print_status "$GREEN" "✅ Claude directory structure created"
}

# Generate project-specific CLAUDE.md
generate_claude_md() {
    print_status "$BLUE" "📄 Generating CLAUDE.md..."
    
    if [ "$DRY_RUN" = true ]; then
        print_status "$BLUE" "[DRY RUN] Would generate CLAUDE.md"
        return
    fi
    
    cat > "$PROJECT_PATH/CLAUDE.md" << EOF
# $PROJECT_NAME - Claude Memory

@./.claude/memories/base/interaction-style.md
@./.claude/memories/base/core-principles.md
@./.claude/memories/base/code-standards.md
@./.claude/memories/workflows/tdd.md
@./.claude/memories/workflows/agent-coordination.md
@./.claude/memories/project-specific/architecture.md

## Project Overview
**Type**: $PROJECT_TYPE
**Tech Stack**: $TECH_STACK
**Agent Coordination**: Enabled
**Primary Pattern**: $COORDINATION_PATTERN

## Agent Configuration
**Required Agents**: $AGENTS_LIST
**MCP Servers**: obsidian, journal, reminders

## Quality Standards
- **Test Coverage**: >90% for core logic
- **Performance**: <500ms response times
- **Security**: Comprehensive security review required
- **Documentation**: Maintained and current

## Coordination Notes
- Pattern: $COORDINATION_PATTERN workflow
- Quality gates enforced for all agents
- MCP integration for context sharing

## Success Metrics
- Agent coordination effectiveness: >95%
- Quality gate pass rate: >98%
- Feature delivery optimization through multi-agent coordination
- Maintained code quality and performance standards

---
**Agent Coordination Enabled**: This project uses the claude-workspace agent coordination system.
EOF
    
    print_status "$GREEN" "✅ CLAUDE.md generated"
}

# Create MCP configuration
create_mcp_config() {
    print_status "$BLUE" "⚙️  Creating MCP configuration..."
    
    if [ "$DRY_RUN" = true ]; then
        print_status "$BLUE" "[DRY RUN] Would create MCP configuration"
        return
    fi
    
    cat > "$PROJECT_PATH/.claude/settings/mcp-config.json" << EOF
{
  "extends": "/Users/braydon/.claude-workspace/mcp-config.json",
  "project_specific": {
    "name": "$PROJECT_NAME",
    "type": "$PROJECT_TYPE",
    "tech_stack": "$TECH_STACK",
    "agent_coordination": {
      "enabled": true,
      "default_pattern": "$COORDINATION_PATTERN",
      "required_agents": "$AGENTS_LIST"
    },
    "quality_gates": {
      "lint_command": "npm run lint",
      "type_check_command": "npm run type-check",
      "test_command": "npm test",
      "coverage_command": "npm run test:coverage"
    }
  },
  "environment": {
    "project_path": "$PROJECT_PATH",
    "project_name": "$PROJECT_NAME"
  }
}
EOF
    
    print_status "$GREEN" "✅ MCP configuration created"
}

# Create project-specific architecture documentation
create_architecture_docs() {
    print_status "$BLUE" "📋 Creating architecture documentation..."
    
    if [ "$DRY_RUN" = true ]; then
        print_status "$BLUE" "[DRY RUN] Would create architecture documentation"
        return
    fi
    
    cat > "$PROJECT_PATH/.claude/memories/project-specific/architecture.md" << EOF
# $PROJECT_NAME Architecture

## Project Overview
- **Name**: $PROJECT_NAME
- **Type**: $PROJECT_TYPE
- **Tech Stack**: $TECH_STACK
- **Coordination Pattern**: $COORDINATION_PATTERN

## Technology Stack
$TECH_STACK

## Agent Coordination
### Required Agents
$(echo "$AGENTS_LIST" | tr ',' '\n' | sed 's/^/- @/' | sed 's/$/-agent/')

### Coordination Pattern
**Pattern**: $COORDINATION_PATTERN

**Workflow**: 
$(case "$COORDINATION_PATTERN" in
    sequential)
        echo "1. Research agent analyzes requirements"
        echo "2. Implementation agent develops with TDD"
        echo "3. Review agent validates quality"
        echo "4. Deployment agent handles production"
        ;;
    parallel)
        echo "1. Coordination agent decomposes tasks"
        echo "2. Multiple agents work simultaneously"
        echo "3. Integration agent coordinates results"
        echo "4. Review agent validates overall quality"
        ;;
    github_issue_based)
        echo "1. GitHub issues track agent coordination"
        echo "2. Automated workflow triggers"
        echo "3. Agent status tracking via labels"
        echo "4. Pull request based integration"
        ;;
esac)

## Quality Gates
- ESLint compliance
- TypeScript strict mode
- Test coverage >90%
- Performance benchmarks
- Security validation

## Integration Points
- MCP servers for context sharing
- GitHub for workflow coordination
- Quality tools for validation

## Dependencies
### Internal
- Claude workspace agent system
- MCP server infrastructure
- Quality gate automation

### External
$(case "$PROJECT_TYPE" in
    personal)
        echo "- Vercel (deployment)"
        echo "- GitHub (repository)"
        echo "- npm (package management)"
        ;;
    work)
        echo "- Enterprise deployment platform"
        echo "- Security scanning tools"
        echo "- Compliance monitoring"
        ;;
    experiments)
        echo "- AI model APIs"
        echo "- Experiment tracking platforms"
        echo "- Research collaboration tools"
        ;;
esac)
EOF
    
    print_status "$GREEN" "✅ Architecture documentation created"
}

# Create GitHub workflow files
create_github_workflows() {
    print_status "$BLUE" "🔧 Creating GitHub workflow files..."
    
    if [ "$DRY_RUN" = true ]; then
        print_status "$BLUE" "[DRY RUN] Would create GitHub workflows"
        return
    fi
    
    # Create .github directory structure
    mkdir -p "$PROJECT_PATH/.github"/{workflows,ISSUE_TEMPLATE,scripts}
    
    # Copy coordination workflows
    if [ -f "$WORKSPACE_ROOT/agents/workflows/github-issue-coordination.md" ]; then
        # Extract GitHub Actions workflow from the markdown
        cat > "$PROJECT_PATH/.github/workflows/agent-coordination.yml" << 'EOF'
name: Agent Coordination

on:
  issues:
    types: [opened, labeled]
  issue_comment:
    types: [created]

jobs:
  coordinate_agents:
    if: contains(github.event.issue.labels.*.name, 'agent-coordination')
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: npm install
        
      - name: Setup MCP servers
        run: |
          if [ -f ".claude/settings/mcp-config.json" ]; then
            echo "MCP configuration found"
          fi
          
      - name: Update coordination status
        run: |
          echo "Agent coordination workflow triggered"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
EOF
    fi
    
    # Create quality gates workflow
    cat > "$PROJECT_PATH/.github/workflows/quality-gates.yml" << EOF
name: Quality Gates

on:
  pull_request:
    branches: [main, develop]
  push:
    branches: [main, develop]

jobs:
  quality_gates:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: npm install
        
$(case "$PROJECT_TYPE" in
    personal|work)
        echo "      - name: Run ESLint"
        echo "        run: npm run lint"
        echo "        "
        echo "      - name: Run TypeScript check"
        echo "        run: npm run type-check"
        echo "        "
        echo "      - name: Run tests"
        echo "        run: npm test"
        echo "        "
        echo "      - name: Check test coverage"
        echo "        run: npm run test:coverage"
        ;;
    experiments)
        echo "      - name: Run Python tests"
        echo "        run: python -m pytest"
        echo "        "
        echo "      - name: Run TypeScript tests"
        echo "        run: npm test"
        echo "        "
        echo "      - name: AI ethics validation"
        echo "        run: npm run test:ai-ethics"
        ;;
esac)
        
      - name: Build project
        run: npm run build
EOF
    
    # Create issue templates
    cat > "$PROJECT_PATH/.github/ISSUE_TEMPLATE/multi-agent-feature.md" << EOF
---
name: Multi-Agent Feature Development
about: Template for features requiring multiple specialized agents
title: '[FEATURE] '
labels: ['agent-coordination', 'feature', 'multi-agent']
assignees: []
---

## Feature Request
### Description
[Clear description of the feature to implement]

### Requirements
- [ ] User story definition
- [ ] Acceptance criteria
- [ ] Performance requirements
- [ ] Security considerations

### Agent Coordination
**Coordination Pattern**: $COORDINATION_PATTERN
**Required Agents**: $AGENTS_LIST

### Success Criteria
- [ ] All quality gates pass
- [ ] Performance targets met (<500ms response time)
- [ ] Security review approved
- [ ] Documentation updated
- [ ] Tests achieve >90% coverage

---
**Project**: $PROJECT_NAME ($PROJECT_TYPE)
EOF
    
    print_status "$GREEN" "✅ GitHub workflows created"
}

# Update package.json scripts
update_package_scripts() {
    print_status "$BLUE" "📦 Updating package.json scripts..."
    
    if [ ! -f "$PROJECT_PATH/package.json" ]; then
        print_status "$YELLOW" "⚠️  No package.json found, skipping script updates"
        return
    fi
    
    if [ "$DRY_RUN" = true ]; then
        print_status "$BLUE" "[DRY RUN] Would update package.json scripts"
        return
    fi
    
    # Add agent coordination scripts if they don't exist
    local temp_file=$(mktemp)
    
    # Use jq to add scripts if available, otherwise manual approach
    if command -v jq &> /dev/null; then
        jq '.scripts["agent:setup"] = "node .claude/scripts/setup-agents.js"' "$PROJECT_PATH/package.json" > "$temp_file"
        jq '.scripts["agent:validate"] = "node .claude/scripts/validate-agents.js"' "$temp_file" > "$PROJECT_PATH/package.json"
    else
        # Manual approach without jq
        cp "$PROJECT_PATH/package.json" "$temp_file"
        print_status "$YELLOW" "⚠️  jq not available, manual script addition recommended"
    fi
    
    rm -f "$temp_file"
    print_status "$GREEN" "✅ Package.json scripts updated"
}

# Generate setup summary
generate_summary() {
    print_status "$BLUE" "📋 Generating setup summary..."
    
    local summary_file="$PROJECT_PATH/.claude/setup-summary.md"
    
    if [ "$DRY_RUN" = true ]; then
        print_status "$BLUE" "[DRY RUN] Would generate setup summary"
        return
    fi
    
    cat > "$summary_file" << EOF
# Agent Coordination Setup Summary

**Project**: $PROJECT_NAME
**Type**: $PROJECT_TYPE
**Tech Stack**: $TECH_STACK
**Setup Date**: $(date '+%Y-%m-%d %H:%M:%S')

## Configuration
- **Coordination Pattern**: $COORDINATION_PATTERN
- **Required Agents**: $AGENTS_LIST
- **MCP Servers**: obsidian, journal, reminders

## Files Created
- \`CLAUDE.md\` - Main Claude memory configuration
- \`.claude/settings/mcp-config.json\` - MCP server configuration
- \`.claude/memories/project-specific/architecture.md\` - Project architecture
- \`.github/workflows/agent-coordination.yml\` - GitHub workflow
- \`.github/workflows/quality-gates.yml\` - Quality assurance workflow
- \`.github/ISSUE_TEMPLATE/multi-agent-feature.md\` - Issue template

## Next Steps

1. **Test the setup**:
   \`\`\`bash
   cd $PROJECT_PATH
   # Verify CLAUDE.md loads correctly
   # Test MCP configuration
   \`\`\`

2. **Create your first agent-coordinated feature**:
   - Create a GitHub issue using the multi-agent template
   - Add the 'agent-coordination' label
   - Watch the automated workflow begin

3. **Customize the configuration**:
   - Update \`.claude/memories/project-specific/architecture.md\`
   - Modify MCP settings in \`.claude/settings/mcp-config.json\`
   - Adjust quality gates in GitHub workflows

## Agent Usage Examples

### Sequential Pattern
\`\`\`bash
# Research -> Implementation -> Review -> Deploy
# Each agent builds on the previous agent's work
\`\`\`

### Parallel Pattern
\`\`\`bash
# Multiple agents work simultaneously
# Coordination agent manages integration
\`\`\`

### GitHub Issue-Based
\`\`\`bash
# GitHub issues coordinate all agent activities
# Automated status tracking and workflow management
\`\`\`

## Troubleshooting

If you encounter issues:
1. Check MCP server status: \`npm run agent:validate\`
2. Verify GitHub workflow permissions
3. Ensure all required agents are available
4. Check the deployment log: \`/Users/braydon/.claude-workspace/project-setup.log\`

## Support
- Agent documentation: \`/Users/braydon/projects/claude-workspace/agents/\`
- MCP configuration: \`/Users/braydon/.claude-workspace/mcp-config.json\`
- Workspace tools: \`/Users/braydon/projects/claude-workspace/tools/\`
EOF
    
    print_status "$GREEN" "✅ Setup summary generated: $summary_file"
}

# Main setup function
main() {
    print_status "$BLUE" "🚀 Setting up agent coordination for $PROJECT_NAME..."
    
    # Create log file
    mkdir -p "$(dirname "$LOG_FILE")"
    touch "$LOG_FILE"
    
    # Run setup steps
    validate_project
    determine_agents
    detect_tech_stack
    
    if [ "$DRY_RUN" = true ]; then
        print_status "$BLUE" "🔍 DRY RUN - No changes will be made"
        print_status "$BLUE" "Would setup:"
        print_status "$BLUE" "  - Project: $PROJECT_NAME ($PROJECT_TYPE)"
        print_status "$BLUE" "  - Tech Stack: $TECH_STACK"  
        print_status "$BLUE" "  - Pattern: $COORDINATION_PATTERN"
        print_status "$BLUE" "  - Agents: $AGENTS_LIST"
    fi
    
    create_claude_structure
    generate_claude_md
    create_mcp_config
    create_architecture_docs
    create_github_workflows
    update_package_scripts
    generate_summary
    
    if [ "$DRY_RUN" = false ]; then
        print_status "$GREEN" "🎉 Agent coordination setup complete for $PROJECT_NAME!"
        print_status "$BLUE" "📄 Setup summary: $PROJECT_PATH/.claude/setup-summary.md"
        print_status "$BLUE" "📋 Next: Create a GitHub issue with 'agent-coordination' label to test"
    fi
}

# Parse arguments and run
parse_arguments "$@"
main