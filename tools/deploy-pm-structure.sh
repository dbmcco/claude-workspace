#!/bin/bash

# ABOUTME: Deploy Project Manager structure to selected projects
# ABOUTME: Creates PM templates, preserves existing configs, initializes task tracking

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

# Validation functions
validate_project_dir() {
    local project_dir="$1"
    
    if [[ ! -d "$project_dir" ]]; then
        log_error "Project directory does not exist: $project_dir"
        return 1
    fi
    
    if [[ ! -w "$project_dir" ]]; then
        log_error "Project directory is not writable: $project_dir"
        return 1
    fi
    
    return 0
}

validate_templates() {
    local required_templates=(
        "project-manager-claude.md"
        "tasks-template.md" 
        "project-status-template.md"
        "project-manager-identity.md"
    )
    
    for template in "${required_templates[@]}"; do
        if [[ ! -f "$TEMPLATES_DIR/$template" ]]; then
            log_error "Required template missing: $template"
            return 1
        fi
    done
    
    log_success "All required templates found"
    return 0
}

# Project information extraction
extract_project_info() {
    local project_dir="$1"
    local project_name project_description language_stack framework_stack
    
    project_name=$(basename "$project_dir")
    
    # Extract info from existing files
    if [[ -f "$project_dir/package.json" ]]; then
        language_stack="TypeScript/JavaScript"
        framework_stack=$(jq -r '.dependencies | keys[]' "$project_dir/package.json" 2>/dev/null | head -3 | tr '\n' ', ' | sed 's/,$//' || echo "Node.js")
    elif [[ -f "$project_dir/requirements.txt" ]] || [[ -f "$project_dir/pyproject.toml" ]]; then
        language_stack="Python"
        framework_stack="Python/FastAPI/Django (typical)"
    elif [[ -f "$project_dir/go.mod" ]]; then
        language_stack="Go"
        framework_stack="Go/Gin/Echo (typical)"
    else
        language_stack="Mixed/TBD"
        framework_stack="TBD"
    fi
    
    # Try to extract description from existing README or CLAUDE.md
    project_description="TBD - Update with specific project objectives"
    if [[ -f "$project_dir/README.md" ]]; then
        project_description=$(head -10 "$project_dir/README.md" | grep -v '^#' | grep -v '^$' | head -1 || echo "$project_description")
    elif [[ -f "$project_dir/CLAUDE.md" ]]; then
        project_description=$(head -20 "$project_dir/CLAUDE.md" | grep -i 'about\|purpose\|objective' | head -1 | sed 's/^[#*-]*//' | sed 's/^[[:space:]]*//' || echo "$project_description")
    fi
    
    echo "$project_name|$project_description|$language_stack|$framework_stack"
}

# Template customization
customize_template() {
    local template_file="$1"
    local output_file="$2"
    local project_name="$3"
    local project_description="$4"
    local language_stack="$5"
    local framework_stack="$6"
    
    sed "s/{PROJECT_NAME}/$project_name/g; \
         s|{PROJECT_DESCRIPTION}|$project_description|g; \
         s/{LANGUAGE_STACK}/$language_stack/g; \
         s/{FRAMEWORK_STACK}/$framework_stack/g; \
         s/{PERFORMANCE_TARGETS}/<500ms API responses, <100ms queries/g; \
         s/{TESTING_FRAMEWORK}/Jest (JS) or pytest (Python)/g" \
         "$template_file" > "$output_file"
}

# Directory structure creation
create_pm_directories() {
    local project_dir="$1"
    
    log_info "Creating PM directory structure in $project_dir"
    
    mkdir -p "$project_dir/.claude/memories"
    
    if [[ -d "$project_dir/.claude/memories" ]]; then
        log_success "Created .claude/memories directory"
        return 0
    else
        log_error "Failed to create .claude/memories directory"
        return 1
    fi
}

# Backup existing files
backup_existing_files() {
    local project_dir="$1"
    local backup_created=false
    
    log_info "Backing up existing configuration files"
    
    if [[ -f "$project_dir/CLAUDE.md" ]]; then
        cp "$project_dir/CLAUDE.md" "$project_dir/CLAUDE-legacy-$TIMESTAMP.md"
        log_success "Backed up CLAUDE.md to CLAUDE-legacy-$TIMESTAMP.md"
        backup_created=true
    fi
    
    if [[ -f "$project_dir/tasks.md" ]]; then
        cp "$project_dir/tasks.md" "$project_dir/tasks-backup-$TIMESTAMP.md"
        log_warning "Existing tasks.md backed up to tasks-backup-$TIMESTAMP.md"
        backup_created=true
    fi
    
    if [[ -f "$project_dir/project_status.md" ]]; then
        cp "$project_dir/project_status.md" "$project_dir/project_status-backup-$TIMESTAMP.md"
        log_warning "Existing project_status.md backed up to project_status-backup-$TIMESTAMP.md"
        backup_created=true
    fi
    
    if [[ "$backup_created" == true ]]; then
        log_success "Backup process completed"
    else
        log_info "No existing files to backup"
    fi
}

