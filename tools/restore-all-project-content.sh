#!/bin/bash
# ABOUTME: Systematically restore project-specific content from original CLAUDE.md files to all 25 projects

set -e

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="/Users/braydon/projects"

echo "🔄 Systematically restoring project-specific content to all projects..."

# Function to extract key sections from original CLAUDE.md
extract_key_content() {
    local original_file="$1"
    local temp_file="/tmp/extracted_content.md"
    
    # Extract everything after any imports/includes but preserve structure
    awk '
    BEGIN { in_project_section = 0; in_commands = 0; buffer = "" }
    
    # Skip header and basic intro
    /^# / && NR <= 5 { next }
    /^This file provides guidance/ { next }
    
    # Look for substantial content sections
    /^## (Project|Architecture|Current|Key|Common|Environment|Configuration|Implementation|Quality|Best|Important)/ { 
        in_project_section = 1; 
        print $0; 
        next 
    }
    
    # Look for code blocks with commands
    /^```/ { 
        if (in_commands) {
            print $0;
            in_commands = 0;
        } else {
            in_commands = 1;
            print $0;
        }
        next 
    }
    
    # Include content if we are in a relevant section
    in_project_section || in_commands { print $0 }
    
    # Reset section tracking on new headers that are not relevant
    /^## / && !/^## (Project|Architecture|Current|Key|Common|Environment|Configuration|Implementation|Quality|Best|Important)/ { 
        in_project_section = 0 
    }
    ' "$original_file" > "$temp_file"
    
    # Return the extracted content if it has substance
    if [ -s "$temp_file" ] && [ $(wc -l < "$temp_file") -gt 5 ]; then
        cat "$temp_file"
    fi
    
    rm -f "$temp_file"
}

# Process each project
find "$PROJECTS_DIR" -name "CLAUDE.md-original" -type f | while read -r original_file; do
    project_dir=$(dirname "$original_file")
    project_name=$(basename "$project_dir")
    current_claude="$project_dir/CLAUDE.md"
    
    echo "📝 Processing: $project_name"
    echo "   Original: $original_file"
    echo "   Current:  $current_claude"
    
    # Skip if current CLAUDE.md doesn't exist
    if [ ! -f "$current_claude" ]; then
        echo "   ⚠️  No current CLAUDE.md found, skipping"
        continue
    fi
    
    # Extract meaningful content from original
    extracted_content=$(extract_key_content "$original_file")
    
    if [ -z "$extracted_content" ]; then
        echo "   ℹ️  No substantial content to restore"
        continue
    fi
    
    # Create a backup of current modular version
    cp "$current_claude" "${current_claude}.backup"
    
    # Build enhanced CLAUDE.md
    {
        # Keep the modular imports (first 10 lines typically)
        head -n 15 "$current_claude" | grep -E "^(#|@|$)"
        
        echo ""
        echo "## Project-Specific Context"
        echo ""
        
        # Add the extracted meaningful content
        echo "$extracted_content" | sed '/^## Project-Specific Context/d' | sed '/^\*\*Migrated from original/d'
        
        # Add any remaining modular template sections that weren't in original
        tail -n +16 "$current_claude" | grep -A 1000 "^## Recent Decisions" || echo -e "\n## Recent Decisions\n[Date]: Restored project-specific content from original CLAUDE.md"
        
    } > "${current_claude}.new"
    
    # Replace current with enhanced version
    mv "${current_claude}.new" "$current_claude"
    
    echo "   ✅ Content restored and enhanced"
    echo ""
done

echo "🎉 Systematic content restoration complete!"
echo ""
echo "📋 Summary:"
echo "   - All projects processed for content restoration"
echo "   - Original CLAUDE.md content analyzed and extracted"
echo "   - Meaningful project-specific content preserved"
echo "   - Modular imports maintained for universal standards"
echo "   - Backup files created (.backup) for safety"
echo ""
echo "Next steps:"
echo "   1. Review updated CLAUDE.md files in each project"
echo "   2. Test a few projects with 'claude /memory' to verify imports work"
echo "   3. Customize any project-specific sections as needed"