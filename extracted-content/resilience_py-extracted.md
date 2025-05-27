# Extracted Content from resilience_py

**Original Path:** /Users/braydon/projects/work/resilience/resilience_py
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Financial Modeling Framework - Development Guidelines

Python-based financial modeling framework for film/TV production companies with parent-subsidiary structures.

## CRITICAL: Development Standards

### 1. Test-Driven Development (TDD) is MANDATORY
- YOU MUST write failing tests BEFORE any implementation
- Tests MUST define the desired functionality completely
- Implementation MUST be minimal to pass tests
- Refactoring MUST maintain green tests
- NO EXCEPTIONS to TDD process

### 2. Linting is REQUIRED for ALL Code
- ALL code MUST pass linting before commits
- Linting configs MUST be created during project setup
- Language-specific linters MUST be configured
- Code formatting MUST be automated where possible
- Linting errors MUST be fixed, not ignored

### 3. Pre-commit Hooks are ENFORCED
- Pre-commit hooks MUST be installed during setup
- Hooks MUST verify linting passes
- Hooks MUST run relevant tests
- Hooks MUST check for secrets/credentials
- Hooks MUST validate commit message format
- NO commits should bypass hooks

### 4. Git Integration from Start
- Git MUST be initialized immediately
- Feature branches MUST be used for all work
- Commits MUST be frequent and atomic
- Commit messages MUST follow conventional format
- Main branch MUST be protected

## Project Overview

**Purpose:** Build a comprehensive financial modeling framework for production companies that demonstrates financial stewardship to investors

**Status:** In Progress - Production Template Development Phase

**Type:** Financial Modeling Software - Python Framework

## Current Status

**Last Updated:** 2025-05-23

**Project Update:** New PRD and Requirements documents added. Need to implement missing components for complete financial modeling platform.

**What's Implemented:**
- Core financial models (Entity, Balance Sheet, P&L, Cash Flow)
- Parameter management system
- Intercompany transactions
- Production templates
- Strong test coverage (88%)

**What's Missing (Per PRD/Requirements):**
1. Revenue Recognition Engine - streaming, brands, tax credits, backend
2. Fee Calculation Engine - management (22%), overhead (12%), backend share (15%)
3. Production Financial Model - complete production lifecycle
4. Parent Company Consolidation - fee flows and eliminations
5. Investor Returns Calculator - IRR, waterfall, distributions
6. Scenario Planning Engine - sensitivity analysis
7. Reporting/Export - Excel, PDF, dashboards
8. Web Interface - Streamlit application

**Current Delegation Plan:**

### Phase 1: Core Financial Engine (Weeks 1-3)
**Test Developer:**
- Write tests for revenue recognition (all types and timing)
- Write tests for fee calculations
- Write integration tests for production → parent flows

**Developer:**
- Implement revenue recognition module
- Implement fee calculator
- Build production financial model

**Architect:**
- Design data flow architecture
- Optimize calculation performance
- Plan consolidation approach

**QA:**
- Set up validation framework
- Compare results to Excel benchmarks
- Monitor test coverage

### Phase 2: Investor & Analytics (Week 4)
**Test Developer:**
- Write tests for IRR calculations
- Write tests for distribution waterfall
- Write scenario planning tests

**Developer:**
- Implement investor returns calculator
- Build scenario engine

### Phase 3: Reporting & UI (Weeks 5-6)
**All Team:** Collaborate on Streamlit interface and reporting

**Next Immediate Tasks:**
1. Test Developer: Begin revenue recognition test suite
2. Developer: Prepare to implement revenue recognition
3. Architect: Document data flow design
4. QA: Set up calculation validation tools

## Technical Stack

- **Language:** Python 3.9+
- **Core Libraries:** pandas, numpy, Click
- **Testing:** pytest, pytest-cov
- **Linting:** flake8, black, isort, mypy
- **Visualization:** matplotlib, seaborn, plotly
- **Export:** openpyxl, xlsxwriter, ReportLab
- **Pre-commit:** pre-commit hooks for quality enforcement

## Architecture

**Package-based structure with clear separation of concerns:**

```
src/
├── models/          # Core business entities (Entity, Financial Statements)
├── data/            # Data persistence and parameter management
├── calculations/    # Financial engines and business logic
├── interfaces/      # CLI and interactive interfaces
├── reporting/       # Report generation and export functionality
└── utils/          # Shared utilities and helpers
```

## Implemented Components

1. **Entity System**
   - Core Entity class with parent-subsidiary relationships
   - Hierarchy management with descendants, siblings, and root parent
   - Entity parameter management and inheritance
   - Entity serialization with to_dict/from_dict methods

2. **Financial Data Structures**
   - FinancialPeriod with date range management
   - ProfitLossStatement with revenue/expense tracking
   - BalanceSheet with assets/liabilities/equity tracking
   - CashFlowStatement with three-section cash flow tracking

3. **Intercompany Transaction Framework**
   - Transaction creation between entities
   - Double-entry validation
   - Multi-currency support with exchange rates
   - Settlement tracking and audit trails

