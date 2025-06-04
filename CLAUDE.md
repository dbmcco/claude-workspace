# Claude Workspace Project Memory

@./memories/base/interaction-style.md
@./memories/base/core-principles.md
@./memories/base/code-standards.md
@./memories/base/version-control.md
@./memories/workflows/tdd.md
@./memories/workflows/llm-driven-development.md

## Project-Specific Context

**Purpose:** A modular, version-controlled system for managing Claude Code configurations across multiple development projects. This repository consolidates Claude Code memory files and settings into a reusable system that enables systematic optimization across an entire development workflow.

**Type:** Development Infrastructure / Configuration Management

**Current Focus:** Maintaining and evolving the modular Claude Code memory system for systematic optimization across all development projects.

## Architecture

This repository demonstrates the modular memory system in action:

```
claude-workspace/
├── memories/
│   ├── base/            # Universal standards
│   ├── project-types/   # Context for different project types  
│   └── workflows/       # Development workflows
├── templates/           # Ready-to-use CLAUDE.md templates
├── settings/            # Settings templates by project type
├── tools/              # Migration and optimization scripts
└── backup/             # Preserved original configurations
```

## Key Files

- **memories/base/**: Universal interaction style, principles, standards
- **memories/workflows/**: TDD workflow, LLM-driven development practices
- **memories/project-types/**: Context for experiments, personal, work, healthcare projects
- **templates/**: Ready-to-use CLAUDE.md templates for different project types
- **tools/**: Migration scripts and content extraction utilities
- **backup/**: Complete preservation of original configurations

## Common Commands

```bash
# Apply modular system to new project
cp templates/CLAUDE-experiments.md /path/to/project/CLAUDE.md

# Migrate existing projects
./tools/migrate-all-projects.sh

# Restore project-specific content 
./tools/restore-all-project-content.sh

# Extract content for analysis
./tools/extract-project-content.sh

# Test memory loading in any project
cd /path/to/project && claude "/memory"
```

## Memory Module Development

When enhancing the system:

1. **Edit base modules** for universal improvements
2. **Create new project-types** for specialized contexts  
3. **Add workflow modules** for new development practices
4. **Test with real projects** before wide deployment
5. **Document rationale** for all changes

## Current Status

✅ **Modular system deployed** to 25+ projects  
✅ **Content restoration completed** with project-specific context preserved  
✅ **GitHub publication** with comprehensive documentation  
✅ **Safety systems** including backup and rollback capabilities

## Remote Development with tmux

For persistent Claude Code CLI sessions on remote MacBook Air:

```bash
# Create persistent session
tmux new-session -d -s claude-dev

# Attach to session
tmux attach-session -t claude-dev

# Detach (keeps running): Ctrl+b, then d
# List sessions: tmux list-sessions
# Kill session: tmux kill-session -t claude-dev
```

**Workflow:**
1. SSH to MacBook Air
2. Start tmux session: `tmux new-session -s claude-work`
3. Run Claude Code CLI: `claude`
4. Detach when switching devices: `Ctrl+b` then `d`
5. Reattach later: `tmux attach-session -t claude-work`

**Pro tips:**
- Multiple projects: `tmux new-session -s project-name`
- New window: `Ctrl+b` then `c`
- Split panes: `Ctrl+b` then `%` (vertical) or `"` (horizontal)

## Recent Decisions

- Modular memory system successfully replaces monolithic CLAUDE.md files
- Import-based approach enables automatic propagation of optimizations
- Project-specific content preserved alongside universal standards  
- LLM-driven development principles integrated throughout system
- GitHub publication enables community benefit from systematic approach
- tmux integration enables persistent remote development sessions