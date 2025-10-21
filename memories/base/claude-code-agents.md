# Claude Code Agents and Output Styles

## Output Styles Integration

### Available Output Styles
- **Default**: Standard software engineering assistance with current memory system
- **Explanatory**: Educational mode with implementation insights and pattern explanations
- **Learning**: Collaborative mode with `TODO(Braydon)` markers for strategic implementation

### Custom Output Style Configuration
- **User-level styles**: `~/.claude/output-styles/` - Available across all projects
- **Project-level styles**: `.claude/output-styles/` - Project-specific behavior
- **Access**: Use `/output-style` command or `/output-style [style-name]`

### Braydon-Specific Output Styles

#### Project Manager Output Style
Custom output style that enforces PM-only role with sub-agent delegation:
- Never codes directly - always delegates to specialized sub-agents
- Maintains strategic context for Braydon
- Uses task interview system for requirement clarification
- Integrates with project status tracking

#### TDD-Focused Output Style  
Custom style optimized for test-driven development:
- Enforces RED→GREEN→REFACTOR cycle
- Quality gate compliance before proceeding
- Performance-first development approach
- Comprehensive test coverage requirements

## Sub-Agents Integration

### Specialized Sub-Agents Available

#### **@architect** - System Design Agent
- **Purpose**: Complex architecture decisions, database schema, integration patterns
- **Tools**: Read, Write, Bash (limited), WebSearch for research
- **Location**: `.claude/agents/architect.md`

#### **@implementer** - TDD Development Agent
- **Purpose**: Write tests first, then implementation following quality gates
- **Tools**: Full development toolkit with linting and testing
- **Location**: `.claude/agents/implementer.md`

#### **@quality** - Code Quality Agent
- **Purpose**: ESLint/TypeScript compliance, performance optimization
- **Tools**: Bash (linting), Read/Write for code review
- **Location**: `.claude/agents/quality.md`

#### **@research** - Information Gathering Agent
- **Purpose**: Technical research, documentation, pattern analysis
- **Tools**: WebSearch, WebFetch, Read (documentation focus)
- **Location**: `.claude/agents/research.md`

#### **@git** - Repository Management Agent
- **Purpose**: Commit standards, branch management, PR creation
- **Tools**: Bash (git commands), Read/Write for documentation
- **Location**: `.claude/agents/git.md`

### Sub-Agent Coordination Pattern

#### **Delegation Syntax**
```bash
# Delegate to specialized agent
Task("@implementer", "Implement user authentication following TDD principles with comprehensive test coverage")

# Multi-agent coordination
Task("@architect", "Design authentication system architecture")
# Wait for architecture completion
Task("@implementer", "Implement the designed authentication system")
Task("@quality", "Review and optimize authentication implementation")
```

#### **Context Preservation**
- All sub-agents inherit base memory modules from claude-workspace
- Project-specific context maintained through CLAUDE.md imports
- Agent coordination logged through journal MCP integration

### Configuration Standards

#### **Agent File Structure**
```markdown
---
name: "Implementer"
description: "TDD-focused development agent"
tools: ["Read", "Write", "Edit", "MultiEdit", "Bash", "TodoWrite"]
---

# Implementer Agent

@../../claude-workspace/memories/base/core-principles.md
@../../claude-workspace/memories/workflows/tdd.md

## Role
[Agent-specific instructions]
```

#### **Integration with Memory System**
- All agents reference claude-workspace memory modules
- Consistent behavior across all projects through centralized imports
- Agent-specific extensions stored in project `.claude/agents/` directory

## Usage Patterns

### **Project Manager Workflow**
1. **Analysis**: PM Claude analyzes request and determines required agents
2. **Delegation**: Specific tasks delegated to appropriate sub-agents
3. **Coordination**: Progress tracked through TodoWrite and status files  
4. **Context**: Strategic overview maintained for Braydon interactions

### **Direct Development Workflow**
1. **Output Style**: Select appropriate style (`/output-style tdd` or `/output-style explanatory`)
2. **Agent Selection**: Choose sub-agent for specific task types
3. **Quality Gates**: All implementations must pass linting, testing, and coverage
4. **Integration**: Changes committed following git workflow standards

### **Multi-Agent Project Workflow**
1. **Architecture Phase**: `@architect` designs system structure
2. **Implementation Phase**: `@implementer` builds following TDD principles
3. **Quality Phase**: `@quality` reviews and optimizes
4. **Documentation Phase**: `@research` creates comprehensive documentation
5. **Release Phase**: `@git` manages repository and deployment

This integration ensures consistent behavior across all Claude Code interactions while leveraging specialized capabilities for complex development workflows.