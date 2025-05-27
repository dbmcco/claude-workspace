# Claude Workspace Project Memory

@~/claude-workspace/memories/base/interaction-style.md
@~/claude-workspace/memories/base/core-principles.md
@~/claude-workspace/memories/base/code-standards.md
@~/claude-workspace/memories/base/version-control.md
@~/claude-workspace/memories/workflows/tdd.md
@~/claude-workspace/memories/workflows/llm-driven-development.md

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

## Recent Decisions

- Modular memory system successfully replaces monolithic CLAUDE.md files
- Import-based approach enables automatic propagation of optimizations
- Project-specific content preserved alongside universal standards  
- LLM-driven development principles integrated throughout system
- GitHub publication enables community benefit from systematic approach