# Claude Workspace

A modular, version-controlled system for managing Claude Code configurations across multiple development projects.

## Overview

This repository consolidates Claude Code memory files and settings into a reusable, modular system that enables systematic optimization across an entire development workflow.

## Key Features

- **Modular Memory System**: Reusable memory modules for interaction style, development principles, and workflows
- **Project-Type Templates**: Specialized configurations for different types of projects (experiments, personal, work, healthcare)
- **LLM-Driven Development**: Incorporates modern LLM-driven development principles and patterns
- **Automatic Propagation**: Changes to base modules instantly benefit all projects using the system
- **Safe Migration**: Complete backup and restoration tools for existing configurations

## Architecture

```
claude-workspace/
├── memories/
│   ├── base/            # Universal standards (interaction style, core principles)
│   ├── project-types/   # Context for different project types
│   └── workflows/       # Development workflows (TDD, LLM-driven)
├── templates/           # Ready-to-use CLAUDE.md templates
├── settings/            # Claude Code settings templates
├── tools/              # Migration and optimization scripts
└── backup/             # Preserved original configurations
```

## Quick Start

### 1. Clone and Setup
```bash
git clone https://github.com/your-username/claude-workspace.git
cd claude-workspace
```

### 2. Apply to New Project
```bash
# Copy appropriate template
cp templates/CLAUDE-experiments.md /path/to/your-project/CLAUDE.md

# Customize project-specific sections
# The universal standards are automatically imported
```

### 3. Optimize Across Projects
```bash
# Enhance a base module
edit memories/workflows/tdd.md

# Commit the change
git commit -m "Enhance TDD workflow with new requirement"

# All projects using this module automatically inherit the enhancement
```

## Memory Modules

- **interaction-style.md**: Personal interaction preferences and collaboration model
- **core-principles.md**: Universal development principles (TDD, modular architecture, quality gates)
- **tdd.md**: Test-driven development workflow with quality enforcement
- **llm-driven-development.md**: Modern LLM-driven development practices

## Project Types

- **experiments**: AI agent frameworks and research projects
- **personal**: Full-stack applications and productivity tools  
- **work**: Enterprise applications with compliance requirements
- **healthcare-analytics**: HIPAA-compliant healthcare data projects

## Tools

- **migrate-all-projects.sh**: Apply modular system to existing projects
- **restore-all-project-content.sh**: Restore project-specific content from backups
- **extract-project-content.sh**: Analyze existing configurations for patterns

## Safety Features

- Complete backup system before any changes
- Version control for all configurations
- Rollback capabilities for individual projects
- Incremental migration approach

## Benefits

- **Consistency**: Same standards across all projects
- **Maintainability**: Update once, apply everywhere
- **Evolution**: Track and optimize development practices over time
- **Scalability**: Easy to add new project types and standards

## How Claude Code Memory Works

### Memory Discovery and Loading

Claude Code automatically discovers memory files using a recursive directory traversal system:

1. **Project Memory**: Looks for `CLAUDE.md` files starting from current working directory up to root
2. **User Memory**: Loads `~/.claude/CLAUDE.md` for personal preferences across all projects
3. **Import System**: Uses `@path/to/import` syntax to include additional memory files
4. **Recursive Imports**: Supports up to 5 levels of nested imports for modular composition

```markdown
# Example project CLAUDE.md with imports
@~/claude-workspace/memories/base/interaction-style.md
@~/claude-workspace/memories/workflows/tdd.md
@~/claude-workspace/memories/project-types/experiments.md

## Project-Specific Context
[Your custom content here]
```

When Claude Code starts, it automatically:
1. Finds your project's `CLAUDE.md`
2. Follows all `@` import links
3. Loads content from imported files
4. Combines everything into Claude's working memory

### Memory Verification

Use the `/memory` command in Claude Code to see which memory files are loaded:
```bash
cd your-project
claude
# In Claude session:
/memory
```

## Best Practices

### Memory Organization

**Keep memories small and focused:**
- ✅ `interaction-style.md` - How to address you and communicate
- ✅ `tdd.md` - Specific workflow for test-driven development
- ❌ `everything.md` - Massive file with all project info

