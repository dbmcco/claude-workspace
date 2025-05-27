# Extracted Content from agent_unified

**Original Path:** /Users/braydon/projects/experiments/agent_unified
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a **unified multi-agent development system** that consolidates best practices from multiple agent architectures into a streamlined, quality-driven workflow. The system uses **Claude Code CLI as the primary agent** with role-specific memory files and event-driven coordination.

**Important Context**: This system was loosely based on Microsoft AutoGen but has diverged to focus on TDD, development tool integration, and quality enforcement.

### Four-Tier Architecture (Under Review)

```
agent_unified/
├── foundation/     # Tier 1: Core data models, APIs, utilities
├── pipeline/       # Tier 2: LLM adapters, automation, telemetry  
├── quality/        # Tier 3: TDD enforcement, quality gates
└── coordination/   # Tier 4: Event-driven agent handoffs
```

**Architectural Issues Identified**: 
- Circular dependencies between layers (Quality needs Foundation, Foundation needs Quality)
- Considering migration to hexagonal architecture
- External review in progress by Software Architect Agent

## Current Development Status (May 25, 2025)

### ✅ Completed Components

1. **PRD Processing Pipeline** (May 24)
   - Fixed token limits and async bugs
   - Two-phase extraction working (business + technical)
   - Human-readable documentation generation
   - Tested with MealMap example

2. **Architecture Planning** (May 25)
   - Simple architecture generator working
   - Generates from test specifications
   - Creates markdown plans and JSON specs

3. **Coordination Layer Core** (May 25)
   - **EventBus**: Complete event-driven communication system
   - **AgentCoordinator**: Full multi-agent orchestration (850+ lines)
   - Integration tests passing
   - State persistence working

4. **Test Developer Agent** (May 25)
   - Complete implementation in quality/roles/test_developer/
   - Generates Jest/Vitest tests from architecture
   - CLAUDE.md memory file with TDD principles
   - Validated with MealMap example

### 🚧 In Progress

1. **Developer Agent** (Next Priority)
   - Assignment created for implementation
   - Will use CodeGenerator from pipeline
   - Implements code to pass Test Developer tests
   - Completes the TDD cycle

2. **Software Architect Review**
   - Analyzing our divergence from AutoGen
   - Evaluating hexagonal architecture migration
   - Addressing circular dependency issues
   - Gap analysis for dev tool integration

### ⏳ Pending Components

1. **WorkflowManager** - Complex workflow orchestration
2. **HumanAgentInterface** - Strategic checkpoints
3. **Full Pipeline Integration** - End-to-end PRD → Code test

## Active Development Threads

### Thread 1: Core Agent Implementation
**Status**: Building Test Developer → Developer agent flow
**Next Steps**: 
1. Complete Developer Agent implementation
2. Test full TDD cycle with MealMap
3. Validate generated code actually works

### Thread 2: Architecture Review
**Status**: Software Architect analyzing gaps and AutoGen alignment
**Deliverables Expected**:
1. Divergence analysis from AutoGen
2. Hexagonal architecture migration plan
3. Dev tool integration architecture
4. Phased implementation roadmap

### Thread 3: Development Tool Integration
**Critical Gap**: Need comprehensive dev tool integration
**Required Components**:
- GitAdapter for version control workflows
- IDE integration (VSCode, IntelliJ)
- Test framework adapters
- Linting orchestration
- CI/CD pipeline integration

## Working Scripts

### End-to-End Pipeline
```bash
# Complete PRD → Architecture pipeline
python run_full_pipeline.py your_prd.md

# Or run interactively
python run_full_pipeline.py
# Then paste PRD and end with --- on a new line
```

### PRD Processing Only
```bash
# Interactive PRD processing with commit options
python run_prd_test.py
```

### Architecture Generation
```bash
# Generate architecture from existing test specs
python simple_architecture.py output_TIMESTAMP
```

