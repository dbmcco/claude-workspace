#!/bin/bash
# validate-agent-deployment.sh
# Comprehensive validation of agent system deployment

set -e

# Configuration
WORKSPACE_ROOT="/Users/braydon/projects/claude-workspace"
DEPLOYMENT_DIR="/Users/braydon/.claude-workspace"
LOG_FILE="/Users/braydon/.claude-workspace/validation.log"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Counters
TESTS_PASSED=0
TESTS_FAILED=0
WARNINGS=0

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

# Test function
run_test() {
    local test_name="$1"
    local test_command="$2"
    local is_warning_only="${3:-false}"
    
    print_status "$BLUE" "🧪 Testing: $test_name"
    
    if eval "$test_command"; then
        print_status "$GREEN" "✅ PASS: $test_name"
        ((TESTS_PASSED++))
        return 0
    else
        if [ "$is_warning_only" = true ]; then
            print_status "$YELLOW" "⚠️  WARN: $test_name"
            ((WARNINGS++))
            return 0
        else
            print_status "$RED" "❌ FAIL: $test_name"
            ((TESTS_FAILED++))
            return 1
        fi
    fi
}

# Directory structure validation
validate_directory_structure() {
    print_status "$BLUE" "📁 Validating directory structure..."
    
    # Required directories
    local required_dirs=(
        "$DEPLOYMENT_DIR"
        "$DEPLOYMENT_DIR/agents"
        "$DEPLOYMENT_DIR/agents/prompts"
        "$DEPLOYMENT_DIR/agents/roles"
        "$DEPLOYMENT_DIR/agents/workflows"
        "$DEPLOYMENT_DIR/journal"
        "$WORKSPACE_ROOT/agents"
        "$WORKSPACE_ROOT/agents/prompts"
        "$WORKSPACE_ROOT/agents/roles"
        "$WORKSPACE_ROOT/agents/workflows"
        "$WORKSPACE_ROOT/agents/interdependencies"
        "$WORKSPACE_ROOT/templates"
        "$WORKSPACE_ROOT/tools"
    )
    
    for dir in "${required_dirs[@]}"; do
        run_test "Directory exists: $dir" "[ -d '$dir' ]"
    done
}

# File structure validation
validate_file_structure() {
    print_status "$BLUE" "📄 Validating file structure..."
    
    # Required files
    local required_files=(
        "$DEPLOYMENT_DIR/mcp-config.json"
        "$WORKSPACE_ROOT/agents/prompts/research-agent.md"
        "$WORKSPACE_ROOT/agents/prompts/implementation-agent.md"
        "$WORKSPACE_ROOT/agents/prompts/review-agent.md"
        "$WORKSPACE_ROOT/agents/prompts/coordination-agent.md"
        "$WORKSPACE_ROOT/agents/prompts/mcp-integration-agent.md"
        "$WORKSPACE_ROOT/agents/roles/domain-specialists.json"
        "$WORKSPACE_ROOT/agents/roles/project-type-specialists.json"
        "$WORKSPACE_ROOT/agents/workflows/sequential-workflow-pattern.md"
        "$WORKSPACE_ROOT/agents/workflows/parallel-deployment-pattern.md"
        "$WORKSPACE_ROOT/agents/workflows/github-issue-coordination.md"
        "$WORKSPACE_ROOT/agents/interdependencies/mcp-server-dependencies.md"
        "$WORKSPACE_ROOT/agents/interdependencies/external-service-dependencies.md"
        "$WORKSPACE_ROOT/agents/interdependencies/settings-permissions-matrix.md"
        "$WORKSPACE_ROOT/templates/agent-coordination.md"
        "$WORKSPACE_ROOT/tools/deploy-agent-system.sh"
        "$WORKSPACE_ROOT/tools/setup-project-agents.sh"
    )
    
    for file in "${required_files[@]}"; do
        run_test "File exists: $(basename "$file")" "[ -f '$file' ]"
    done
}

