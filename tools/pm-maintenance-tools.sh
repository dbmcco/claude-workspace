#!/bin/bash

# ABOUTME: Project Manager structure maintenance tools
# ABOUTME: Ongoing management, updates, and reporting for PM deployments

set -euo pipefail

# Configuration
WORKSPACE_ROOT="/Users/braydon/projects/claude-workspace"
TEMPLATES_DIR="$WORKSPACE_ROOT/templates"
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')

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

# Discovery functions
find_pm_projects() {
    local search_dirs=(
        "/Users/braydon/projects/personal"
        "/Users/braydon/projects/work"
    )
    
    local pm_projects=()
    
    for dir in "${search_dirs[@]}"; do
        if [[ -d "$dir" ]]; then
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

get_project_info() {
    local project_dir="$1"
    local project_name last_modified task_count status_health
    
    project_name=$(basename "$project_dir")
    
    # Get last modification time
    if [[ -f "$project_dir/tasks.md" ]]; then
        last_modified=$(stat -f "%Sm" -t "%Y-%m-%d %H:%M" "$project_dir/tasks.md" 2>/dev/null || echo "Unknown")
    else
        last_modified="N/A"
    fi
    
    # Count active tasks
    if [[ -f "$project_dir/tasks.md" ]]; then
        task_count=$(grep -c "Status.*In Progress\|Status.*Ready" "$project_dir/tasks.md" 2>/dev/null || echo "0")
    else
        task_count="0"
    fi
    
    # Get project health status
    if [[ -f "$project_dir/project_status.md" ]]; then
        status_health=$(grep "Overall Health" "$project_dir/project_status.md" 2>/dev/null | head -1 | sed 's/.*: *//' || echo "Unknown")
    else
        status_health="Unknown"
    fi
    
    echo "$project_name|$last_modified|$task_count|$status_health"
}

# Audit functions
audit_pm_deployments() {
    local pm_projects
    
    echo "================================================================"
    echo "Project Manager Deployment Audit"
    echo "================================================================"
    echo
    
    readarray -t pm_projects < <(find_pm_projects)
    
    if [[ ${#pm_projects[@]} -eq 0 ]]; then
        log_warning "No PM deployments found"
        return 0
    fi
    
    log_info "Found ${#pm_projects[@]} PM deployment(s)"
    echo
    
    printf "%-25s %-15s %-10s %-10s %-15s\n" "Project" "Last Updated" "Tasks" "Health" "Status"
    printf "%-25s %-15s %-10s %-10s %-15s\n" "-------" "------------" "-----" "------" "------"
    
    for project_dir in "${pm_projects[@]}"; do
        local project_info
        local project_name last_modified task_count status_health deployment_status
        
        project_info=$(get_project_info "$project_dir")
        IFS='|' read -r project_name last_modified task_count status_health <<< "$project_info"
        
        # Check deployment completeness
        if [[ -f "$project_dir/CLAUDE.md" ]] && \
           [[ -f "$project_dir/tasks.md" ]] && \
           [[ -f "$project_dir/project_status.md" ]] && \
           [[ -f "$project_dir/.claude/memories/project-manager-identity.md" ]]; then
            deployment_status="Complete"
        else
            deployment_status="Incomplete"
        fi
        
        printf "%-25s %-15s %-10s %-10s %-15s\n" \
            "$project_name" "$last_modified" "$task_count" "$status_health" "$deployment_status"
    done
    
    echo
    log_success "Audit completed for ${#pm_projects[@]} projects"
}

# Template update functions
update_pm_templates() {
    local pm_projects target_projects
    
    echo "================================================================"
    echo "PM Template Update Tool"
    echo "================================================================"
    echo
    
    readarray -t pm_projects < <(find_pm_projects)
    
    if [[ ${#pm_projects[@]} -eq 0 ]]; then
        log_warning "No PM deployments found to update"
        return 0
    fi
    
    log_info "Found ${#pm_projects[@]} PM deployment(s) to update"
    
    # Select projects to update
    echo "Available PM projects:"
    for i in "${!pm_projects[@]}"; do
        echo "  $((i+1)). $(basename "${pm_projects[i]}")"
    done
    echo "  a. Update all projects"
    echo "  q. Quit"
    echo
    
    read -p "Select projects to update (numbers separated by spaces, 'a' for all, 'q' to quit): " selection
    
    if [[ "$selection" == "q" ]]; then
        echo "Update cancelled."
        return 0
    elif [[ "$selection" == "a" ]]; then
        target_projects=("${pm_projects[@]}")
    else
        target_projects=()
        for num in $selection; do
            if [[ "$num" =~ ^[0-9]+$ ]] && [[ "$num" -ge 1 ]] && [[ "$num" -le "${#pm_projects[@]}" ]]; then
                target_projects+=("${pm_projects[$((num-1))]}")
            else
                log_warning "Invalid selection: $num"
            fi
        done
    fi
    
    if [[ ${#target_projects[@]} -eq 0 ]]; then
        log_error "No valid projects selected"
        return 1
    fi
    
    # Update each selected project
    local success_count=0
    
    for project_dir in "${target_projects[@]}"; do
        local project_name
        project_name=$(basename "$project_dir")
        
        log_info "Updating PM templates for: $project_name"
        
        # Backup current identity file
        if [[ -f "$project_dir/.claude/memories/project-manager-identity.md" ]]; then
            cp "$project_dir/.claude/memories/project-manager-identity.md" \
               "$project_dir/.claude/memories/project-manager-identity-backup-$TIMESTAMP.md"
        fi
        
        # Update project-manager-identity.md (this is the main template that changes)
        if cp "$TEMPLATES_DIR/project-manager-identity.md" "$project_dir/.claude/memories/"; then
            log_success "Updated project-manager-identity.md for $project_name"
            ((success_count++))
        else
            log_error "Failed to update project-manager-identity.md for $project_name"
        fi
    done
    
    echo
    log_success "Updated PM templates for $success_count/${#target_projects[@]} projects"
}

# Validation and health check
validate_pm_consistency() {
    local pm_projects
    
    echo "================================================================"
    echo "PM Consistency Validation"
    echo "================================================================"
    echo
    
    readarray -t pm_projects < <(find_pm_projects)
    
    if [[ ${#pm_projects[@]} -eq 0 ]]; then
        log_warning "No PM deployments found"
        return 0
    fi
    
    local total_issues=0
    
    for project_dir in "${pm_projects[@]}"; do
        local project_name issues_found
        project_name=$(basename "$project_dir")
        issues_found=0
        
        log_info "Validating consistency for: $project_name"
        
        # Check for template placeholders
        for file in "CLAUDE.md" "tasks.md" "project_status.md"; do
            if [[ -f "$project_dir/$file" ]]; then
                local placeholders
                placeholders=$(grep -o '{[A-Z_]*}' "$project_dir/$file" 2>/dev/null || true)
                if [[ -n "$placeholders" ]]; then
                    log_warning "$file has uncustomized placeholders in $project_name"
                    ((issues_found++))
                fi
            fi
        done
        
        # Check memory imports
        if [[ -f "$project_dir/CLAUDE.md" ]]; then
            if ! grep -q "project-manager-identity.md" "$project_dir/CLAUDE.md"; then
                log_warning "Missing project-manager-identity.md import in $project_name"
                ((issues_found++))
            fi
            if ! grep -q "tasks.md" "$project_dir/CLAUDE.md"; then
                log_warning "Missing tasks.md import in $project_name"
                ((issues_found++))
            fi
            if ! grep -q "project_status.md" "$project_dir/CLAUDE.md"; then
                log_warning "Missing project_status.md import in $project_name"
                ((issues_found++))
            fi
        fi
        
        # Check PM role configuration
        if [[ -f "$project_dir/CLAUDE.md" ]]; then
            if ! grep -q "NEVER CODE DIRECTLY" "$project_dir/CLAUDE.md"; then
                log_warning "Missing PM coding prevention in $project_name"
                ((issues_found++))
            fi
        fi
        
        if [[ $issues_found -eq 0 ]]; then
            log_success "No issues found for $project_name"
        else
            log_warning "Found $issues_found issue(s) for $project_name"
            ((total_issues += issues_found))
        fi
    done
    
    echo
    if [[ $total_issues -eq 0 ]]; then
        log_success "All PM deployments are consistent"
    else
        log_warning "Found $total_issues total issues across PM deployments"
    fi
}

# Reporting functions
generate_pm_report() {
    local pm_projects report_file
    
    report_file="/tmp/pm-deployment-report-$TIMESTAMP.md"
    
    echo "================================================================"
    echo "Generating PM Deployment Report"
    echo "================================================================"
    echo
    
    readarray -t pm_projects < <(find_pm_projects)
    
    if [[ ${#pm_projects[@]} -eq 0 ]]; then
        log_warning "No PM deployments found"
        return 0
    fi
    
    # Generate report
    cat > "$report_file" << EOF
# Project Manager Deployment Report
Generated: $(date)

## Summary

- **Total PM Deployments**: ${#pm_projects[@]}
- **Report Generated**: $TIMESTAMP

## Project Details

EOF
    
    for project_dir in "${pm_projects[@]}"; do
        local project_info
        local project_name last_modified task_count status_health
        
        project_info=$(get_project_info "$project_dir")
        IFS='|' read -r project_name last_modified task_count status_health <<< "$project_info"
        
        cat >> "$report_file" << EOF
### $project_name

- **Path**: $project_dir
- **Last Updated**: $last_modified
- **Active Tasks**: $task_count
- **Health Status**: $status_health
- **Files Present**:
EOF
        
        # Check file existence
        for file in "CLAUDE.md" "tasks.md" "project_status.md" ".claude/memories/project-manager-identity.md"; do
            if [[ -f "$project_dir/$file" ]]; then
                echo "  - ✅ $file" >> "$report_file"
            else
                echo "  - ❌ $file" >> "$report_file"
            fi
        done
        
        echo >> "$report_file"
    done
    
    cat >> "$report_file" << EOF

## Maintenance Recommendations

1. **Regular Updates**: Run template updates monthly
2. **Consistency Checks**: Validate PM consistency weekly  
3. **Active Monitoring**: Review task tracking weekly
4. **Template Evolution**: Update templates based on project feedback

---
Report generated by pm-maintenance-tools.sh
EOF
    
    log_success "Report generated: $report_file"
    echo
    echo "Report contents:"
    echo "────────────────"
    cat "$report_file"
}

# Help function
show_help() {
    cat << EOF
PM Maintenance Tools - Project Manager Structure Management

USAGE:
    $0 <command>

COMMANDS:
    audit           Audit all PM deployments and show status summary
    update          Update PM templates in deployed projects
    validate        Validate PM consistency across deployments
    report          Generate comprehensive PM deployment report
    help            Show this help message

EXAMPLES:
    $0 audit                    # Show status of all PM deployments
    $0 update                   # Interactively update PM templates
    $0 validate                 # Check PM consistency issues
    $0 report                   # Generate detailed report

DESCRIPTION:
    This tool provides ongoing maintenance for Project Manager structure
    deployments across the project ecosystem. Use it to keep PM templates
    up-to-date, validate consistency, and monitor deployment health.

EOF
}

# Main execution
main() {
    local command="${1:-help}"
    
    case "$command" in
        "audit")
            audit_pm_deployments
            ;;
        "update")
            update_pm_templates
            ;;
        "validate")
            validate_pm_consistency
            ;;
        "report")
            generate_pm_report
            ;;
        "help"|"-h"|"--help")
            show_help
            ;;
        *)
            log_error "Unknown command: $command"
            echo
            show_help
            exit 1
            ;;
    esac
}

# Execute main function
main "$@"