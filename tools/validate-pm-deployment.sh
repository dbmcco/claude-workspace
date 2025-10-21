#!/bin/bash

# ABOUTME: Validate Project Manager structure deployment
# ABOUTME: Verifies file existence, template customization, and PM functionality

set -euo pipefail

# Configuration
WORKSPACE_ROOT="/Users/braydon/projects/claude-workspace"

# Color codes for output  
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Validation functions
check_file_exists() {
    local file_path="$1"
    local description="$2"
    
    if [[ -f "$file_path" ]]; then
        log_success "$description exists"
        return 0
    else
        log_error "$description missing: $file_path"
        return 1
    fi
}

check_template_customization() {
    local file_path="$1"
    local description="$2"
    
    if [[ ! -f "$file_path" ]]; then
        log_error "$description file missing"
        return 1
    fi
    
    # Check for uncustomized placeholders
    local placeholders
    placeholders=$(grep -o '{[A-Z_]*}' "$file_path" 2>/dev/null || true)
    
    if [[ -n "$placeholders" ]]; then
        log_warning "$description has uncustomized placeholders:"
        echo "$placeholders" | sort | uniq | sed 's/^/    /'
        return 1
    else
        log_success "$description properly customized"
        return 0
    fi
}

check_memory_imports() {
    local claude_file="$1"
    local project_dir="$2"
    
    if [[ ! -f "$claude_file" ]]; then
        log_error "CLAUDE.md file missing"
        return 1
    fi
    
    local import_errors=0
    
    # Check for required imports
    local required_imports=(
        "project-manager-identity.md"
        "tasks.md"
        "project_status.md"
    )
    
    for import_file in "${required_imports[@]}"; do
        if grep -q "$import_file" "$claude_file"; then
            log_success "Import found: $import_file"
        else
            log_error "Missing import: $import_file"
            ((import_errors++))
        fi
    done
    
    # Check import syntax
    local import_lines
    import_lines=$(grep '^@' "$claude_file" || true)
    
    if [[ -z "$import_lines" ]]; then
        log_error "No @import lines found in CLAUDE.md"
        ((import_errors++))
    else
        log_success "Import syntax present"
    fi
    
    return $import_errors
}

check_pm_role_configuration() {
    local claude_file="$1"
    
    if [[ ! -f "$claude_file" ]]; then
        log_error "CLAUDE.md file missing"
        return 1
    fi
    
    local pm_errors=0
    
    # Check for PM-specific content
    local pm_indicators=(
        "NEVER CODE DIRECTLY"
        "Project Manager"
        "Task tool"
        "sub-agent"
        "@architect"
        "@dev" 
        "@tdd"
        "@quality"
        "@git"
    )
    
    for indicator in "${pm_indicators[@]}"; do
        if grep -q "$indicator" "$claude_file"; then
            log_success "PM indicator found: $indicator"
        else
            log_warning "PM indicator missing: $indicator"
            ((pm_errors++))
        fi
    done
    
    # Check for coding prevention language
    if grep -q "NEVER.*CODE" "$claude_file"; then
        log_success "PM coding prevention configured"
    else
        log_error "Missing PM coding prevention language"
        ((pm_errors++))
    fi
    
    return $pm_errors
}

check_task_tracking_structure() {
    local tasks_file="$1"
    
    if [[ ! -f "$tasks_file" ]]; then
        log_error "tasks.md file missing"
        return 1
    fi
    
    local task_errors=0
    
    # Check for required sections
    local required_sections=(
        "Active Tasks"
        "In Progress"
        "Ready to Start"
        "Needs Clarification"
        "Blocked/Waiting"
        "Task Interview Framework"
        "Quality Gates"
    )
    
    for section in "${required_sections[@]}"; do
        if grep -q "$section" "$tasks_file"; then
            log_success "Task section found: $section"
        else
            log_error "Missing task section: $section"
            ((task_errors++))
        fi
    done
    
    # Check for task interview questions
    if grep -q "What would 'done' look like" "$tasks_file"; then
        log_success "Task interview framework present"
    else
        log_warning "Task interview framework incomplete"
        ((task_errors++))
    fi
    
    return $task_errors
}

check_project_status_structure() {
    local status_file="$1"
    
    if [[ ! -f "$status_file" ]]; then
        log_error "project_status.md file missing"
        return 1
    fi
    
    local status_errors=0
    
    # Check for required sections
    local required_sections=(
        "Executive Summary"
        "Current Status"
        "Milestone Tracking"
        "Risk Management"
        "Technical Health"
        "Quality Metrics"
        "Success Indicators"
    )
    
    for section in "${required_sections[@]}"; do
        if grep -q "$section" "$status_file"; then
            log_success "Status section found: $section"
        else
            log_error "Missing status section: $section"
            ((status_errors++))
        fi
    done
    
    return $status_errors
}

check_backup_creation() {
    local project_dir="$1"
    
    # Look for backup files
    local backup_files
    backup_files=$(find "$project_dir" -name "*legacy*" -o -name "*backup*" 2>/dev/null || true)
    
    if [[ -n "$backup_files" ]]; then
        log_success "Backup files found:"
        echo "$backup_files" | sed 's/^/    /'
        return 0
    else
        log_info "No backup files found (may be new deployment)"
        return 0
    fi
}