## Architecture Decision Made ✅

The Software Architect has completed analysis and recommends **keeping our current architecture** with simple fixes. No major refactoring needed!

### Key Decision Points Resolved:
1. **Architecture**: Stay with current design, fix minor issues
2. **AutoGen**: We're specialized for TDD; AutoGen is too generic
3. **Timeline**: 2 weeks to completion, not 3 months

## 2-Week Sprint Plan (Starting May 27, 2025)

### Week 1: Simple Architecture Fixes
**Day 1 (2 hours)**: Fix Circular Dependencies
- Move shared utilities to `common/` directory
- Simple file moves, no logic changes

**Days 2-3**: Add Revision Mechanism
- Enhance EventBus with `request_revision()` method
- Enable bidirectional agent communication

**Days 4-5**: Add Checkpoint/Rollback
- Enhance StateManager with JSON snapshots
- Simple recovery mechanism

### Week 2: Tool Integration & Testing
**Days 1-3**: Dev Tool Integration
- GitAdapter: Basic git operations
- TestRunner: pytest/jest execution
- Simple, practical implementations

**Days 4-5**: End-to-End Testing
- Full pipeline validation
- PRD → Architecture → Tests → Code → Git
- Document any findings

## Current Development Status (May 26, 2025)

### ✅ Major Milestones Complete
1. **TDD Cycle Working**: Test Developer → Developer Agent flow complete
2. **Coordination Layer**: EventBus + AgentCoordinator operational
3. **Architecture Decision**: Simple fixes, no major refactor
4. **All Core Agents**: Test Developer & Developer Agents complete

## Key Learnings & Best Practices

### Model Configuration
```bash
# In .env file
ANTHROPIC_API_KEY=your_key_here
DEFAULT_LLM_MODEL=claude-sonnet-4-20250514  # Use exact model name
```

### Working Patterns
1. **Agent Implementation Pattern**:
   - Create agent class in quality/roles/{role}/
   - Create CLAUDE.md memory file
   - Use existing pipeline components
   - Add demos and validation
   - Full linting before commit

2. **Commit Standards**:
   - Always run black, isort, flake8
   - Use conventional commit format
   - Include Co-Authored-By for Claude
   - Update tracking documents

3. **Testing Pattern**:
   - Use existing output directories for testing
   - Start with simple examples, then complex
   - Validate generated code actually works

### Important Technical Notes
1. **Claude SDK is synchronous** - Don't use `await` on `client.messages.create()`
2. **Token limits** - Use 12,000 for architecture, 4,000-8,000 for PRD phases
3. **PRD processor returns file paths** - Read test_specifications.json for actual data
4. **Two-phase extraction** - Business analysis first, then technical specs
5. **Feature name matters** - Use descriptive names like "mealmap_mvp"

## Current Blockers

1. **Architecture Pattern** - Circular dependencies need resolution
2. **Dev Tool Integration** - No clear implementation path
3. **Full Pipeline Validation** - Haven't proven end-to-end flow works
4. **AutoGen Alignment** - Unclear if we should reconverge

## Development Commands

### Setup and Installation
```bash
# Install core dependencies (REQUIRED for Claude integration)
pip install pydantic pyyaml rich anthropic aiofiles httpx

# Install in development mode
pip install -e .

# Install with all dependencies
pip install -e ".[dev,docs]"

# Alternative: using poetry
poetry install --with dev,docs
```

### Claude API Setup
```bash
# Set environment variables (create .env file in project root)
ANTHROPIC_API_KEY=your_claude_api_key_here
DEFAULT_LLM_MODEL=claude-3-5-sonnet-20241022

# Test Claude integration
python3 -c "from pipeline.llm.adapters import chat; print('Claude available')"
```