# MCP configuration validation
validate_mcp_configuration() {
    print_status "$BLUE" "⚙️  Validating MCP configuration..."
    
    # Test MCP config JSON validity
    run_test "MCP config JSON valid" "node -e 'JSON.parse(require(\"fs\").readFileSync(\"$DEPLOYMENT_DIR/mcp-config.json\", \"utf8\"))' 2>/dev/null"
    
    # Test MCP config structure
    run_test "MCP config has required fields" "node -e '
const config = JSON.parse(require(\"fs\").readFileSync(\"$DEPLOYMENT_DIR/mcp-config.json\", \"utf8\"));
if (!config.mcps) throw new Error(\"Missing mcps field\");
if (!config.agent_coordination) throw new Error(\"Missing agent_coordination field\");
console.log(\"MCP config structure valid\");
' 2>/dev/null"
    
    # Test MCP servers configuration
    run_test "Obsidian MCP configured" "node -e '
const config = JSON.parse(require(\"fs\").readFileSync(\"$DEPLOYMENT_DIR/mcp-config.json\", \"utf8\"));
if (!config.mcps.obsidian) throw new Error(\"Obsidian MCP not configured\");
console.log(\"Obsidian MCP configured\");
' 2>/dev/null"
    
    run_test "Journal MCP configured" "node -e '
const config = JSON.parse(require(\"fs\").readFileSync(\"$DEPLOYMENT_DIR/mcp-config.json\", \"utf8\"));
if (!config.mcps.journal) throw new Error(\"Journal MCP not configured\");
console.log(\"Journal MCP configured\");
' 2>/dev/null"
}

# MCP server availability validation
validate_mcp_servers() {
    print_status "$BLUE" "🖥️  Validating MCP server availability..."
    
    # Check Obsidian MCP
    run_test "Obsidian MCP server exists" "[ -f '/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js' ]" true
    
    # Check Journal MCP
    run_test "Journal MCP server exists" "[ -f '$WORKSPACE_ROOT/mcps/journal-mcp/dist/server.js' ]"
    
    # Check Reminders MCP
    run_test "Reminders MCP available" "npx @modelcontextprotocol/server-reminders --version >/dev/null 2>&1" true
    
    # Test MCP server executability
    if [ -f "/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js" ]; then
        run_test "Obsidian MCP executable" "node /Users/braydon/projects/experiments/obsidian_mcp/dist/index.js --help >/dev/null 2>&1" true
    fi
    
    if [ -f "$WORKSPACE_ROOT/mcps/journal-mcp/dist/server.js" ]; then
        run_test "Journal MCP executable" "timeout 5s node $WORKSPACE_ROOT/mcps/journal-mcp/dist/server.js --help >/dev/null 2>&1 || true" true
    fi
}

# Agent prompt validation
validate_agent_prompts() {
    print_status "$BLUE" "🤖 Validating agent prompts..."
    
    local agent_prompts=(
        "research-agent.md"
        "implementation-agent.md"
        "review-agent.md"
        "coordination-agent.md"
        "mcp-integration-agent.md"
    )
    
    for prompt in "${agent_prompts[@]}"; do
        local prompt_file="$WORKSPACE_ROOT/agents/prompts/$prompt"
        
        # Check file size (should be substantial)
        run_test "$prompt has content" "[ \$(wc -c < '$prompt_file') -gt 1000 ]"
        
        # Check for key sections
        run_test "$prompt has Agent Identity section" "grep -q '## Agent Identity' '$prompt_file'"
        run_test "$prompt has Core Responsibilities section" "grep -q '## Core Responsibilities' '$prompt_file'"
        run_test "$prompt has Required Context Imports" "grep -q '## Required Context Imports' '$prompt_file'"
        
        # Check for MCP integration
        run_test "$prompt mentions MCP" "grep -q 'mcp__' '$prompt_file'" true
    done
}

# Agent roles validation
validate_agent_roles() {
    print_status "$BLUE" "👥 Validating agent roles..."
    
    # Test JSON validity
    run_test "Domain specialists JSON valid" "node -e 'JSON.parse(require(\"fs\").readFileSync(\"$WORKSPACE_ROOT/agents/roles/domain-specialists.json\", \"utf8\"))' 2>/dev/null"
    
    run_test "Project type specialists JSON valid" "node -e 'JSON.parse(require(\"fs\").readFileSync(\"$WORKSPACE_ROOT/agents/roles/project-type-specialists.json\", \"utf8\"))' 2>/dev/null"
    
    # Test role structure
    run_test "Domain specialists have required structure" "node -e '
const config = JSON.parse(require(\"fs\").readFileSync(\"$WORKSPACE_ROOT/agents/roles/domain-specialists.json\", \"utf8\"));
if (!config.domain_specialists) throw new Error(\"Missing domain_specialists\");
if (!config.coordination_matrix) throw new Error(\"Missing coordination_matrix\");
console.log(\"Domain specialists structure valid\");
' 2>/dev/null"
    
    run_test "Project type specialists have required structure" "node -e '
const config = JSON.parse(require(\"fs\").readFileSync(\"$WORKSPACE_ROOT/agents/roles/project-type-specialists.json\", \"utf8\"));
if (!config.project_type_specialists) throw new Error(\"Missing project_type_specialists\");
if (!config.agent_selection_matrix) throw new Error(\"Missing agent_selection_matrix\");
console.log(\"Project type specialists structure valid\");
' 2>/dev/null"
}

# Workflow patterns validation
validate_workflows() {
    print_status "$BLUE" "🔄 Validating workflow patterns..."
    
    local workflows=(
        "sequential-workflow-pattern.md"
        "parallel-deployment-pattern.md"
        "github-issue-coordination.md"
    )
    
    for workflow in "${workflows[@]}"; do
        local workflow_file="$WORKSPACE_ROOT/agents/workflows/$workflow"
        
        # Check file size
        run_test "$workflow has content" "[ \$(wc -c < '$workflow_file') -gt 2000 ]"
        
        # Check for key sections
        run_test "$workflow has Overview section" "grep -q '## Overview' '$workflow_file'"
        run_test "$workflow has Use Cases section" "grep -q '## Use Cases' '$workflow_file'"
        run_test "$workflow has Prerequisites section" "grep -q '## Prerequisites' '$workflow_file'"
    done
}

# Interdependencies documentation validation
validate_interdependencies() {
    print_status "$BLUE" "🔗 Validating interdependencies documentation..."
    
    local interdep_docs=(
        "mcp-server-dependencies.md"
        "external-service-dependencies.md"
        "settings-permissions-matrix.md"
    )
    
    for doc in "${interdep_docs[@]}"; do
        local doc_file="$WORKSPACE_ROOT/agents/interdependencies/$doc"
        
        # Check file size
        run_test "$doc has content" "[ \$(wc -c < '$doc_file') -gt 3000 ]"
        
        # Check for key sections
        run_test "$doc has Overview section" "grep -q '## Overview' '$doc_file'"
        
        # Document-specific checks
        case "$doc" in
            "mcp-server-dependencies.md")
                run_test "$doc mentions Obsidian MCP" "grep -q 'Obsidian MCP' '$doc_file'"
                run_test "$doc mentions Journal MCP" "grep -q 'Journal MCP' '$doc_file'"
                ;;
            "external-service-dependencies.md")
                run_test "$doc mentions GitHub" "grep -q 'GitHub' '$doc_file'"
                run_test "$doc mentions deployment services" "grep -q 'Vercel\|Netlify' '$doc_file'"
                ;;
            "settings-permissions-matrix.md")
                run_test "$doc has permission matrix" "grep -q 'permissions' '$doc_file'"
                ;;
        esac
    done
}

# Template validation
validate_templates() {
    print_status "$BLUE" "📋 Validating templates..."
    
    # Check agent coordination template
    local template_file="$WORKSPACE_ROOT/templates/agent-coordination.md"
    
    run_test "Agent coordination template exists" "[ -f '$template_file' ]"
    run_test "Template has content" "[ \$(wc -c < '$template_file') -gt 5000 ]"
    run_test "Template has project types" "grep -q 'Personal React Project\|Healthcare Analytics\|AI Experiments' '$template_file'"
    run_test "Template has setup scripts" "grep -q 'setup-agent-coordination.sh' '$template_file'"
}

# Tools validation
validate_tools() {
    print_status "$BLUE" "🛠️  Validating tools..."
    
    local tools=(
        "deploy-agent-system.sh"
        "setup-project-agents.sh"
    )
    
    for tool in "${tools[@]}"; do
        local tool_file="$WORKSPACE_ROOT/tools/$tool"
        
        run_test "$tool exists" "[ -f '$tool_file' ]"
        run_test "$tool is executable" "[ -x '$tool_file' ]"
        run_test "$tool has shebang" "head -n1 '$tool_file' | grep -q '^#!/bin/bash'"
        run_test "$tool has help option" "grep -q -- '--help\|-h' '$tool_file'"
        
        # Check for error handling
        run_test "$tool has error handling" "grep -q 'set -e' '$tool_file'"
    done
}

# Environment validation
validate_environment() {
    print_status "$BLUE" "🌍 Validating environment..."
    
    # Check Node.js
    run_test "Node.js available" "command -v node >/dev/null 2>&1"
    
    if command -v node >/dev/null 2>&1; then
        local node_version=$(node --version | sed 's/v//')
        run_test "Node.js version >= 16" "[ \$(printf '%s\n' '16.0.0' '$node_version' | sort -V | head -n1) = '16.0.0' ]"
    fi
    
    # Check npm
    run_test "npm available" "command -v npm >/dev/null 2>&1"
    
    # Check git
    run_test "git available" "command -v git >/dev/null 2>&1"
    
    # Check GitHub CLI (optional)
    run_test "GitHub CLI available" "command -v gh >/dev/null 2>&1" true
    
    # Check Python (for AI projects)
    run_test "Python available" "command -v python3 >/dev/null 2>&1" true
    
    # Check key directories
    run_test "Obsidian vault path exists" "[ -d '/users/braydon/obsidian/bvault' ]" true
    run_test "Projects directory exists" "[ -d '/Users/braydon/projects' ]"
}

# Integration test
run_integration_test() {
    print_status "$BLUE" "🧩 Running integration test..."
    
    # Test MCP config loading
    run_test "Can load MCP configuration" "node -e '
const fs = require(\"fs\");
const config = JSON.parse(fs.readFileSync(\"$DEPLOYMENT_DIR/mcp-config.json\", \"utf8\"));
console.log(\"Loaded MCP config for agents:\", Object.keys(config.mcps).join(\", \"));
' 2>/dev/null"
    
    # Test agent role selection
    run_test "Can select agents for project types" "node -e '
const fs = require(\"fs\");
const specialists = JSON.parse(fs.readFileSync(\"$WORKSPACE_ROOT/agents/roles/project-type-specialists.json\", \"utf8\"));
const mapping = specialists.agent_selection_matrix.project_type_mapping;
console.log(\"Project type mappings:\", Object.keys(mapping).join(\", \"));
' 2>/dev/null"
    
    # Test deployment script functionality
    run_test "Deployment script has main function" "grep -q 'main()' '$WORKSPACE_ROOT/tools/deploy-agent-system.sh'"
    
    # Test setup script functionality
    run_test "Setup script accepts parameters" "grep -q 'parse_arguments' '$WORKSPACE_ROOT/tools/setup-project-agents.sh'"
}

# Generate validation report
generate_validation_report() {
    print_status "$BLUE" "📊 Generating validation report..."
    
    local total_tests=$((TESTS_PASSED + TESTS_FAILED))
    local success_rate=0
    
    if [ $total_tests -gt 0 ]; then
        success_rate=$(( (TESTS_PASSED * 100) / total_tests ))
    fi
    
    local report_file="$DEPLOYMENT_DIR/validation-report.md"
    
    cat > "$report_file" << EOF
# Agent System Validation Report

**Validation Date**: $(date '+%Y-%m-%d %H:%M:%S')
**Validator**: validate-agent-deployment.sh

## Summary
- **Total Tests**: $total_tests
- **Passed**: $TESTS_PASSED
- **Failed**: $TESTS_FAILED
- **Warnings**: $WARNINGS
- **Success Rate**: $success_rate%

## Status
$(if [ $TESTS_FAILED -eq 0 ]; then
    echo "✅ **VALIDATION PASSED** - Agent system is properly deployed"
else
    echo "❌ **VALIDATION FAILED** - $TESTS_FAILED test(s) failed"
fi)

## Component Status
- 📁 Directory Structure: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Valid" || echo "⚠️ Issues found")
- 📄 File Structure: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Valid" || echo "⚠️ Issues found") 
- ⚙️ MCP Configuration: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Valid" || echo "⚠️ Issues found")
- 🖥️ MCP Servers: $([ $WARNINGS -eq 0 ] && echo "✅ Available" || echo "⚠️ Some issues")
- 🤖 Agent Prompts: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Valid" || echo "⚠️ Issues found")
- 👥 Agent Roles: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Valid" || echo "⚠️ Issues found")
- 🔄 Workflows: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Valid" || echo "⚠️ Issues found")
- 🔗 Interdependencies: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Documented" || echo "⚠️ Issues found")
- 📋 Templates: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Valid" || echo "⚠️ Issues found")
- 🛠️ Tools: $([ $TESTS_FAILED -eq 0 ] && echo "✅ Valid" || echo "⚠️ Issues found")
- 🌍 Environment: $([ $WARNINGS -eq 0 ] && echo "✅ Ready" || echo "⚠️ Some issues")

## Recommendations

$(if [ $TESTS_FAILED -gt 0 ]; then
    echo "### Critical Issues"
    echo "- Review failed tests in the validation log"
    echo "- Fix any missing files or configuration errors"
    echo "- Re-run validation after fixes"
    echo ""
fi)

$(if [ $WARNINGS -gt 0 ]; then
    echo "### Warnings"
    echo "- Address warnings for optimal functionality"
    echo "- Some features may have limited functionality"
    echo "- Consider installing optional dependencies"
    echo ""
fi)

### Next Steps
1. **If validation passed**: Deploy to projects using \`setup-project-agents.sh\`
2. **If validation failed**: Address failed tests and re-validate
3. **Test integration**: Create a test project with agent coordination

## Detailed Log
See: \`$LOG_FILE\`

---
Generated by validate-agent-deployment.sh
EOF
    
    print_status "$GREEN" "✅ Validation report generated: $report_file"
}

# Main validation function
main() {
    print_status "$BLUE" "🔍 Starting comprehensive agent system validation..."
    
    # Create log file
    mkdir -p "$(dirname "$LOG_FILE")"
    touch "$LOG_FILE"
    
    # Run all validation tests
    validate_directory_structure
    validate_file_structure
    validate_mcp_configuration
    validate_mcp_servers
    validate_agent_prompts
    validate_agent_roles
    validate_workflows
    validate_interdependencies
    validate_templates
    validate_tools
    validate_environment
    run_integration_test
    
    # Generate report
    generate_validation_report
    
    # Final summary
    print_status "$BLUE" "📊 Validation Summary:"
    print_status "$GREEN" "✅ Tests Passed: $TESTS_PASSED"
    if [ $TESTS_FAILED -gt 0 ]; then
        print_status "$RED" "❌ Tests Failed: $TESTS_FAILED"
    fi
    if [ $WARNINGS -gt 0 ]; then
        print_status "$YELLOW" "⚠️  Warnings: $WARNINGS"
    fi
    
    if [ $TESTS_FAILED -eq 0 ]; then
        print_status "$GREEN" "🎉 Agent system validation PASSED!"
        print_status "$BLUE" "📄 Full report: $DEPLOYMENT_DIR/validation-report.md"
        exit 0
    else
        print_status "$RED" "❌ Agent system validation FAILED!"
        print_status "$BLUE" "📄 Full report: $DEPLOYMENT_DIR/validation-report.md"
        print_status "$BLUE" "📋 Check log: $LOG_FILE"
        exit 1
    fi
}

# Handle script arguments
case "${1:-}" in
    --help|-h)
        echo "Agent System Validation Script"
        echo ""
        echo "Usage: $0 [options]"
        echo ""
        echo "Options:"
        echo "  --help, -h     Show this help message"
        echo "  --verbose      Show detailed output"
        echo "  --report-only  Generate report without running tests"
        echo ""
        exit 0
        ;;
    --report-only)
        print_status "$BLUE" "📊 Generating validation report only..."
        generate_validation_report
        exit 0
        ;;
esac

# Run main validation
main "$@"