#!/usr/bin/env python3
"""
Standardize all Claude memory imports to reference claude-workspace for central propagation
This ensures all updates to claude-workspace memory modules propagate everywhere
"""

import os
import re
import sys
from pathlib import Path
import shutil
from datetime import datetime

def calculate_relative_path_to_workspace(file_path: Path, workspace_path: Path) -> str:
    """Calculate relative path from a CLAUDE.md file to claude-workspace"""
    try:
        # Get relative path from file's directory to workspace
        file_dir = file_path.parent
        rel_path = os.path.relpath(workspace_path, file_dir)
        return rel_path
    except ValueError:
        # Fallback to absolute path if relative calculation fails
        return str(workspace_path)

def standardize_claude_imports(base_dir: str, dry_run: bool = True):
    """
    Standardize all @import statements to reference claude-workspace
    """
    base_path = Path(base_dir)
    workspace_path = base_path / "claude-workspace"
    
    if not workspace_path.exists():
        print(f"❌ Claude workspace not found at: {workspace_path}")
        return []
    
    changes_made = []
    
    # Find all CLAUDE.md files
    claude_files = []
    for claude_file in base_path.rglob("CLAUDE.md"):
        # Skip archived files and claude-workspace itself
        if "archive" in str(claude_file) or "claude-workspace" in str(claude_file):
            continue
        claude_files.append(claude_file)
    
    print(f"📁 Found {len(claude_files)} CLAUDE.md files to process")
    
    for claude_file in claude_files:
        try:
            # Read current content
            with open(claude_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            # Skip if no import statements
            if '@' not in content:
                continue
                
            original_content = content
            
            # Calculate relative path to claude-workspace from this file
            rel_workspace_path = calculate_relative_path_to_workspace(claude_file, workspace_path)
            
            # Patterns to replace with claude-workspace references
            patterns = [
                # Local .claude references
                (r'@\.\./\.claude/memories/', f'@{rel_workspace_path}/memories/'),
                (r'@\.\./.claude/memories/', f'@{rel_workspace_path}/memories/'),
                (r'@\./.claude/memories/', f'@{rel_workspace_path}/memories/'),
                (r'@\.claude/memories/', f'@{rel_workspace_path}/memories/'),
                
                # Absolute home directory references  
                (r'@~/claude-workspace/memories/', f'@{rel_workspace_path}/memories/'),
                (r'@/Users/braydon/projects/claude-workspace/memories/', f'@{rel_workspace_path}/memories/'),
                
                # Fix any double slashes
                (r'claude-workspace//memories/', 'claude-workspace/memories/'),
            ]
            
            changes_count = 0
            for pattern, replacement in patterns:
                if re.search(pattern, content):
                    content = re.sub(pattern, replacement, content)
                    changes_count += 1
            
            # Add claude-code-agents import if not present
            if 'claude-code-agents.md' not in content and '@' in content:
                # Find insertion point after base imports
                lines = content.split('\n')
                insert_idx = 0
                
                for i, line in enumerate(lines):
                    if line.startswith('@') and 'base/' in line:
                        insert_idx = max(insert_idx, i + 1)
                
                if insert_idx > 0:
                    new_import = f'@{rel_workspace_path}/memories/base/claude-code-agents.md'
                    lines.insert(insert_idx, new_import)
                    content = '\n'.join(lines)
                    changes_count += 1
            
            if changes_count > 0:
                rel_file_path = claude_file.relative_to(base_path)
                
                if dry_run:
                    print(f"🔍 Would update {changes_count} imports in: {rel_file_path}")
                    changes_made.append((claude_file, changes_count, content))
                else:
                    # Create backup
                    backup_path = f"{claude_file}.backup.{datetime.now().strftime('%Y%m%d_%H%M%S')}"
                    shutil.copy2(claude_file, backup_path)
                    
                    # Write updated content
                    with open(claude_file, 'w', encoding='utf-8') as f:
                        f.write(content)
                    
                    print(f"✅ Updated {changes_count} imports in: {rel_file_path}")
                    print(f"   📋 Backup created: {Path(backup_path).name}")
                    changes_made.append((claude_file, changes_count, None))
            
        except Exception as e:
            print(f"❌ Error processing {claude_file}: {e}")
    
    return changes_made

def update_base_memory_files(workspace_path: Path, dry_run: bool = True):
    """Update base memory files to include claude-code-agents"""
    core_principles_path = workspace_path / "memories/base/core-principles.md"
    
    if not core_principles_path.exists():
        print(f"❌ Core principles file not found: {core_principles_path}")
        return
    
    try:
        with open(core_principles_path, 'r', encoding='utf-8') as f:
            content = f.read()
        
        # Add claude-code-agents integration principle if not present
        if "Claude Code Agents" not in content:
            new_principle = "12. **Claude Code Agents**: Leverage specialized sub-agents and output styles for focused development workflows"
            
            if dry_run:
                print("🔍 Would add Claude Code Agents principle to core-principles.md")
            else:
                # Add the new principle
                lines = content.split('\n')
                insert_idx = -1
                
                # Find the end of the numbered principles
                for i, line in enumerate(lines):
                    if re.match(r'^\d+\.', line):
                        insert_idx = i + 1
                
                if insert_idx > 0:
                    lines.insert(insert_idx, new_principle)
                    
                    backup_path = f"{core_principles_path}.backup.{datetime.now().strftime('%Y%m%d_%H%M%S')}"
                    shutil.copy2(core_principles_path, backup_path)
                    
                    with open(core_principles_path, 'w', encoding='utf-8') as f:
                        f.write('\n'.join(lines))
                    
                    print("✅ Added Claude Code Agents principle to core-principles.md")
    
    except Exception as e:
        print(f"❌ Error updating core principles: {e}")

def main():
    base_dir = "/Users/braydon/projects"
    workspace_path = Path(base_dir) / "claude-workspace"
    
    print("🔄 Claude Workspace Import Standardization")
    print("=" * 50)
    
    # Update base memory files
    print("\n📝 Updating base memory files...")
    update_base_memory_files(workspace_path, dry_run=True)
    
    # First run in dry-run mode
    print("\n📋 DRY RUN - Scanning for import statements to standardize...")
    changes = standardize_claude_imports(base_dir, dry_run=True)
    
    if not changes:
        print("✅ All imports already standardized!")
        return
    
    print(f"\n📊 Found {len(changes)} files with imports to standardize")
    for file_path, count, _ in changes:
        print(f"  • {count} imports in {file_path.relative_to(Path(base_dir))}")
    
    # Ask for confirmation
    response = input("\n❓ Proceed with standardization? (y/N): ").strip().lower()
    
    if response == 'y':
        print("\n🔄 Performing standardization...")
        update_base_memory_files(workspace_path, dry_run=False)
        standardize_claude_imports(base_dir, dry_run=False)
        print("\n✅ All imports standardized to claude-workspace!")
        print("🎯 Benefits:")
        print("  • Single source of truth for all memory modules")
        print("  • Updates to claude-workspace propagate everywhere")
        print("  • Consistent behavior across all projects")
        print("  • Claude Code agents integrated into all projects")
    else:
        print("❌ Operation cancelled")

if __name__ == "__main__":
    main()