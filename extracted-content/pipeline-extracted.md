# Extracted Content from pipeline

**Original Path:** /Users/braydon/projects/experiments/agent_unified/pipeline
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Pipeline Layer Memory - Claude Code CLI

You are working on the **Pipeline Layer** of the Agent Unified system. This layer provides LLM integration, state management, and automation components that power the unified agent system.

## Current Layer Focus
**Pipeline Layer**: LLM automation and state management

## Primary Responsibilities
1. **LLM Integration**: Multi-vendor abstraction across Claude, OpenAI, and local models
2. **Language Advisor**: Intelligent programming language and technology selection
3. **State Management**: Persistent session state across agent handoffs
4. **Telemetry**: Usage tracking, cost estimation, and performance metrics
5. **Automation**: PRD-to-code workflows and code generation

## Key Components in This Layer

### LLM Adapters (`pipeline/llm/adapters/`)
- `base_adapter.py`: Abstract adapter with common functionality
- `claude_adapter.py`: Anthropic Claude integration
- `openai_adapter.py`: OpenAI GPT models integration
- `ollama_adapter.py`: Local LLaMA models via Ollama
- `registry.py`: Unified registry for adapter selection and routing

### Advisors (`pipeline/llm/advisors/`)
- `language_advisor.py`: Technology stack recommendation engine
- `architecture_advisor.py`: System architecture guidance
- `quality_advisor.py`: Code quality recommendations

### Prompt Management (`pipeline/llm/prompts/`)
- `prompt_manager.py`: Template management and versioning
- Templates for different development phases (architecture, testing, etc.)
- Reusable prompt patterns with parameter substitution

### State Management (`pipeline/state/`)
- `session_manager.py`: Persistent session state
- `workflow_state.py`: Development workflow tracking
- `context_manager.py`: Agent context and handoff management
- `checkpoint_manager.py`: Rollback and recovery points

### Telemetry (`pipeline/telemetry/`)
- `inference_logger.py`: LLM usage tracking and analysis
- `cost_tracker.py`: Budget monitoring and cost optimization
- `performance_monitor.py`: Response time and quality metrics
- `trace_manager.py`: Inference replay and regression testing

### Automation (`pipeline/automation/`)
- `prd_processor.py`: Product requirements document parsing
- `requirement_extractor.py`: Structured requirement extraction
- `workflow_orchestrator.py`: Pipeline coordination

## Design Principles for Pipeline Layer

### 1. **Multi-Vendor Abstraction**
- Unified interface across all LLM providers
- Consistent response format and error handling
- Automatic fallback and retry mechanisms
- Provider-specific optimization where beneficial

### 2. **State Persistence**
- Sessions must survive across restarts
- Incremental state updates with versioning
- Human-readable state for debugging
- Secure handling of sensitive context

### 3. **Performance Optimization**
- Smart batching of related requests
- Cached responses for deterministic operations
- Efficient prompt template management
- Resource-aware scheduling

### 4. **Telemetry and Monitoring**
- Fine-grained usage tracking
- Cost estimation and budget enforcement
- Performance bottleneck identification
- Quality metrics for LLM outputs

### 5. **Claude Code CLI Integration**
- Seamless integration with Claude Code CLI agents
- Memory file synchronization
- State-aware tool usage
- Contextual prompt enhancement

### 6. **Extraction Standards**
From `agent_integrated_dev_pipeline`, prioritize extracting:
- ✅ **High Priority**: LLM adapters, state management, telemetry system
- ✅ **Medium Priority**: Language advisor, prompt templates, automation scripts
- ✅ **Low Priority**: Example configurations, documentation templates

## Current Extraction Status

### ✅ Completed:
- LLM adapter extraction and adaptation
- State management system design and implementation
- Telemetry framework setup and integration
- Language advisor integration

### 🔄 In Progress:
- Prompt registry implementation
- Automation component extraction
- Integration with Foundation layer

## Quality Gates for Pipeline Layer

Before handoff to Quality Layer:
- [x] All LLM adapters have 90%+ test coverage
- [x] State persistence works across agent restarts
- [x] Telemetry captures all usage metrics
- [x] Language advisor makes appropriate recommendations
- [x] Cost tracking provides accurate estimates
- [ ] Integration tests with Foundation layer pass

## Tools Available
- **Read/Write/Edit**: For extracting and adapting code from source directories
- **Bash**: For running tests, installing dependencies, testing API calls
- **Glob/Grep**: For analyzing source code patterns and finding components
- **TodoWrite**: For tracking extraction and implementation progress

## Source Extraction Locations
- **agent_integrated_dev_pipeline/llm_adapters/**: LLM provider integration
- **agent_integrated_dev_pipeline/state/**: State management system
- **agent_integrated_dev_pipeline/telemetry/**: Logging and cost tracking
- **agent_integrated_dev_pipeline/language_advisor.py**: Tech recommendations
- **agent_integrated_dev_pipeline/prompt_registry/**: Prompt management

## Success Criteria
The pipeline layer is ready when:
1. **Multi-vendor LLM calls** work consistently with proper error handling
2. **State management** maintains context across different agent sessions
3. **Language advisor** provides intelligent technology recommendations
4. **Telemetry** tracks usage, cost, and performance accurately
5. **Integration** with Foundation layer is complete

Remember:
- Multi-vendor support is critical for flexibility
- Error handling must be robust for production use
- Performance and cost tracking affect project viability
- Clear abstractions ensure easy extension to new providers

The pipeline layer is the engine that powers the entire unified agent system, connecting human strategic input with quality-driven implementation.