**Use conditional imports strategically:**
```markdown
# Only import what's relevant for the project type
@~/claude-workspace/memories/base/core-principles.md
@~/claude-workspace/memories/project-types/experiments.md  # Python AI projects
@~/claude-workspace/memories/workflows/tdd.md
```

### Granular Rules (LLM-Driven Development)

Following modern LLM development practices:

**Write ticket-sized memory modules:**
```markdown
# ✅ Good: Focused rule
# TDD Workflow
- Write tests before implementation
- Ensure >80% test coverage
- Run linting before commits

# ❌ Bad: Overly broad rule  
# Development Process
- TDD, architecture, deployment, testing, documentation...
```

**Use the LLM to generate consistent memories:**
```bash
# Let Claude help create new memory modules
claude "Generate a memory module for API design standards based on our existing patterns"
```

### Project-Specific Customization

**Structure your project CLAUDE.md files:**
```markdown
# Universal imports (same across similar projects)
@~/claude-workspace/memories/base/interaction-style.md
@~/claude-workspace/memories/workflows/tdd.md

# Project-type specific
@~/claude-workspace/memories/project-types/experiments.md

## Project-Specific Context
**Purpose:** [What this specific project does]
**Current Focus:** [What you're working on right now]

## Key Files
- [List important files and their purposes]

## Common Commands
```bash
# Project-specific setup and workflows
```

## Recent Decisions
[Date]: [Decision and rationale]
```

### Settings Management

**Organize settings by project type:**
- `settings/python-project.json` - Python development tools
- `settings/javascript-project.json` - JS/TS development tools
- `settings/healthcare-analytics.json` - HIPAA-compliant project settings

**Use appropriate permissions:**
```json
{
  "permissions": {
    "allow": [
      "Bash(pytest:*)",
      "Bash(black:*)", 
      "Bash(mypy:*)",
      "WebFetch(domain:docs.python.org)"
    ]
  }
}
```

### Quality Gates

**Validate memory effectiveness:**
- Test new memory modules with real projects
- Ask Claude to verify understanding: "What are our development principles?"
- Use `/memory` command to confirm imports are loading
- A/B test different memory configurations for effectiveness

## Usage Example

When you enhance the TDD workflow:
```bash
# 1. Edit base module
edit memories/workflows/tdd.md
# Add: "Run security scans before deployment"

# 2. Commit change
git commit -m "Add security scan requirement to TDD workflow"

# 3. All projects automatically inherit this enhancement
# Next time Claude Code runs in any project, it includes the new requirement
```

## Claude Code Documentation

This system leverages official Claude Code features. For detailed information:

- **Memory Management**: [Claude Code Memory Guide](https://docs.anthropic.com/en/docs/claude-code/memory)
- **Settings Configuration**: [Claude Code Settings](https://docs.anthropic.com/en/docs/claude-code/settings)
- **CLI Usage**: [Claude Code CLI Guide](https://docs.anthropic.com/en/docs/claude-code/cli-usage)
- **Security & Permissions**: [Claude Code Security](https://docs.anthropic.com/en/docs/claude-code/security)

### Key Claude Code Features Used

1. **Recursive Memory Discovery**: Automatic discovery of `CLAUDE.md` files from current directory up to root
2. **Import System**: `@path/to/import` syntax for modular memory composition (max 5 hops)
3. **Settings Hierarchy**: Project → User → Global settings precedence
4. **Memory Commands**: `/memory` to view loaded memories, `/config` for settings management

## Migration Strategy

### For Existing Projects

1. **Backup first**: Use `tools/extract-project-content.sh` to preserve existing content
2. **Start small**: Apply to 1-2 projects initially to validate approach
3. **Iterate**: Refine memory modules based on real usage
4. **Scale gradually**: Apply to more projects as you validate effectiveness

### For New Projects

1. **Choose template**: Select appropriate template from `templates/`
2. **Customize**: Edit project-specific sections
3. **Test imports**: Use `/memory` command to verify loading
4. **Evolve**: Update base modules as you discover better practices

## Contributing

1. Test changes in isolated projects first
2. Document rationale for modifications  
3. Use conventional commit messages
4. Validate effectiveness before wide application
5. Follow LLM-driven development principles (granular, ticket-sized changes)

## License

MIT License - Feel free to adapt for your own development workflow optimization.