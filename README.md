# Claude Workspace

⚠️ **Work in Progress** - Experimenting with modular Claude Code memory management to solve context window bloat.

A modular, version-controlled system for managing Claude Code configurations across multiple development projects.

## Key Features

- **Self-Contained Deployment**: Deploy once to your workspace root, works everywhere
- **Context-Efficient Hierarchy**: Lean project imports (3) + rich category inheritance (7)
- **Modular Memory System**: Reusable modules for interaction style, development principles, workflows
- **Follows Claude Discovery**: Uses Claude Code's recursive memory discovery mechanism

## Architecture

```
your-projects/
├── .claude/                    # Deployed workspace (self-contained)
│   ├── memories/
│   │   ├── base/              # interaction-style, core-principles, code-standards
│   │   ├── workflows/         # tdd, llm-driven-development
│   │   └── project-types/     # personal, work, experiments
│   └── settings/              # Claude Code settings templates
├── personal/
│   ├── CLAUDE.md              # Category-level memory (7 imports)
│   └── my-app/
│       └── CLAUDE.md          # Project-level memory (3 imports)
```

## Quick Start

### 1. Deploy to Workspace

```bash
git clone https://github.com/dbmcco/claude-workspace.git
cd your-projects-directory
cp -r claude-workspace/./ .claude/
rm -rf claude-workspace
```

### 2. Create Category Memory

```bash
# personal/CLAUDE.md - Rich context for all personal projects
@../.claude/memories/base/interaction-style.md
@../.claude/memories/base/core-principles.md
@../.claude/memories/base/code-standards.md
@../.claude/memories/workflows/tdd.md
@../.claude/memories/project-types/personal.md
```

### 3. Create Project Memory

```bash
# personal/my-app/CLAUDE.md - Lean essentials only
@../../claude-workspace/memories/base/core-principles.md
@../../claude-workspace/memories/workflows/tdd.md
@../../claude-workspace/memories/project-types/personal.md

## Project Overview
[What this project does]

## Current Focus
[What you're working on now]
```

## Key Pattern: Context-Efficient Hierarchy

**Problem**: Importing 7+ memories per project bloats context window.

**Solution**: 
- **Category-level**: Rich context (7 imports) - shared across project group
- **Project-level**: Lean essentials (3 imports) - project-specific focus
- **Claude discovers both** via recursive search automatically

**Benefits**: Projects get full context inheritance without import duplication.

## Memory Modules

### Base Memories
- **interaction-style.md**: Personal preferences (address as "Bray.Doc", collaboration style)
- **core-principles.md**: Universal development principles (TDD, modular architecture)
- **code-standards.md**: Coding conventions and file organization

### Workflows
- **tdd.md**: Test-driven development with quality gates
- **llm-driven-development.md**: Modern LLM development patterns

### Project Types
- **personal.md**: Full-stack applications and productivity tools
- **work.md**: Enterprise applications with compliance requirements
- **experiments.md**: AI frameworks and research projects

## Import Path Patterns

```bash
# From category/project (depth 2): your-projects/personal/my-app/
@../../.claude/memories/base/interaction-style.md

# From nested project (depth 3): your-projects/work/client/project/
@../../../.claude/memories/base/interaction-style.md
```

## Best Practices

### Context-Efficient Pattern (RECOMMENDED)
- **Project imports**: 3-4 strategic essentials only
- **Category imports**: Comprehensive context stack
- **Let Claude's recursive discovery handle inheritance**

### Anti-Patterns
- ❌ Don't import everything at every project level
- ❌ Don't create massive context in individual projects
- ❌ Don't ignore Claude's hierarchical discovery

## Documentation Notes

Written by Claude, proof-read by Braydon. Reflects ongoing LLM development experiments.

## License

MIT License - Feel free to adapt for your own development workflow optimization.