# Project validation
validate_project_pm_deployment() {
    local project_dir="$1"
    local project_name
    local validation_errors=0
    
    project_name=$(basename "$project_dir")
    
    log_info "Validating PM deployment for: $project_name"
    log_info "Project directory: $project_dir"
    
    # Check if project directory exists
    if [[ ! -d "$project_dir" ]]; then
        log_error "Project directory does not exist: $project_dir"
        return 1
    fi
    
    echo
    echo "1. File Existence Validation"
    echo "──────────────────────────────"
    
    # Required files
    check_file_exists "$project_dir/CLAUDE.md" "PM CLAUDE.md" || ((validation_errors++))
    check_file_exists "$project_dir/tasks.md" "Tasks tracking file" || ((validation_errors++))
    check_file_exists "$project_dir/project_status.md" "Project status file" || ((validation_errors++))
    check_file_exists "$project_dir/.claude/memories/project-manager-identity.md" "PM identity memory" || ((validation_errors++))
    
    echo
    echo "2. Template Customization Validation"
    echo "───────────────────────────────────────"
    
    check_template_customization "$project_dir/CLAUDE.md" "CLAUDE.md" || ((validation_errors++))
    check_template_customization "$project_dir/tasks.md" "tasks.md" || ((validation_errors++))
    check_template_customization "$project_dir/project_status.md" "project_status.md" || ((validation_errors++))
    
    echo
    echo "3. Memory Import Validation"
    echo "─────────────────────────────"
    
    check_memory_imports "$project_dir/CLAUDE.md" "$project_dir" || ((validation_errors++))
    
    echo
    echo "4. PM Role Configuration Validation"
    echo "──────────────────────────────────────"
    
    check_pm_role_configuration "$project_dir/CLAUDE.md" || ((validation_errors++))
    
    echo
    echo "5. Task Tracking Structure Validation"
    echo "────────────────────────────────────────"
    
    check_task_tracking_structure "$project_dir/tasks.md" || ((validation_errors++))
    
    echo
    echo "6. Project Status Structure Validation"
    echo "─────────────────────────────────────────"
    
    check_project_status_structure "$project_dir/project_status.md" || ((validation_errors++))
    
    echo
    echo "7. Backup Validation"
    echo "──────────────────────"
    
    check_backup_creation "$project_dir"
    
    # Summary for this project
    echo
    if [[ $validation_errors -eq 0 ]]; then
        log_success "PM deployment validation PASSED for $project_name"
    else
        log_error "PM deployment validation FAILED for $project_name ($validation_errors errors)"
    fi
    
    return $validation_errors
}

# Auto-discovery of PM deployments
find_pm_deployments() {
    local search_dirs=(
        "/Users/braydon/projects/personal"
        "/Users/braydon/projects/work"
    )
    
    local pm_projects=()
    
    for dir in "${search_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
            # Find projects with PM structure
            while IFS= read -r -d '' project_dir; do
                if [[ -f "$project_dir/CLAUDE.md" ]] && \
                   [[ -f "$project_dir/tasks.md" ]] && \
                   [[ -f "$project_dir/project_status.md" ]] && \
                   [[ -f "$project_dir/.claude/memories/project-manager-identity.md" ]]; then
                    pm_projects+=("$project_dir")
                fi
            done < <(find "$dir" -maxdepth 2 -type d -print0 2>/dev/null)
        fi
    done
    
    printf '%s\n' "${pm_projects[@]}"
}

# Main execution
main() {
    local projects_to_validate
    
    echo "================================================================"
    echo "Project Manager Deployment Validation Tool"
    echo "================================================================"
    echo
    
    # Determine projects to validate
    if [[ $# -eq 0 ]]; then
        log_info "Auto-discovering PM deployments..."
        
        readarray -t projects_to_validate < <(find_pm_deployments)
        
        if [[ ${#projects_to_validate[@]} -eq 0 ]]; then
            log_warning "No PM deployments found."
            echo "To validate specific projects, run:"
            echo "  $0 /path/to/project1 /path/to/project2"
            exit 0
        fi
        
        log_info "Found ${#projects_to_validate[@]} PM deployment(s):"
        for project in "${projects_to_validate[@]}"; do
            echo "  - $project"
        done
        echo
    else
        projects_to_validate=("$@")
    fi
    
    # Validate each project
    local total_projects=${#projects_to_validate[@]}
    local passed_projects=0
    local failed_projects=0
    
    for project_dir in "${projects_to_validate[@]}"; do
        echo
        echo "════════════════════════════════════════════════════════════════"
        
        if validate_project_pm_deployment "$project_dir"; then
            ((passed_projects++))
        else
            ((failed_projects++))
        fi
    done
    
    # Final summary
    echo
    echo "================================================================"
    echo "Validation Summary"
    echo "================================================================"
    echo "Total projects validated: $total_projects"
    echo "Passed validation: $passed_projects"
    echo "Failed validation: $failed_projects"
    echo
    
    if [[ $failed_projects -eq 0 ]]; then
        log_success "All PM deployments are valid!"
        echo
        echo "Next steps:"
        echo "1. Test PM functionality by creating sample tasks"
        echo "2. Verify sub-agent delegation works correctly"
        echo "3. Check @import resolution in Claude Code"
        echo "4. Customize project-specific content"
    else
        log_warning "Some PM deployments have validation issues."
        echo "Review the errors above and re-run deployment if needed."
        exit 1
    fi
}

# Execute main function
main "$@"