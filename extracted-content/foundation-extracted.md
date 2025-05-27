# Extracted Content from foundation

**Original Path:** /Users/braydon/projects/experiments/agent_unified/foundation
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Foundation Layer Memory - Claude Code CLI

You are working on the **Foundation Layer** of the Agent Unified system. This layer provides core infrastructure components including data models, API patterns, utilities, and project standards.

## Current Layer Focus
**Foundation Layer**: Core shared utilities and standardization patterns

## Primary Responsibilities
1. **Data Model Management**: MongoDB/PostgreSQL abstractions with CRUD operations
2. **API Infrastructure**: GraphQL schema patterns and resolver implementations
3. **Utility Functions**: Connection management, logging, configuration handling
4. **Project Standards**: Compliance checking and template generation
5. **Quality Integration**: Ensure foundation supports TDD and quality gates

## Key Components in This Layer

### Data Models (`foundation/data/models/`)
- `base_model.py`: Core database abstraction with automatic timestamps
- `project_model.py`: Project data and metadata management
- `workflow_model.py`: Development workflow state tracking
- `quality_model.py`: Quality metrics and compliance data
- `session_model.py`: Agent session state persistence

### API Infrastructure (`foundation/api/`)
- `graphql/schema.graphql`: Unified GraphQL schema for project data
- `graphql/resolvers/`: Business logic for GraphQL operations
- `rest/endpoints.py`: REST API endpoints for simple operations

### Utilities (`foundation/utils/`)
- `connection_manager.py`: Database connection with retry logic and pooling
- `logger.py`: Centralized logging for debugging and monitoring
- `config_manager.py`: Configuration loading and environment management
- `validators.py`: Input validation and data sanitization

### Standards (`foundation/standards/`)
- `compliance_checker.py`: Automated project compliance assessment
- `template_generator.py`: Generate standardized project templates
- `quality_standards.py`: Define and enforce quality standards

## Design Principles for Foundation Layer

### 1. **Database Agnostic Design**
- Support both MongoDB (document) and PostgreSQL (relational)
- Provide consistent CRUD interface regardless of backend
- Handle connection pooling and retry logic automatically
- Include automatic timestamp management (created_at, updated_at)

### 2. **Quality Integration**
- All components must support TDD with comprehensive test coverage
- Error handling must be consistent and logged appropriately
- Performance must be optimized for high-throughput operations
- Security best practices must be built-in, not added later

### 3. **Claude Code CLI Integration**
- All utilities should work seamlessly with Claude Code CLI tools
- Configuration should be readable from both CLI and programmatic interfaces
- Logging should integrate with Claude's debugging capabilities
- State management should support multi-session coordination

### 4. **Extraction Standards**
From `agent_1_shared-data`, prioritize extracting:
- ✅ **High Priority**: Base model patterns, connection management, GraphQL schemas
- ✅ **Medium Priority**: Utility functions, logging patterns, validation logic
- ✅ **Low Priority**: Configuration examples, documentation templates

## Current Extraction Status

### ✅ Completed:
- Directory structure created
- Python project configuration (pyproject.toml, requirements.txt)
- Foundation layer initialization

### 🔄 In Progress:
- Converting JavaScript base model to Python equivalent
- Extracting connection management patterns
- Setting up logging infrastructure

### ⏳ Pending:
- GraphQL schema extraction and adaptation
- API resolver implementation
- Standards and compliance framework
- Comprehensive testing setup

## Quality Gates for Foundation Layer

Before handoff to Pipeline Layer:
- [ ] All data models have 90%+ test coverage
- [ ] Connection management handles failures gracefully
- [ ] API endpoints follow GraphQL best practices
- [ ] Utilities are documented and typed
- [ ] Standards framework is operational
- [ ] Integration tests pass with both MongoDB and PostgreSQL

## Tools Available
- **Read/Write/Edit**: For extracting and adapting code from source directories
- **Bash**: For running tests, installing dependencies, setting up databases
- **Glob/Grep**: For analyzing source code patterns and finding components
- **TodoWrite**: For tracking extraction and implementation progress

## Source Extraction Locations
- **agent_1_shared-data/models/**: Data model patterns and base classes
- **agent_1_shared-data/api/**: GraphQL schemas and resolver patterns
- **agent_1_shared-data/utils/**: Utility functions and connection management
- **agent_1_shared-data/schemas/**: Database schema definitions
- **agent_1_shared-data/scripts/**: Compliance and template generation tools

## Success Criteria
The foundation layer is ready when:
1. **Data abstraction** supports both document and relational databases
2. **API infrastructure** provides consistent GraphQL/REST patterns
3. **Utilities** handle common operations (logging, config, validation)
4. **Standards framework** can assess and enforce project compliance
5. **Quality integration** supports TDD and automated quality gates
6. **Claude CLI integration** works seamlessly with all components

Remember: This foundation will support all other layers, so focus on:
- **Reliability**: Components must work consistently
- **Performance**: Optimize for high-throughput operations  
- **Maintainability**: Code must be clean, typed, and well-documented
- **Testability**: Every component must be easily testable

The foundation layer sets the quality and reliability standards for the entire unified system.