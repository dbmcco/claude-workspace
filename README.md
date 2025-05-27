# Claude Workspace

A modular, version-controlled system for managing Claude Code configurations across multiple development projects.

## Overview

This repository provides a complete, self-contained modular memory system for Claude Code that follows Claude's recursive memory discovery pattern. Deploy it once to your project workspace, and all projects automatically inherit consistent development standards while maintaining their own specific context.

## Key Features

- **Self-Contained Deployment**: Deploy once to your workspace root, works everywhere
- **Modular Memory System**: Reusable memory modules for interaction style, development principles, and workflows
- **Correct Claude Discovery**: Follows Claude Code's actual recursive memory discovery mechanism
- **Project-Type Templates**: Specialized configurations for different types of projects
- **LLM-Driven Development**: Incorporates modern LLM-driven development principles
- **No Runtime Dependencies**: Complete standalone system after deployment

## Architecture

```
your-projects/
├── .claude/                    # Deployed claude-workspace (self-contained)
│   ├── CLAUDE.md              # Root memory with modular imports
│   ├── memories/
│   │   ├── base/              # Universal standards
│   │   ├── project-types/     # Context for different project types
│   │   └── workflows/         # Development workflows
│   ├── settings/              # Claude Code settings templates
│   ├── tools/                 # Migration and setup scripts
│   └── templates/             # Template files for reference
├── personal/
│   ├── CLAUDE.md              # Category-level memory
│   └── my-app/
│       └── CLAUDE.md          # Project-specific memory
├── experiments/
│   ├── CLAUDE.md              # Category-level memory
│   └── ai-project/
│       └── CLAUDE.md          # Project-specific memory
└── work/
    ├── CLAUDE.md              # Category-level memory
    └── client-project/
        └── CLAUDE.md          # Project-specific memory
```

## Quick Start

### 1. Clone and Deploy

```bash
# Clone the workspace
git clone https://github.com/your-username/claude-workspace.git

# Deploy to your projects root (creates self-contained system)
cd your-projects-directory
cp -r claude-workspace/./ .claude/

# Clean up the source (no longer needed)
rm -rf claude-workspace
```

### 2. Create Category-Level Memories

```bash
# Create category memories that import from .claude
cat > personal/CLAUDE.md << 'EOF'
# Personal Projects Memory

@../.claude/memories/base/interaction-style.md
@../.claude/memories/base/core-principles.md
@../.claude/memories/workflows/tdd.md
@../.claude/memories/project-types/personal.md

## Personal Project Context
These are productivity and personal tools, typically full-stack applications.
EOF
```

### 3. Create Project-Level Memories

```bash
# Create project-specific memory
cat > personal/my-app/CLAUDE.md << 'EOF'
# My App Project Memory

@../../.claude/memories/base/interaction-style.md
@../../.claude/memories/base/core-principles.md
@../../.claude/memories/workflows/tdd.md
@../../.claude/memories/project-types/personal.md

## Project Overview
This app does X, Y, and Z...

## Current Focus
Working on feature ABC...
EOF
```

### 4. Test Memory Discovery

```bash
cd personal/my-app
claude
# In Claude session:
/memory
# Should show all imported memories
```

## How Claude Code Memory Actually Works

### Memory Discovery Pattern

Claude Code uses **recursive directory discovery** starting from your current working directory:

1. **Project Level**: Looks for `CLAUDE.md` in current directory
2. **Parent Directories**: Recursively searches up to root (`/`)
3. **User Level**: Loads `~/.claude/CLAUDE.md` for personal preferences

**Key Insight**: Claude looks for `CLAUDE.md` files **directly in directories**, not inside `.claude` subdirectories, with one exception: `~/.claude/CLAUDE.md` for user-level settings.

### Our Pattern

We leverage this by placing a `.claude/CLAUDE.md` file at your workspace root, which Claude discovers when working in any subdirectory project. This provides the universal base memory that all projects inherit.

```bash
# When working in personal/my-app/, Claude finds:
personal/my-app/CLAUDE.md           # Project-specific
personal/CLAUDE.md                  # Category-level  
.claude/CLAUDE.md                   # Universal base (via ../../.claude/CLAUDE.md)
```

## Memory Module Structure

### Base Memories (Universal)
- **interaction-style.md**: Personal interaction preferences and collaboration model
- **core-principles.md**: Universal development principles (TDD, modular architecture)
- **code-standards.md**: Coding standards and conventions
- **version-control.md**: Git workflow and commit standards

### Workflow Memories
- **tdd.md**: Test-driven development workflow with quality gates
- **llm-driven-development.md**: Modern LLM-driven development practices

### Project Type Memories
- **experiments.md**: AI agent frameworks and research projects
- **personal.md**: Full-stack applications and productivity tools  
- **work.md**: Enterprise applications with compliance requirements
- **healthcare-analytics.md**: HIPAA-compliant healthcare data projects

## Import Path Patterns

Based on your project depth, use the correct relative path:

```bash
# From project root (depth 1): your-projects/my-project/
@./.claude/memories/base/interaction-style.md

# From category/project (depth 2): your-projects/personal/my-app/
@../../.claude/memories/base/interaction-style.md

# From nested project (depth 3): your-projects/work/client/sub-project/
@../../../.claude/memories/base/interaction-style.md
```

## Project Templates

