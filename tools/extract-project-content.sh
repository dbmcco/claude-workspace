#!/bin/bash
# ABOUTME: Extract important project-specific content from original CLAUDE.md files

set -e

WORKSPACE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROJECTS_DIR="/Users/braydon/projects"

echo "🔍 Extracting project-specific content from original CLAUDE.md files..."

# Create directory for extracted content
mkdir -p "$WORKSPACE_DIR/extracted-content"

# Find all original backup files
find "$PROJECTS_DIR" -name "CLAUDE.md-original" -type f | while read -r original_file; do
    project_dir=$(dirname "$original_file")
    project_name=$(basename "$project_dir")
    
    echo "📝 Extracting from: $project_name"
    
    # Create extraction file
    extraction_file="$WORKSPACE_DIR/extracted-content/${project_name}-extracted.md"
    
    {
        echo "# Extracted Content from $project_name"
        echo ""
        echo "**Original Path:** $project_dir"
        echo "**Extraction Date:** $(date)"
        echo ""
        echo "---"
        echo ""
        
        # Extract the entire original content for analysis
        cat "$original_file"
        
    } > "$extraction_file"
    
    echo "   ✅ Extracted to: extracted-content/${project_name}-extracted.md"
done

echo ""
echo "🎯 Analysis Summary:"
echo "   📁 Created extracted-content/ directory"
echo "   📄 Extracted all original CLAUDE.md content for analysis"
echo ""
echo "Next steps:"
echo "   1. Review extracted content for project-specific patterns"
echo "   2. Identify content that should be preserved in modular system"
echo "   3. Update project CLAUDE.md files with important missing content"
echo "   4. Consider creating new memory modules for common patterns"