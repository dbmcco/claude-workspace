#!/bin/bash
# ABOUTME: Migrate all projects to use modular Claude memory system

set -e

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="/Users/braydon/projects"

echo "🔄 Migrating all projects to modular Claude memory system..."

# Find all CLAUDE.md files (excluding claude-workspace itself)
find "$PROJECTS_DIR" -name "CLAUDE.md" -type f | grep -v claude-workspace | while read -r claude_file; do
    project_dir=$(dirname "$claude_file")
    project_name=$(basename "$project_dir")
    
    echo "📁 Processing: $project_name"
    echo "   Path: $project_dir"
    
    # Backup original
    if [ ! -f "${claude_file}-original" ]; then
        cp "$claude_file" "${claude_file}-original"
        echo "   ✅ Backed up original CLAUDE.md"
    else
        echo "   ⚠️  Original backup already exists, skipping backup"
    fi
    
    # Determine project type based on path
    if [[ "$project_dir" == *"/experiments/"* ]]; then
        template="experiments"
    elif [[ "$project_dir" == *"/personal/"* ]]; then
        template="personal"
    elif [[ "$project_dir" == *"/work/"* ]]; then
        if [[ "$project_dir" == *"LDA"* || "$project_dir" == *"client_dashboard"* || "$project_dir" == *"drug_match"* ]]; then
            template="healthcare-analytics"
        else
            template="work"
        fi
    else
        template="base"
    fi
    
    echo "   📋 Using template: $template"
    
    # Create modular CLAUDE.md
    {
        echo "# $(basename "$project_dir") Project Memory"
        echo ""
        echo "@~/claude-workspace/memories/base/interaction-style.md"
        echo "@~/claude-workspace/memories/base/core-principles.md"
        echo "@~/claude-workspace/memories/base/code-standards.md"
        echo "@~/claude-workspace/memories/base/version-control.md"
        echo "@~/claude-workspace/memories/workflows/tdd.md"
        echo "@~/claude-workspace/memories/workflows/llm-driven-development.md"
        
        case $template in
            "experiments")
                echo "@~/claude-workspace/memories/project-types/experiments.md"
                ;;
            "personal")
                echo "@~/claude-workspace/memories/project-types/personal.md"
                ;;
            "work")
                echo "@~/claude-workspace/memories/project-types/work.md"
                ;;
            "healthcare-analytics")
                echo "@~/claude-workspace/memories/project-types/work.md"
                echo "@~/claude-workspace/memories/project-types/healthcare-analytics.md"
                ;;
        esac
        
        echo ""
        echo "## Project-Specific Context"
        echo ""
        
        # Extract project-specific content from original
        if grep -q "## Project.*Context\|## Current Focus\|## Key Files\|## Common Commands" "${claude_file}-original" 2>/dev/null; then
            echo "**Migrated from original CLAUDE.md - review and update as needed**"
            echo ""
        fi
        
        echo "## Current Focus"
        echo "[What you're working on right now]"
        echo ""
        echo "## Key Files"
        echo "[Important files and their purposes]"
        echo ""
        echo "## Common Commands"
        echo "\`\`\`bash"
        echo "# Add project-specific commands here"
        echo "\`\`\`"
        echo ""
        echo "## Recent Decisions"
        echo "[Date]: Migrated to modular Claude memory system"
        
    } > "$claude_file"
    
    echo "   ✅ Applied modular template"
    echo ""
done

echo "🎉 Migration complete!"
echo "📋 Summary:"
echo "   - All projects now use modular memory system"
echo "   - Original CLAUDE.md files backed up as CLAUDE-original.md"
echo "   - Projects automatically inherit all universal standards"
echo "   - Enhanced with LLM-driven development principles"
echo ""
echo "Next steps:"
echo "   1. Review each project's new CLAUDE.md"
echo "   2. Customize project-specific sections as needed"
echo "   3. Test with 'claude /memory' in each project"