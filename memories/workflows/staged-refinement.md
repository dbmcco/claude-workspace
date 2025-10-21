# Staged Refinement Workflow

## Philosophy
Instead of competitive parallel development, use sequential specialized agents that build on each other's work. Each agent has a specific lens and expertise area, creating compound improvement through focused iteration.

## Agent Roles

### 1. Explorer Agent
- **Purpose**: Rapid prototyping and architectural exploration
- **Output**: 2-3 pseudocode approaches with trade-off analysis
- **Focus**: Speed over perfection, architectural options
- **Settings**: `explorer.json` - high creativity, broad context, fast iteration

### 2. Implementer Agent  
- **Purpose**: Full TDD implementation of chosen approach
- **Input**: Explorer's selected approach + requirements
- **Output**: Complete, tested implementation
- **Focus**: Code quality, test coverage, adherence to standards
- **Settings**: `implementer.json` - strict TDD, quality gates, detailed

### 3. Reviewer Agent
- **Purpose**: Critical analysis and improvement suggestions
- **Input**: Implementer's solution
- **Output**: Specific improvement recommendations
- **Focus**: Code quality, security, performance, maintainability
- **Settings**: `reviewer.json` - critical analysis, security-focused

### 4. Optimizer Agent
- **Purpose**: Performance and cleanup refinements
- **Input**: Reviewer feedback + implementation
- **Output**: Optimized final solution
- **Focus**: Performance, bundle size, runtime efficiency
- **Settings**: `optimizer.json` - performance-focused, profiling

## Workflow Sequence

```
Requirements → [Explorer] → Approaches → [Implementer] → Code → [Reviewer] → Feedback → [Optimizer] → Final
```

### Phase 1: Exploration
1. Explorer receives requirements
2. Generates 2-3 distinct approaches in pseudocode
3. Analyzes trade-offs (performance vs complexity, maintainability vs features)
4. Recommends approach with rationale
5. **Handoff**: Selected approach + architectural decisions

### Phase 2: Implementation  
1. Implementer takes selected approach
2. Follows TDD workflow strictly
3. Implements with full test coverage
4. Ensures quality gates pass
5. **Handoff**: Working, tested implementation

### Phase 3: Review
1. Reviewer analyzes implementation
2. Checks for security issues, code smells, edge cases
3. Suggests specific improvements
4. Validates against requirements
5. **Handoff**: Prioritized improvement list

### Phase 4: Optimization
1. Optimizer applies review feedback
2. Focuses on performance and efficiency
3. Maintains test coverage and quality
4. **Handoff**: Production-ready solution

## Handoff Protocol

Each agent creates a structured handoff document:

```markdown
## [Agent] Handoff to [Next Agent]

### Completed Work
- Key decisions made
- Files modified
- Tests added

### Recommendations
- Preferred approach/direction
- Important considerations

### Context for Next Agent
- Assumptions made
- Edge cases identified
- Performance considerations
```

## Agent Settings Architecture

```
settings/agents/
├── explorer.json      # High creativity, broad context
├── implementer.json   # TDD strict, quality focused  
├── reviewer.json      # Critical analysis, security
└── optimizer.json     # Performance, efficiency
```

## CLI Usage

```bash
# Run full staged refinement
claude staged-refinement "implement user authentication"

# Run single stage
claude explore "implement user authentication"
claude implement --from-exploration
claude review --from-implementation  
claude optimize --from-review
```

## Benefits Over Competition

- **Cumulative improvement** instead of parallel waste
- **Specialized expertise** per stage
- **Preserved context** between stages
- **Predictable resource usage** (4x focused work vs 3x parallel work)
- **Learning integration** - each stage builds on previous