### Code Quality and Testing
```bash
# Run all tests with coverage
pytest --cov=foundation --cov=pipeline --cov=quality --cov=coordination

# Run specific test categories
pytest tests/unit/          # Unit tests only
pytest tests/integration/   # Integration tests
pytest tests/e2e/          # End-to-end tests
pytest -m "not slow"       # Skip slow tests

# Code formatting and linting
black .                     # Format code
isort .                     # Sort imports
flake8 .                   # Check style
mypy .                     # Type checking
pylint foundation/ pipeline/ quality/ coordination/

# Run all quality checks
pre-commit run --all-files
```

### Quality Layer Operations
```bash
# Run comprehensive quality analysis
python -c "
from quality import QualityGateManager, ComplianceChecker, SecurityAnalyzer, PerformanceProfiler
import asyncio

async def run_quality_analysis():
    gate_manager = QualityGateManager('./project')
    compliance_checker = ComplianceChecker('./project')
    security_analyzer = SecurityAnalyzer('./project')
    performance_profiler = PerformanceProfiler('./project')
    
    # Run all quality checks
    gate_results = await gate_manager.run_gates()
    compliance_report = await compliance_checker.scan_compliance()
    security_report = await security_analyzer.scan_security()
    performance_report = await performance_profiler.analyze_performance()
    
    print(f'Quality Gates: {gate_manager.get_overall_status()}')
    print(f'Compliance Score: {compliance_report.compliance_score}%')
    print(f'Security Score: {security_report.security_score}%')
    print(f'Performance Score: {performance_report.performance_score}%')

asyncio.run(run_quality_analysis())
"

# Run specific quality components
python -m quality.gates.quality_gate_manager --project ./project
python -m quality.compliance.compliance_checker --frameworks pci_dss,owasp
python -m quality.security.security_analyzer --scan-types sast,secrets
python -m quality.performance.performance_profiler --include-system-metrics
```

### Pipeline Automation
```bash
# Run PRD processing (current working system)
python3 run_prd_test.py

# Alternative: Run complete PRD-to-code pipeline (when coordination layer complete)
python -m pipeline.automation.workflow.workflow_orchestrator \
  --prd examples/sample.prd \
  --language typescript \
  --framework react \
  --output ./output

# Test individual automation components
python pipeline/automation/code/example_usage.py

# Run integration tests for automation pipeline
pytest tests/integration/test_automation_pipeline.py -v
```

### LLM Adapter Testing
```bash
# Test Claude adapter
python -c "from pipeline.llm.adapters import claude_adapter; import asyncio; asyncio.run(claude_adapter.test_connection())"

# Test OpenAI adapter  
python -c "from pipeline.llm.adapters import openai_adapter; import asyncio; asyncio.run(openai_adapter.test_connection())"

# Test all adapters with fallback
python -m pipeline.llm.adapters.registry test
```

### Database Operations
```bash
# Test database connections
python -c "from foundation.data.models.base_model import BaseModel; BaseModel.test_connection()"

# Run database migrations (if any)
python scripts/utilities/db_migrate.py

# Test GraphQL schema
python -c "from foundation.api.graphql import test_schema; test_schema()"
```

## Core Components

### Foundation Layer (`foundation/`)
**Purpose**: Shared utilities, data models, and standards across all agents

- **Data Models** (`foundation/data/models/`): Database-agnostic CRUD with MongoDB/PostgreSQL support
- **GraphQL API** (`foundation/api/graphql/`): Unified API for agent data access
- **Connection Manager** (`foundation/utils/connection_manager.py`): VPN-aware database connections
- **Standards Framework** (`foundation/standards/`): Project compliance and templates

### Pipeline Layer (`pipeline/`) - **COMPLETED**
**Purpose**: LLM automation, state management, and PRD-to-code workflows

