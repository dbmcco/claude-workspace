#!/bin/bash

# Claude Workspace Setup Tool
# Deploys the modular Claude Code memory system to a target directory

set -e

# Configuration
TARGET_DIR=${1:-".claude"}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKSPACE_DIR="$(dirname "$SCRIPT_DIR")"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Main deployment function
deploy_workspace() {
    log_info "Deploying Claude Workspace to $TARGET_DIR"
    
    # Check if target directory exists
    if [ -d "$TARGET_DIR" ]; then
        log_warn "Target directory $TARGET_DIR already exists"
        read -p "Do you want to backup and replace it? (y/N): " -n 1 -r
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            backup_dir="${TARGET_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
            log_info "Backing up existing directory to $backup_dir"
            mv "$TARGET_DIR" "$backup_dir"
        else
            log_error "Deployment cancelled"
            exit 1
        fi
    fi
    
    # Create target directory
    mkdir -p "$TARGET_DIR"
    
    # Copy core components
    log_info "Copying memory modules..."
    cp -r "$WORKSPACE_DIR/memories" "$TARGET_DIR/"
    
    log_info "Copying settings templates..."
    cp -r "$WORKSPACE_DIR/settings" "$TARGET_DIR/"
    
    log_info "Copying tools..."
    cp -r "$WORKSPACE_DIR/tools" "$TARGET_DIR/"
    
    log_info "Copying templates for reference..."
    cp -r "$WORKSPACE_DIR/templates" "$TARGET_DIR/"
    
    # Copy root CLAUDE.md
    log_info "Copying root CLAUDE.md..."
    cp "$WORKSPACE_DIR/CLAUDE.md" "$TARGET_DIR/"
    
    log_info "✅ Claude Workspace deployed successfully to $TARGET_DIR"
}

# Create category-level templates
create_category_templates() {
    log_info "Creating category-level memory templates..."
    
    # Personal category template
    cat > personal-CLAUDE.md.template << 'EOF'
# Personal Projects Memory

@../.claude/memories/base/interaction-style.md
@../.claude/memories/base/core-principles.md
@../.claude/memories/base/code-standards.md
@../.claude/memories/base/version-control.md
@../.claude/memories/workflows/tdd.md
@../.claude/memories/workflows/llm-driven-development.md
@../.claude/memories/project-types/personal.md

## Personal Project Context

These are productivity and personal finance tools, typically full-stack JavaScript/TypeScript applications focused on:
- Personal finance management and analysis
- Home automation and productivity tools
- Data analysis and visualization for personal use
- Real-world, practical applications for daily life

## Common Technologies
- Frontend: React, Next.js, TypeScript
- Backend: Node.js, PostgreSQL, Prisma
- Data: Excel/CSV processing, API integrations
- Testing: Jest, React Testing Library
- Real data patterns over mock data

[See individual project CLAUDE.md files for specific context]
EOF

    # Experiments category template
    cat > experiments-CLAUDE.md.template << 'EOF'
# Experiments Projects Memory

@../.claude/memories/base/interaction-style.md
@../.claude/memories/base/core-principles.md
@../.claude/memories/base/code-standards.md
@../.claude/memories/base/version-control.md
@../.claude/memories/workflows/tdd.md
@../.claude/memories/workflows/llm-driven-development.md
@../.claude/memories/project-types/experiments.md

## Experiments Project Context

These are AI agent frameworks and experimental development approaches, typically Python-heavy with TDD focus on:
- Multi-agent systems and coordination
- LLM-driven development pipelines
- Automated code generation and testing
- Research and proof-of-concept implementations

## Common Technologies
- Python with strict typing and TDD
- Agent frameworks (AutoGen, custom implementations)
- LLM integrations (Claude, OpenAI)
- Test coverage >90% required
- Extensive documentation and examples

## Development Philosophy
- Test-driven development is mandatory
- Experimental but production-quality code
- Heavy emphasis on automation and tooling
- Research-oriented with practical applications

[See individual project CLAUDE.md files for specific context]
EOF

    # Work category template
    cat > work-CLAUDE.md.template << 'EOF'
# Work Projects Memory

@../.claude/memories/base/interaction-style.md
@../.claude/memories/base/core-principles.md
@../.claude/memories/base/code-standards.md
@../.claude/memories/base/version-control.md
@../.claude/memories/workflows/tdd.md
@../.claude/memories/workflows/llm-driven-development.md
@../.claude/memories/project-types/work.md

## Work Project Context

These are professional applications with compliance focus, mixed stack development including:
- Healthcare analytics and specialized systems
- Client dashboards and business intelligence
- Financial modeling and analysis tools
- Enterprise-grade applications with security requirements

## Common Technologies
- Mixed stack: Node.js, Python, React
- Database: PostgreSQL, specialized databases
- APIs: RESTful services, enterprise integrations
- Security: Compliance requirements, data protection
- Testing: Comprehensive coverage with real-world data patterns

## Compliance Requirements
- Security-first development approach
- Audit trails and logging requirements
- Data privacy and protection standards
- Industry-specific compliance (HIPAA, etc.)

[See individual project CLAUDE.md files for specific context]
EOF

    log_info "Category templates created:"
    log_info "  - personal-CLAUDE.md.template"
    log_info "  - experiments-CLAUDE.md.template"
    log_info "  - work-CLAUDE.md.template"
}

# Display usage instructions
show_usage() {
    echo "Usage: $0 [target_directory]"
    echo ""
    echo "Deploys Claude Workspace to the specified directory (default: .claude)"
    echo ""
    echo "After deployment:"
    echo "1. Copy category templates to create category-level memories"
    echo "2. Create project-level CLAUDE.md files using templates/"
    echo "3. Test with: cd your-project && claude && /memory"
    echo ""
    echo "Examples:"
    echo "  $0                    # Deploy to .claude/"
    echo "  $0 my-claude-config   # Deploy to my-claude-config/"
}

# Validate deployment
validate_deployment() {
    log_info "Validating deployment..."
    
    local required_files=(
        "$TARGET_DIR/CLAUDE.md"
        "$TARGET_DIR/memories/base/interaction-style.md"
        "$TARGET_DIR/memories/workflows/tdd.md"
        "$TARGET_DIR/settings"
        "$TARGET_DIR/tools"
        "$TARGET_DIR/templates"
    )
    
    for file in "${required_files[@]}"; do
        if [ ! -e "$file" ]; then
            log_error "Missing required file/directory: $file"
            exit 1
        fi
    done
    
    log_info "✅ Deployment validation passed"
}

# Main execution
main() {
    if [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
        show_usage
        exit 0
    fi
    
    log_info "Claude Workspace Setup Tool"
    log_info "Source: $WORKSPACE_DIR"
    log_info "Target: $TARGET_DIR"
    echo
    
    deploy_workspace
    validate_deployment
    create_category_templates
    
    echo
    log_info "🎉 Setup complete!"
    echo
    echo "Next steps:"
    echo "1. Create category-level memories using the templates created"
    echo "2. Create project-level CLAUDE.md files using templates/ as reference"
    echo "3. Test memory loading: cd your-project && claude && /memory"
    echo
    echo "See README.md for detailed usage instructions."
}

# Run main function
main "$@"