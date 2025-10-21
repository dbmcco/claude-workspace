# Agent Coordination Workflow

**Note**: This workflow has been migrated to a skill. Use the `coordinating-sub-agents` skill for comprehensive checklist-driven delegation. This file remains as reference documentation.

## PM Claude → Sub-Agent Pattern

### Core Principle
PM Claude NEVER codes directly - always delegates specialized work to focused sub-agents while maintaining user context and project coordination.

### Agent Coordination with Journal MCP

#### 1. **Task Delegation Logging**
Every time PM Claude delegates work, log the activity:
```typescript
await mcp__journal__log_agent_activity({
  agent_id: "@architect",
  task_description: "Design user authentication system",
  reasoning: "Complex security requirements need architecture expertise",
  outcome: "in_progress",
  evidence: { requirements_analyzed: true, security_patterns_identified: 3 },
  context: "User wants secure login with OAuth integration",
  project_path: process.cwd(),
  parent_request: "Add user authentication to the app"
});
```

#### 2. **Context Preservation**
Before delegating, get relevant context for the sub-agent:
```typescript
const context = await mcp__journal__get_agent_context({
  agentId: "@implementer",
  projectPath: process.cwd()
});
// Use context.userPatterns and context.relevantMemories to inform sub-agent
```

#### 3. **Cross-Session Learning**
Store session outcomes for future improvement:
```typescript
await mcp__journal__store_session_memory({
  sessionId: "session_" + Date.now(),
  userId: "Braydon",
  projectPath: process.cwd(),
  interactions: [{
    userInput: "Add expense tracking",
    agentResponse: "I'll delegate to @implementer for TDD approach",
    agentId: "pm_claude",
    topic: "feature_development", 
    entities: ["expenses", "tracking", "TDD"],
    timestamp: new Date()
  }]
});
```

### Specialized Sub-Agents

#### **@architect** - System Design
- Complex architecture decisions
- Database schema design
- Integration patterns
- Security considerations

#### **@implementer** - TDD Development  
- Write tests first, then implementation
- Follow quality gates (lint, type-check)
- Clean, maintainable code
- Performance-conscious development

#### **@tdd** - Test Specialist
- Comprehensive test coverage (>90%)
- Test strategy and framework setup
- Quality assurance and validation
- Test automation

#### **@quality** - Code Quality
- ESLint/TypeScript compliance
- Code review and refactoring
- Performance optimization
- Documentation standards

#### **@git** - Repository Management
- Commit message standards
- Branch management
- PR creation and merging
- Repository organization

### Agent Handoff Protocol

#### **1. Pre-Delegation Context Building**
```bash
# Get agent-specific context
Task("@context-analyzer", "Analyze current task requirements and identify optimal agent specialization")

# Check previous similar work
context = await mcp__journal__retrieve_relevant_memories({
  query: "similar task description",
  projectPath: process.cwd(),
  includePatterns: true
});
```

#### **2. Delegation with Evidence**
```bash
# Delegate with clear success criteria
Task("@implementer", "Implement user authentication following TDD principles. Context: [provide relevant patterns and memories]. Success criteria: tests pass, lint clean, type-safe.")

# Log the delegation
await mcp__journal__log_agent_activity({...});
```

#### **3. Post-Completion Learning**
```bash
# Update patterns based on outcomes
await mcp__journal__update_user_pattern({
  pattern: {
    patternType: "success_strategy",
    key: "authentication_implementation",
    value: "TDD approach with OAuth integration works well",
    confidence: 0.9,
    evidenceCount: 1
  },
  userId: "Braydon",
  projectPath: process.cwd()
});
```

### Quality Gates with Agent Coordination

#### **Every Agent Task Must:**
1. **Have clear success criteria** before delegation
2. **Pass quality gates** (lint, type-check, tests) before completion  
3. **Log outcomes** with evidence for future learning
4. **Update user patterns** when successful approaches identified

#### **PM Claude Responsibilities:**
1. **Never implement directly** - always delegate to specialists
2. **Provide context** from previous sessions and learned patterns
3. **Validate outcomes** against user requirements
4. **Learn from results** to improve future delegations

### Success Metrics

#### **Agent Effectiveness**
- Sub-agent task completion rate >90%
- Quality gate pass rate >95% 
- User satisfaction with outcomes >4/5
- Context relevance improvement over time

#### **Learning Progression**  
- Pattern confidence increases with evidence
- Delegation accuracy improves with experience
- User preference adaptation measurable
- Cross-project pattern sharing effective

### Integration with Existing Systems

#### **Works with Current Agent Fleet:**
- **@paia agents** for vault-wide instruction processing
- **@sync agents** for task synchronization across notes
- **Specialist agents** following same coordination pattern

#### **Compatible with:**
- Claude workspace modular memory system
- Obsidian MCP for vault intelligence  
- Reminders MCP for task management
- All existing project-specific agents

This agent coordination pattern transforms PM Claude from implementer to intelligent orchestrator, leveraging specialized sub-agents while maintaining context, learning from outcomes, and continuously improving delegation effectiveness.