- **LLM Adapters** (`pipeline/llm/adapters/`): Multi-vendor support (Claude, OpenAI, Ollama) with unified interface
- **Prompt Registry** (`pipeline/llm/prompts/`): Versioned prompt templates with caching
- **State Management** (`pipeline/state/`): Async state persistence across agent sessions  
- **Telemetry System** (`pipeline/telemetry/`): Complete LLM interaction logging, cost tracking, performance monitoring
- **Automation Pipeline** (`pipeline/automation/`): Complete PRD-to-code workflow with 7 components:
  - PRDProcessor: Convert PRD documents to structured specifications
  - RequirementExtractor: Extract structured requirements from various sources
  - WorkflowOrchestrator: Complete pipeline orchestration
  - ArchitecturePlanner: Architecture planning and component design
  - TestGenerator: Generate tests from specifications (TDD)
  - CodeGenerator: Generate implementation code from tests
  - VerificationManager: Verify implementations against requirements

### Quality Layer (`quality/`) - **COMPLETED**
**Purpose**: Comprehensive quality assurance, compliance, security, and performance analysis

- **QualityGateManager** (`quality/gates/`): Configurable quality gates with dependency management and real-time monitoring
- **ComplianceChecker** (`quality/compliance/`): Multi-framework compliance checking (PCI DSS, HIPAA, GDPR, OWASP, ISO 27001, WCAG, etc.)
- **SecurityAnalyzer** (`quality/security/`): Automated vulnerability scanning with SAST, secret detection, and dependency analysis
- **PerformanceProfiler** (`quality/performance/`): Performance bottleneck detection and optimization recommendations
- **Real Tool Integration**: 30+ industry-standard tools (Bandit, ESLint, Semgrep, Safety, Radon, etc.)

### Coordination Layer (`coordination/`) - **PENDING**  
**Purpose**: Event-driven agent coordination and human interface

- **Event System** (`coordination/events/`): Quality gate triggers replace documentation
- **Human Interface** (`coordination/human/`): Strategic checkpoint approvals
- **Agent Handoffs** (`coordination/agents/`): Minimal context passing between roles

## Key Architectural Patterns

### Event-Driven Coordination
- **Quality gates trigger agent handoffs** instead of verbose documentation
- **JSON state objects** replace markdown communication between agents
- **Human checkpoints** for strategic input at key decision points

### Multi-LLM Integration
- **Unified interface** across Claude, OpenAI, and Ollama adapters
- **Automatic failover** and retry logic with telemetry
- **Cost tracking** and budget management across all providers

### Async-First Design
- **All pipeline operations** use async/await for performance
- **State persistence** across sessions and agent handoffs  
- **Concurrent processing** where possible

### Test-Driven Development (TDD)
- **Tests generated first** from specifications
- **Implementation follows tests** with verification
- **Quality gates** enforce TDD methodology automatically

## Agent Roles and Memory Files

Each agent role uses specialized CLAUDE.md files for context:

- `quality/roles/architect/CLAUDE.md` - Architecture planning and technical decisions
- `quality/roles/developer/CLAUDE.md` - Implementation following TDD principles
- `quality/roles/test_developer/CLAUDE.md` - Test creation and validation
- `quality/roles/qa/CLAUDE.md` - Quality assurance and verification
- `quality/roles/project_manager/CLAUDE.md` - Project coordination and oversight

## Current Status: Pipeline & Quality Layers Complete

✅ **Completed (80% of architecture)**:
- Foundation Layer: Data models, GraphQL API, utilities (4 components)
- Pipeline Layer: Complete PRD-to-Architecture automation (16 components)
  - ✅ Two-phase PRD extraction (business + technical)
  - ✅ Architecture generation with direct LLM integration
  - ✅ Human-readable documentation generator
  - ✅ Full telemetry and state management
- Quality Layer: Comprehensive quality framework (4 components)
  - ✅ Real working tools integration
  - ✅ Quality gates with dependency management

🎉 **Latest Achievements (2025-05-24)**:
- ✅ End-to-end pipeline: PRD → Architecture working
- ✅ Fixed all Claude integration issues (async, tokens, model names)
- ✅ Two-phase extraction for reliable PRD processing
- ✅ Human-readable docs with 6-tier organization
- ✅ Three working scripts for different use cases

