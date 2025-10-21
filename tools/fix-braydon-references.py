#!/usr/bin/env python3
"""
Fix bray.doc references to Braydon throughout the claude-workspace system
"""

import os
import re
import sys
from pathlib import Path

def find_and_replace_braydon_refs(base_dir: str, dry_run: bool = True):
    """
    Find and replace 'bray.doc' with 'Braydon' in all markdown files
    """
    base_path = Path(base_dir)
    
    # Files that were identified as containing bray.doc
    target_files = [
        "personal/taskmgr/.claude/memories/intelligent-integration-strategy.md",
        "archive/journal-mcp/README.md", 
        "work/lfw/lfw-marketing/archive/agent_progress/instantly_environment_setup_report.md",
        "work/lfw/lfw-marketing/archive/instantly_api_setup/testing_validation_protocol.md",
        "work/lfw/lfw-marketing/archive/instantly_api_setup/content_update_workflow.md",
        "claude-workspace/agents/workflows/sequential-workflow-pattern.md",
        "claude-workspace/agents/prompts/coordination-agent.md",
        "claude-workspace/memories/workflows/agent-coordination.md"
    ]
    
    changes_made = []
    
    for file_rel_path in target_files:
        file_path = base_path / file_rel_path
        
        if not file_path.exists():
            print(f"⚠️  File not found: {file_path}")
            continue
            
        try:
            # Read the file
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Check if bray.doc exists in the file
            if 'bray.doc' not in content:
                print(f"✅ No changes needed: {file_rel_path}")
                continue
                
            # Perform replacement
            original_content = content
            content = re.sub(r'\bbray\.doc\b', 'Braydon', content, flags=re.IGNORECASE)
            
            # Count changes
            changes_count = original_content.count('bray.doc') + original_content.lower().count('bray.doc')
            
            if dry_run:
                print(f"🔍 Would replace {changes_count} instances in: {file_rel_path}")
                changes_made.append((file_path, changes_count, content))
            else:
                # Write the updated content
                with open(file_path, 'w', encoding='utf-8') as f:
                    f.write(content)
                print(f"✅ Replaced {changes_count} instances in: {file_rel_path}")
                changes_made.append((file_path, changes_count, None))
                
        except Exception as e:
            print(f"❌ Error processing {file_path}: {e}")
    
    return changes_made

def main():
    base_dir = "/Users/braydon/projects"
    
    print("🔍 Braydon Reference Fix Script")
    print("=" * 50)
    
    # First run in dry-run mode
    print("\n📋 DRY RUN - Scanning for bray.doc references...")
    changes = find_and_replace_braydon_refs(base_dir, dry_run=True)
    
    if not changes:
        print("✅ No bray.doc references found!")
        return
    
    print(f"\n📊 Found {len(changes)} files with bray.doc references")
    for file_path, count, _ in changes:
        print(f"  • {count} instances in {file_path.relative_to(Path(base_dir))}")
    
    # Ask for confirmation
    response = input("\n❓ Proceed with replacement? (y/N): ").strip().lower()
    
    if response == 'y':
        print("\n🔄 Performing replacements...")
        find_and_replace_braydon_refs(base_dir, dry_run=False)
        print("\n✅ All replacements completed!")
    else:
        print("❌ Operation cancelled")

if __name__ == "__main__":
    main()