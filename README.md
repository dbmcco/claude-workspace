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

## Contributing

1. Test changes in isolated projects first
2. Document rationale for modifications
3. Use conventional commit messages
4. Validate effectiveness before wide application

## License

MIT License - Feel free to adapt for your own development workflow optimization.