# Deploy PM structure
deploy_pm_to_project() {
    local project_dir="$1"
    local project_info
    local project_name project_description language_stack framework_stack
    
    log_info "Starting PM deployment to: $project_dir"
    
    # Validate project directory
    if ! validate_project_dir "$project_dir"; then
        return 1
    fi
    
    # Extract project information
    project_info=$(extract_project_info "$project_dir")
    IFS='|' read -r project_name project_description language_stack framework_stack <<< "$project_info"
    
    log_info "Project: $project_name"
    log_info "Language: $language_stack"
    log_info "Framework: $framework_stack"
    
    # Create directories
    if ! create_pm_directories "$project_dir"; then
        return 1
    fi
    
    # Backup existing files
    backup_existing_files "$project_dir"
    
    # Deploy customized templates
    log_info "Deploying PM templates"
    
    # 1. Project Manager CLAUDE.md
    customize_template \
        "$TEMPLATES_DIR/project-manager-claude.md" \
        "$project_dir/CLAUDE.md" \
        "$project_name" \
        "$project_description" \
        "$language_stack" \
        "$framework_stack"
    
    # 2. Tasks template
    customize_template \
        "$TEMPLATES_DIR/tasks-template.md" \
        "$project_dir/tasks.md" \
        "$project_name" \
        "$project_description" \
        "$language_stack" \
        "$framework_stack"
    
    # 3. Project status template
    customize_template \
        "$TEMPLATES_DIR/project-status-template.md" \
        "$project_dir/project_status.md" \
        "$project_name" \
        "$project_description" \
        "$language_stack" \
        "$framework_stack"
    
    # 4. Project manager identity
    cp "$TEMPLATES_DIR/project-manager-identity.md" "$project_dir/.claude/memories/"
    
    log_success "PM structure deployed successfully to $project_name"
    
    # Summary
    echo
    log_info "Deployment Summary for $project_name:"
    echo "  ✓ CLAUDE.md (PM configuration)"
    echo "  ✓ tasks.md (task tracking)"  
    echo "  ✓ project_status.md (status dashboard)"
    echo "  ✓ .claude/memories/project-manager-identity.md"
    if [[ -f "$project_dir/CLAUDE-legacy-$TIMESTAMP.md" ]]; then
        echo "  ✓ Original CLAUDE.md backed up"
    fi
    echo
}

# Main execution
main() {
    local projects_to_deploy target_projects
    
    echo "================================================================"
    echo "Project Manager Structure Deployment Tool"
    echo "================================================================"
    echo
    
    # Validate templates
    if ! validate_templates; then
        log_error "Template validation failed. Exiting."
        exit 1
    fi
    
    # Define eligible projects
    target_projects=(
        "/Users/braydon/projects/personal/home_meal_planner"
        "/Users/braydon/projects/personal/moneycommand"
        "/Users/braydon/projects/work/lfw/lfw-draftforge"
        "/Users/braydon/projects/work/lfw/lfw-forgeworks"
        "/Users/braydon/projects/work/resilience/resilience_py"
    )
    
    # Interactive mode if no arguments
    if [[ $# -eq 0 ]]; then
        echo "Eligible projects for PM structure deployment:"
        echo
        for i in "${!target_projects[@]}"; do
            echo "  $((i+1)). ${target_projects[i]}"
        done
        echo "  a. Deploy to all eligible projects"
        echo "  q. Quit"
        echo
        
        read -p "Select projects (numbers separated by spaces, 'a' for all, 'q' to quit): " selection
        
        if [[ "$selection" == "q" ]]; then
            echo "Deployment cancelled."
            exit 0
        elif [[ "$selection" == "a" ]]; then
            projects_to_deploy=("${target_projects[@]}")
        else
            projects_to_deploy=()
            for num in $selection; do
                if [[ "$num" =~ ^[0-9]+$ ]] && [[ "$num" -ge 1 ]] && [[ "$num" -le "${#target_projects[@]}" ]]; then
                    projects_to_deploy+=("${target_projects[$((num-1))]}")
                else
                    log_warning "Invalid selection: $num"
                fi
            done
        fi
    else
        # Command line mode
        projects_to_deploy=("$@")
    fi
    
    # Validate selection
    if [[ ${#projects_to_deploy[@]} -eq 0 ]]; then
        log_error "No valid projects selected for deployment."
        exit 1
    fi
    
    # Confirm deployment
    echo "Projects selected for PM deployment:"
    for project in "${projects_to_deploy[@]}"; do
        echo "  - $project"
    done
    echo
    
    read -p "Proceed with deployment? (y/N): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Deployment cancelled."
        exit 0
    fi
    
    # Deploy to each project
    local success_count=0
    local total_count=${#projects_to_deploy[@]}
    
    for project_dir in "${projects_to_deploy[@]}"; do
        echo
        echo "────────────────────────────────────────────────────────────────"
        if deploy_pm_to_project "$project_dir"; then
            ((success_count++))
        else
            log_error "Deployment failed for $project_dir"
        fi
    done
    
    # Final summary
    echo
    echo "================================================================"
    echo "Deployment Complete"
    echo "================================================================"
    echo "Successfully deployed: $success_count/$total_count projects"
    
    if [[ $success_count -eq $total_count ]]; then
        log_success "All deployments completed successfully!"
        echo
        echo "Next steps:"
        echo "1. Run './validate-pm-deployment.sh' to verify deployments"
        echo "2. Test PM functionality in deployed projects"
        echo "3. Customize project-specific content in tasks.md and project_status.md"
    else
        log_warning "Some deployments failed. Check errors above."
        echo "Run with individual project paths to retry failed deployments."
    fi
}

# Execute main function with all arguments
main "$@"