4. **Parameter Management System**
   - Parameter class with 8 data types support
   - ParameterManager with inheritance hierarchy
   - Entity-specific parameter overrides
   - Historical value tracking with timestamps
   - Parameter categorization and dependency management

5. **Production Template System (Tests Completed)**
   - Tests for 8 production types (feature film, TV series, etc.)
   - Template inheritance and customization
   - Template versioning and historical tracking
   - Template application to entities
   - Chart of accounts management
   - Tests currently failing (TDD approach)

## Development Workflow

1. **Requirements Gathering**
   - Interactive session with PM agent
   - Document functional requirements
   - Define acceptance criteria

2. **Test Definition**
   - Write failing tests for each requirement
   - Tests must be comprehensive
   - Include unit, integration, and e2e tests

3. **Implementation**
   - Write minimal code to pass tests
   - Follow linting standards
   - Commit frequently with hooks

4. **Refactoring**
   - Improve code while maintaining green tests
   - Ensure linting passes
   - Update documentation

## Multi-Agent Responsibilities

### Project Manager (PM)
- Gather requirements through interactive dialog
- Define project scope and task sequences
- Ensure TDD methodology is followed
- Monitor project compliance
- Coordinate agent assignments and handoffs
- Track progress without date dependencies

**Current PM Todo List:**
1. ✅ Coordinate parameter management implementation with Developer
2. ✅ Review parameter management tests and implementation results
3. ✅ Create usage guide for implemented components
4. 🔴 Assign production template system implementation to Developer
5. 🔴 Track test coverage metrics (currently 88%, exceeds 80% target)
6. 🔴 Update project progress documentation
7. 🔴 Ensure quality metrics continue to meet standards
8. 🟡 Coordinate financial calculation engine requirements
9. 🟡 Plan CLI interface development
10. 🔵 Prepare for investor documentation features

### Architect
- Design system architecture
- Ensure testability in design
- Define coding standards
- Setup linting configurations

### Test Developer
- Write comprehensive test suites
- Implement TDD workflow
- Configure testing frameworks
- Maintain test coverage metrics

### Developer
- Implement code to pass tests
- Follow linting standards
- Refactor for maintainability
- Document code properly

### Quality Assurance
- Verify TDD compliance
- Run linting checks
- Execute pre-commit hooks
- Validate test coverage

## Key Commands

```bash
# Setup development environment
make install-dev

# Run tests
make test

# Run tests with coverage
make test-cov

# Run linting checks
make lint

# Format code automatically
make format

# Run type checking
make type-check

# Setup pre-commit hooks
make setup-hooks

# Launch CLI
fm --help
```

## Code Quality Standards

### Testing Requirements
- Minimum 80% code coverage
- All features must have tests
- Tests must be meaningful, not just coverage
- Integration tests for all APIs
- E2E tests for critical paths

### Linting Standards
- Zero linting errors allowed
- Warnings must be addressed
- Code formatting must be consistent
- Complexity metrics must be acceptable
- Documentation linting required

### Git Standards
- Conventional commit messages
- Feature branch workflow
- PR reviews required
- CI/CD integration
- Protected main branch

## Issues and Decisions

**Decisions Made:**
- Language: Python 3.9+
- Testing: pytest for TDD
- Linting: flake8 + black
- CLI: Click framework
- Data: pandas for financial modeling
- Parameter types: 8 supported types with validation
- Entity relationships: parent-child hierarchy model

**Open Issues:**
- Specific investor documentation templates needed
- Impact measurement framework selection
- Risk analysis methodology choices
- Deployment and distribution strategy

## Agent Coordination

All agents coordinate through a single master document:
- **`COORDINATION.md`** - Single source of truth for all tasks, status, decisions, and communication
- Update this file regularly throughout the day
- Check it first thing when starting work
- All decisions, blockers, and progress tracked here

### Standard Agent Prompt Format
**IMPORTANT**: Use the comprehensive template in `AGENT_PROMPT_TEMPLATE.md` for all agent assignments.

The template includes:
1. **Role Identification**: Clearly state which agent role is being addressed
2. **Current Task**: Specific task to be completed
3. **Project Location**: Full path to project directory
4. **Context**: Background information, prerequisites, file locations
5. **Development Standards**: TDD, linting, pre-commit hooks (MANDATORY)
6. **Git Workflow**: Branch creation, commit standards, hook compliance
7. **File Locations**: Exact paths for all created files
8. **Key Functionality**: Detailed list of features to implement
9. **Testing Requirements**: Coverage standards and test types
10. **Documentation Standards**: What to update, where, and how
11. **Communication Protocol**: How to report completion and handoffs
12. **Success Criteria**: Measurable completion requirements
13. **Quality Checklist**: Verification steps before completion
14. **Next Steps**: What happens after task completion

All prompts must include:
- Explicit file paths
- Exact commands to run
- Specific documentation locations
- Clear handoff instructions
- Git workflow requirements
- Testing and quality standards

## Setup Instructions

1. Copy this template to new project directory
2. Run `./scripts/init_project.sh`
3. Follow interactive setup prompts
4. Verify all quality tools are configured
5. Begin development with TDD

Remember: Quality is not negotiable. TDD, linting, and pre-commit hooks are fundamental to our development process.