# Claude Workspace Project Memory

@./memories/base/interaction-style.md
@./memories/base/core-principles.md
@./memories/base/code-standards.md
@./memories/base/version-control.md
@./memories/workflows/tdd.md
@./memories/workflows/llm-driven-development.md
@./memories/workflows/agent-coordination.md
@./memories/workflows/journal-intelligence.md
@./memories/workflows/task-synchronization.md
@./memories/workflows/paia-agent-system.md
@./memories/workflows/paia-automation-status.md

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
- **memories/workflows/**: TDD workflow, LLM-driven development, task synchronization, PAIA agent system
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
✅ **Task synchronization system** with specialist agents and hook-based automation
✅ **PAIA agent system** with contextual intelligence and cross-referencing capabilities
✅ **Production-ready autonomous agents** - sync and @paia systems fully operational
✅ **Skills migration** - Episodic workflows converted to on-demand skills with progressive disclosure

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

## Task Management Agent Usage

When Braydon requests task review and updates, use this standard workflow:

### 1. **Vault Scan First**
```bash
Task("@vault-task-scanner", "Perform comprehensive scan of Obsidian vault to discover all incomplete tasks, categorize by project, and identify sync gaps with Todoist")
```

### 2. **Assess Current State**
Review scanner results to understand:
- Total tasks found across vault vs current Todoist state
- New tasks since last sync
- Potential duplicates or organizational issues
- What should/shouldn't sync to Todoist

### 3. **Execute Sync Operations**
```bash
Task("@task-sync-specialist", "Based on vault scan results, sync tasks between Obsidian and Todoist with proper organization, deduplication, and section assignment")
```

### 4. **Verify Results**
- Check that both agents logged to Journal MCP and file-based audit log
- Confirm task organization uses standard sections: "This Week" (top) → context sections → "Parking lot" (bottom)
- Ensure no priority numbers remain in Todoist (Braydon doesn't use priorities)
- Verify projects match: Home, Dev, LFW, Navicyte, Aclara, Vista, Synthyra

**Location of Agents**: `/claude-workspace/agents/prompts/vault-task-scanner.md` and `task-sync-specialist.md`
**Operation Logs**: `/claude-workspace/logs/task-sync-operation-log.md`

## Recent Decisions

- Modular memory system successfully replaces monolithic CLAUDE.md files
- Import-based approach enables automatic propagation of optimizations
- Project-specific content preserved alongside universal standards
- LLM-driven development principles integrated throughout system
- GitHub publication enables community benefit from systematic approach
- tmux integration enables persistent remote development sessions
- Production-ready autonomous agent system for vault-wide task management and @paia instruction processing
- Specialized task management agents with dual logging system for comprehensive vault-Todoist synchronization
- **Skills architecture adopted** (October 2025) - Episodic workflows migrated to model-invoked skills for progressive disclosure

## Skills Integration

**Four personal skills created** in `~/.claude/skills/`:

1. **coordinating-sub-agents** - PM Claude → specialist delegation with Journal MCP learning
2. **syncing-task-completions** - Weekly task synchronization between daily notes and master lists
3. **processing-paia-tags** - Two-stage @paia instruction discovery and execution
4. **learning-from-outcomes** - Strategic Journal MCP logging for cross-session intelligence

**Architecture decision**: Skills for episodic workflows (delegation, sync, learning), CLAUDE.md for always-on context (standards, identity, project details).

**Benefits**: Progressive disclosure (metadata → instructions → resources) eliminates context cost for unused workflows while making comprehensive documentation feasible.