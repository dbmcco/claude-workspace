# Journal Learning Intelligence

**Note**: This workflow has been migrated to a skill. Use the `learning-from-outcomes` skill for comprehensive journal usage guidance. This file remains as reference documentation.

## Strategic Learning Protocol

Use the journal MCP to capture and apply strategic insights that improve future performance. The journal enables cross-session learning and pattern recognition across all project contexts.

### When to Use Journal MCP

#### ✅ **Write to Journal** (use `mcp__journal__log_agent_activity`):
- **After successful complex tasks** where you gained strategic insights about what works
- **When approaches exceed user expectations** and you understand the success factors
- **Pattern recognition moments** - 2nd+ time similar approach succeeds with clear understanding
- **Communication breakthroughs** - discovering effective collaboration styles with Braydon
- **Problem-solving insights** where you can articulate key success factors for replication

#### ❌ **Skip Journaling**:
- Simple information requests or factual lookups
- Routine code generation or boilerplate tasks  
- First attempts without understanding why they worked
- Status updates or progress reports without strategic insights
- Task completion notifications without learning content

### Quality Threshold for Journal Entries

**Only journal insights that would help future sessions perform better in similar scenarios.**

Focus on **WHY approaches worked**, not WHAT you did. Write natural reflections that capture learning patterns applicable beyond the specific technical context.

#### Example Strategic Insight
**Instead of**: "Implemented React optimization with Context API"

**Write**: "Discovered that systematic profiling reveals actual performance bottlenecks 80% of the time, while assumptions about bundle size often mislead. Context API consistently outperforms Redux for localized state when prop drilling causes excessive re-renders."

### Agent Coordination Learning

When delegating to sub-agents, journal insights about:
- **Delegation patterns that work well** with different types of tasks
- **Context that helps sub-agents succeed** in this project environment
- **Quality gate approaches** that catch issues early
- **Communication styles** that get best results from Braydon

### Cross-Session Context Retrieval

Before starting complex work, check journal for relevant patterns:
```typescript
const context = await mcp__journal__get_agent_context({
  agentId: "current_agent_role",
  projectPath: process.cwd()
});
```

Use retrieved patterns to inform approach and avoid previously unsuccessful strategies.

### Integration with Project Manager Role

For PM Claude configurations:
- **Log delegation decisions** with reasoning and outcomes
- **Capture successful coordination patterns** across sub-agents
- **Record what context helps sub-agents succeed** in this project
- **Learn Braydon's preferences** for project communication and progress updates

This learning intelligence works across all project types while respecting project-specific contexts and requirements.