### Minimal Project Memory
```markdown
# Project Name

@../../.claude/memories/base/interaction-style.md
@../../.claude/memories/base/core-principles.md
@../../.claude/memories/workflows/tdd.md
@../../.claude/memories/project-types/personal.md

## Project Overview
[What this project does]

## Current Focus
[What you're working on now]

## Key Files
- [Important files and their purposes]
```

### Comprehensive Project Memory
```markdown
# Project Name

@../../.claude/memories/base/interaction-style.md
@../../.claude/memories/base/core-principles.md
@../../.claude/memories/base/code-standards.md
@../../.claude/memories/base/version-control.md
@../../.claude/memories/workflows/tdd.md
@../../.claude/memories/workflows/llm-driven-development.md
@../../.claude/memories/project-types/experiments.md

## Project Overview
[Detailed project description]

## Implementation Status
[Current status and timeline]

## Architecture
[Key architectural decisions]

## Build/Test Commands
```bash
npm run dev
npm test
```

## Technology Stack
- [Technologies used]

## Resources
- [Links to important documentation]
```

## Category-Level Memories

Create category memories to provide context for groups of related projects:

### Personal Projects
```markdown
# Personal Projects Memory

@../.claude/memories/base/interaction-style.md
@../.claude/memories/workflows/tdd.md
@../.claude/memories/project-types/personal.md

## Personal Project Context
These are productivity and personal finance tools, typically full-stack JavaScript/TypeScript applications.

## Common Technologies
- Frontend: React, Next.js, TypeScript
- Backend: Node.js, PostgreSQL, Prisma
- Testing: Jest, React Testing Library
```

### Work Projects
```markdown
# Work Projects Memory

@../.claude/memories/base/interaction-style.md
@../.claude/memories/workflows/tdd.md
@../.claude/memories/project-types/work.md

## Work Project Context
Professional applications with compliance focus and enterprise requirements.

## Compliance Requirements
- Security-first development
- Audit trails and logging
- Data privacy protection
```

## Deployment Tools

The `tools/` directory contains scripts to help with deployment:

### Setup Script
```bash
# tools/setup-workspace.sh
#!/bin/bash
# Deploys claude-workspace to target directory
TARGET_DIR=${1:-".claude"}
cp -r memories/ settings/ tools/ CLAUDE.md "$TARGET_DIR/"
echo "Claude workspace deployed to $TARGET_DIR"
```

### Migration Script
```bash
# tools/migrate-projects.sh
#!/bin/bash
# Helps migrate existing projects to use the new system
find . -name "CLAUDE.md" -exec cp {} {}.backup \;
# Additional migration logic...
```

## Best Practices

### Memory Organization

**Keep memories focused and specific:**
- ✅ Small, single-purpose modules
- ✅ Clear import paths
- ✅ Project-specific content in project files
- ❌ Massive monolithic memory files

### Import Strategy

**Layer your imports strategically:**
```markdown
# Always include these basics
@../../.claude/memories/base/interaction-style.md
@../../.claude/memories/base/core-principles.md

# Add workflow-specific memories
@../../.claude/memories/workflows/tdd.md

# Include project-type specific context
@../../.claude/memories/project-types/experiments.md
```

### Project Customization

**Structure project-specific content:**
- Overview and current focus
- Key files and their purposes
- Build/test commands
- Technology stack
- Recent decisions and rationale

## Validation

### Test Memory Loading
```bash
cd your-project
claude
/memory  # Shows all loaded memories
```

### Verify Imports
```bash
# Check that relative paths resolve correctly
ls ../../.claude/memories/base/interaction-style.md
```

### Validate Coverage
- Each project should import base interaction style
- Workflow memories should match project type
- Project-specific content should be preserved

## Migration from Existing Systems

### 1. Backup Current Configuration
```bash
cp -r ~/.claude ~/.claude.backup
find your-projects -name "CLAUDE.md" -exec cp {} {}.backup \;
```

### 2. Deploy New System
```bash
cd your-projects
git clone https://github.com/your-username/claude-workspace.git
cp -r claude-workspace/./ .claude/
rm -rf claude-workspace
```

### 3. Migrate Projects Gradually
Start with one project, validate it works, then apply to others:
```bash
# Test with one project first
cd personal/test-project
# Create CLAUDE.md with imports
# Test with /memory command
# Apply to other projects once validated
```

## Troubleshooting

### Memory Not Loading
- Check relative path depths (`../../` vs `../../../`)
- Verify files exist at import paths
- Use `/memory` command to see what's loaded

### Import Errors
- Ensure no spaces around `@` symbol
- Check file paths are exactly correct
- Verify target files have proper content

### Missing Context
- Check that category-level memories exist
- Verify project-type imports are included
- Ensure project-specific content is preserved

## Claude Code Documentation

This system follows official Claude Code patterns:

- **Memory Discovery**: [Claude Code Memory Guide](https://docs.anthropic.com/en/docs/claude-code/memory)
- **Settings**: [Claude Code Settings](https://docs.anthropic.com/en/docs/claude-code/settings)
- **CLI Usage**: [Claude Code CLI Guide](https://docs.anthropic.com/en/docs/claude-code/cli-usage)

## Contributing

1. Test changes in isolated projects first
2. Document rationale for memory module changes
3. Use conventional commit messages
4. Validate effectiveness across different project types
5. Follow LLM-driven development principles

## License

MIT License - Feel free to adapt for your own development workflow optimization.