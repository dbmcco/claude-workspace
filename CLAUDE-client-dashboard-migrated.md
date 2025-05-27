# LDA Client Dashboard Project Memory

@~/claude-workspace/memories/base/interaction-style.md
@~/claude-workspace/memories/base/core-principles.md
@~/claude-workspace/memories/base/code-standards.md
@~/claude-workspace/memories/base/version-control.md
@~/claude-workspace/memories/workflows/tdd.md
@~/claude-workspace/memories/project-types/work.md
@~/claude-workspace/memories/project-types/healthcare-analytics.md

## Project-Specific Context

**Purpose:** Provide comprehensive analytics for healthcare archive systems to demonstrate value, optimize costs, and support data-driven decisions about system lifecycle management.

**Status:** Initial setup phase - consolidating business requirements

**Type:** Multi-tenant Analytics Dashboard

**Architecture Pattern:** Following the agent_unified model with modular, multi-tier architecture, agent-based coordination for complex tasks, and quality gates at each development stage.

## Current Focus

Consolidating business requirements from multiple dashboard projects to create a comprehensive, unified set of requirements that address all stakeholder needs.

## Key Files
- `PROJECT_STATUS.md` - Primary communication document
- `docs/business_analysis/` - User personas and requirements
- `docs/requirements/` - Functional requirements and PRD
- `mockUX/` - UI prototypes and designs

## Common Commands
```bash
# Project navigation
cd /Users/braydon/projects/work/LDA/client_dashboard

# Documentation updates
# Update PROJECT_STATUS.md after major tasks
# Document decisions in DECISIONS.md
# Track blockers in BLOCKERS.md
```

## Security & Compliance Notes
- [x] HIPAA compliance requirements identified
- [x] PHI handling protocols established
- [x] Client data segregation architecture planned
- [ ] Performance benchmarks defined (sub-3 second loading)

## Recent Decisions
[Date]: Following agent_unified architecture model for modular design and quality gates