⏳ **Next Phase**: Coordination Layer (20% remaining)
- AgentCoordinator: Multi-agent coordination
- EventBus: Event-driven communication
- WorkflowManager: Complex workflow orchestration
- HumanAgentInterface: Strategic human checkpoints

## Integration Points

### Telemetry Integration
All LLM interactions are automatically logged via `InferenceLogger` with:
- Token counting and cost estimation
- Performance metrics collection
- State tracking and error handling

### Prompt Registry
Use versioned prompt templates instead of inline prompts:
```python
from pipeline.llm.prompts import PromptAdapter

adapter = PromptAdapter()
result = await adapter.execute_prompt(
    "architecture_design_v1",
    project_specs=specs,
    language="typescript"
)
```

### State Management
Persist state across agent handoffs:
```python
from pipeline.state import StateManager

state = StateManager()
await state.set("current_phase", "implementation")
await state.set("test_results", test_data)
```

### Quality Layer Integration
Integrate quality checks into workflows:
```python
from quality import QualityGateManager, ComplianceChecker, SecurityAnalyzer, PerformanceProfiler

# Initialize quality components
gate_manager = QualityGateManager("./project")
compliance_checker = ComplianceChecker("./project")
security_analyzer = SecurityAnalyzer("./project")
performance_profiler = PerformanceProfiler("./project")

# Run quality gates before agent handoff
gate_results = await gate_manager.run_gates()
if gate_manager.get_overall_status() != GateStatus.PASSED:
    raise QualityGateFailure("Quality gates must pass before proceeding")

# Check compliance for specific frameworks
compliance_report = await compliance_checker.scan_compliance(
    frameworks=[ComplianceFramework.OWASP, ComplianceFramework.PCI_DSS]
)

# Automated security scanning
security_report = await security_analyzer.scan_security(
    scan_types=[SecurityScanType.SAST, SecurityScanType.SECRETS]
)

# Performance analysis
performance_report = await performance_profiler.analyze_performance(
    include_system_metrics=True,
    include_code_analysis=True
)
```

## Development Workflow

1. **Write tests first** (TDD methodology enforced)
2. **Use async operations** for all I/O and LLM calls
3. **Integrate telemetry** for new LLM interactions
4. **Update state** for workflow progression
5. **Check quality gates** before agent handoffs
6. **Document in specialized role CLAUDE.md files** not generic docs

## Environment Variables

```bash
# Database configuration (optional)
MONGODB_URI=mongodb://localhost:27017/agent_unified
POSTGRES_URI=postgresql://user:pass@localhost/agent_unified

# LLM API keys (at least one required)
ANTHROPIC_API_KEY=your_claude_key
OPENAI_API_KEY=your_openai_key
OLLAMA_BASE_URL=http://localhost:11434

# Quality tool configurations
ENABLE_PRE_COMMIT_HOOKS=true
DEFAULT_LANGUAGE=typescript
DEFAULT_TEST_FRAMEWORK=jest
```

## Common Integration Patterns

### Adding New LLM Providers
1. Create adapter in `pipeline/llm/adapters/`
2. Implement unified interface with telemetry integration
3. Register in `pipeline/llm/adapters/registry.py`
4. Add failover support and cost tracking

### Creating New Agent Roles
1. Define role in `quality/roles/{role_name}/`
2. Create specialized CLAUDE.md with role context
3. Add quality gates for role-specific triggers
4. Integrate with coordination event system

### Extending Automation Pipeline
1. Create component in `pipeline/automation/`
2. Integrate with WorkflowOrchestrator
3. Add telemetry and state management
4. Create integration tests in `tests/integration/`

The system is designed for minimal human coordination overhead while maintaining rigorous quality standards through automated quality gates and event-driven agent handoffs.