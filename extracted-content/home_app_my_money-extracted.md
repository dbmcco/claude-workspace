# Extracted Content from home_app_my_money

**Original Path:** /Users/braydon/projects/personal/home_app_my_money
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Integrated Development Pipeline Project Memory

## Project Focus
The Integrated Claude Development Pipeline aims to create a hybrid software development workflow that combines:
1. Interactive Claude sessions for creative, exploratory phases (requirements, planning)
2. Deterministic, headless Claude processing for structured implementation phases (TDD, coding, testing)

## Key Insights
Our revised understanding emphasizes:
- Early phases benefit from interactive dialog (PM/BA roles)
- Later phases need deterministic, repeatable processing (Developer/Tester roles)
- Output from each phase must feed structured input to the next
- The entire process should be orchestrated by scripts with clear handoffs

## Implementation Status
We've built the initial infrastructure:
1. Project initialization script (/apps/init_project.sh)
2. Project interview workflow (/apps/project_interview.sh)
3. Basic directory structure creation
4. Placeholder role scripts

## Critical Gaps
1. Role scripts are currently designed for interactive-only mode
2. Missing pipeline coordination between stages
3. Need structured output capture from interactive sessions
4. Headless processing scripts for test/code/test workflow not implemented
5. Artifact management between stages not addressed

## Next Steps
1. Revise role scripts to use the hybrid interactive/headless model
2. Implement export functions to capture outputs from interactive sessions
3. Create headless processing scripts for generating TDD tests from requirements
4. Build pipeline coordination for the test→code→test workflow
5. Add structured output parsers for each stage

## Technical Approach
- Interactive sessions should have export/capture mechanisms
- Headless sessions should follow strict input/output patterns
- Each script should validate its input and output
- Memory management should support both modes
- MCP server should provide deterministic tooling

## Key Workflow
1. PM/BA: Interactive sessions → Structured requirements
2. Architect: Semi-interactive review → Architecture spec
3. TDD: Headless processing → Test files
4. Developer: Headless implementation → Code files
5. Tester: Headless validation → Test results
6. Refinement: Mix of interactive review and headless fixes

Contents of /Users/braydon/Library/CloudStorage/OneDrive-Personal/Apps/app_my_money/CLAUDE.md (project instructions, checked into the codebase):

# MyMoney: Claude Code Agent Instructions

## Project Overview

MyMoney is a sophisticated personal finance application designed to handle complex financial scenarios across multiple entities (personal, business, and shared finances). The application provides specialized centers for tax planning, debt management, and account oversight, along with comprehensive transaction management and financial analytics.

## Current Implementation Status (Updated May 16, 2025)

1. **Core Infrastructure**: Next.js application with TypeScript, TailwindCSS, and PostgreSQL via Prisma ORM
2. **Entity Management**: Entity context provider and entity switching implemented
3. **Account Management**: Account listing and detail views with entity filtering
4. **Transaction Management**: 
   - Transaction listing with optimized rendering and filtering
   - Transaction Detail implementation completed with edit and split functionality
   - Transaction API endpoints for CRUD operations
   - Entity context integration throughout transaction flows
5. **Data Import**: Tiller Excel data import completed (4,349 transactions successfully imported to PostgreSQL)
6. **Authentication**: Basic test authentication system implemented
7. **Testing Approach**: Converted all testing to use real financial data patterns instead of mock data
8. **Developer Experience Tools**: Comprehensive suite of tools for enforcing real-data testing
9. **Database Migration**: Successfully migrated from SQLite to PostgreSQL

## Current Focus: PostgreSQL Migration Complete

We've successfully completed the PostgreSQL migration and data import:

1. **Database Migration**: Migrated from SQLite to PostgreSQL
2. **Schema Updates**: Updated schema for PostgreSQL compatibility
3. **Data Import**: Successfully imported all 4,349 Tiller transactions
4. **Verification**: Validated data integrity and entity relationships

Next steps include:
- Testing Transaction Detail feature with real data in PostgreSQL
- Verifying API performance with the larger dataset
- Continuing regression testing with real financial data
- Preparing for production deployment

## Current Sequence Documents

- `/dev_team/sequences/TRANSACTION_DETAIL_SEQUENCE.md` - Implementation plan
- `/dev_team/sequences/TRANSACTION_DETAIL_RELEASE_SEQUENCE.md` - Release plan
- `/dev_team/sequences/TRANSACTION_REGISTER_WORK_SEQUENCE.md` - Updated with real-data testing

## Implementation Timeline

| Phase | Description | Dates | Status |
|-------|-------------|-------|--------|
| Transaction List Integration | Initial data layer integration | May 7-9, 2025 | ✅ Complete |
| Transaction Detail Planning | Architecture & planning | May 10, 2025 | ✅ Complete |
| Transaction Detail Integration | Implementation & testing | May 11-14, 2025 | ✅ Complete |
| Mock Data Remediation | Remove synthetic data | May 14-16, 2025 | ✅ Complete |
| Documentation Updates | Update for real-data testing | May 16, 2025 | ✅ Complete |
| Developer Experience Tools | Create tooling for real-data testing | May 16-18, 2025 | ✅ Complete |
| PostgreSQL Migration | Migrate database to PostgreSQL | May 16, 2025 | ✅ Complete |
| Data Import | Import Tiller data to PostgreSQL | May 16, 2025 | ✅ Complete |
| Team Training | Training materials & session | May 19-20, 2025 | 🟡 In Progress |
| PR Approval Process | Update for real-data validation | May 20-21, 2025 | 🟡 Planned |
| Regression Testing | Comprehensive validation | May 14-20, 2025 | 🟡 In Progress |
| Release Preparation | Final review & documentation | May 20-22, 2025 | 🟡 Planned |
| Production Deployment | Feature release | May 23, 2025 | 🟡 Planned |

## Next Steps (When Session Resumes)

**See `/dev_team/status/PROJECT_MANAGER_EOD_MAY16_2025.md` for complete handoff**

1. Review end-of-day summary and check regression testing progress
2. Execute QA Engineer prompt for PostgreSQL testing (included in EOD doc)
3. Test Transaction Detail feature with real PostgreSQL data
4. Verify API performance with 4,349 transactions
5. Make Go/No-Go decision for May 23 release based on test results
6. Update PR template with real-data requirements if proceeding

## Real-Data Testing Approach

All testing must use real financial data patterns rather than synthetic data:

1. **Realistic Data Sources**:
   - Tiller Excel import (4,349 transactions now in PostgreSQL)
   - Real-world financial patterns (dates, amounts, descriptions)

2. **Entity Boundaries**:
   - Test with real entity relationships
   - Explicit security boundary testing
   - Multi-entity architecture testing

3. **Edge Cases**:
   - Large transactions (> $10,000)
   - Negative amounts (expenses)
   - Split transactions with proper reconciliation
   - Zero-amount transfers
   - Multiple currency formats

4. **Test Data Utilities**:
   - Real transaction patterns for fixtures
   - Sanitized but structurally accurate data
   - Entity relationship preservation

## Build/Test Commands
- Dev server: `npm run dev`
- Build: `npm run build`
- Lint: `npm run lint`
- Tests: `npm test` 
- Running a single test: `npm test -- tests/path/to/test.js`
- Integration tests: `npm run test:integration`
- Import Tiller data: `npm run import:tiller`

## Git Workflow

All development must follow our Git workflow:
- Create feature branches from `develop`
- Follow branch naming: `feature/feature-name`
- Use Conventional Commits format for commit messages
- Create PRs for merging to `develop`
- Require reviews before merging
- Delete branches after merging

Refer to `/dev_team/GIT_WORKFLOW.md` for detailed guidelines.

## Linter Instructions

Claude Code CLI should enforce our linting standards by:

1. Running ESLint with our configuration before making changes
2. Ensuring all code changes comply with our ESLint and Prettier rules
3. Following TypeScript strict mode guidelines
4. Maintaining proper import ordering (external libraries first, then internal)
5. Using consistent naming conventions (camelCase for variables/functions, PascalCase for types/interfaces/components)
6. Following project-specific patterns established in existing code
7. Detecting and preventing mock data patterns

When linting errors are detected, Claude should:
1. Flag the issues and suggest fixes
2. Follow fix patterns consistently across all files
3. Explain the reasoning behind linting rules when relevant

Refer to `/dev_team/LINTER_SETUP.md` for detailed configuration.

## Test-Driven Development

All development must follow Test-Driven Development (TDD) approach:
1. Write tests first using real data patterns
2. Implement code to make tests pass
3. Refactor while keeping tests passing

Maintain minimum test coverage thresholds:
- UI Components: 80%
- Services: 90%
- Utilities: 95%
- API Endpoints: 85%
- Overall: 80%

Refer to `/dev_team/TDD_GUIDELINES.md` for detailed guidelines.

## Todo Tool Usage

Claude should use the Todo tool to:
- Track development tasks
- Update task status as work progresses
- Break complex features into specific tasks
- Add estimated effort levels to tasks
- Mark tasks as `in_progress` when starting work
- Mark tasks as `completed` when finishing work

## WebSearch Tool Usage

Claude should use WebSearch to:
- Research best practices before implementation
- Find documentation for libraries
- Look up solutions to technical challenges
- Validate architectural decisions against industry standards

## Batch Tool Usage

Claude should use Batch for:
- Finding patterns across multiple files
- Running multiple search operations concurrently
- Analyzing code from multiple perspectives

## Task Tool Usage

Claude should use Task for:
- Complex analysis of codebase patterns
- Generating test strategies
- Planning refactoring operations
- Security analysis

## Sequence-Based Work Approach

Follow our sequence-based collaboration model for all development work:
1. Work should proceed according to defined sequence documents
2. Task dependencies must be respected
3. Quality gates must be passed before proceeding to next phase
4. Documentation must be updated alongside code

Refer to `/dev_team/COLLABORATION_MODEL.md` for detailed guidelines.

## Current Work Context - Regression Testing Phase

The current work focus is PostgreSQL regression testing before May 23 release:

1. **Database Migration**: ✅ PostgreSQL migration complete (May 16)
2. **Data Import**: ✅ 4,349 Tiller transactions imported (May 16)
3. **Next Priority**: Regression testing with PostgreSQL (May 17)
4. **Release Decision**: Go/No-Go pending test results
5. **Target Release**: May 23, 2025

Key documents:
- `/dev_team/status/PROJECT_MANAGER_EOD_MAY16_2025.md` - **CRITICAL: Read this first!**
- `/dev_team/status/POSTGRESQL_MIGRATION_COMPLETE.md` - Migration details
- `/dev_team/status/TILLER_DATA_IMPORT_COMPLETE.md` - Data import verification
- `/dev_team/testing/TRANSACTION_DETAIL_RELEASE_RECOMMENDATION.md` - Previous test results
- `/dev_team/sequences/TRANSACTION_DETAIL_RELEASE_SEQUENCE.md` - Release plan

## Code Style Guidelines
- TypeScript with strict type checking, interfaces for data structures
- JavaScript with ESLint configuration
- Use functional components with hooks in React
- Follow file structure organization by feature
- Imports: Group by external libraries first, then internal modules
- Use descriptive variable/function naming with camelCase
- Error handling: Try/catch blocks with specific error types
- Prefer async/await over promise chains
- Use absolute paths for imports when available
- Use real data patterns for all tests

## Testing
- Jest for unit tests
- React Testing Library for component tests
- Always use real data for testing
- Write tests for all new functionality

## Project Structure

```
app_my_money/
├── docs/                          # Documentation
│   ├── REQUIREMENTS.md            # Comprehensive requirements spec
│   ├── ARCHITECTURE.md            # System architecture overview
│   ├── IMPLEMENTATION_PLAN.md     # Phased implementation approach
│   ├── IMPLEMENTATION_SEQUENCE.md # Dependency-based build sequence
│   ├── architecture/              # Detailed architecture documents
│   ├── requirements/              # Detailed requirements by area
│   ├── api/                       # API documentation
│   └── testing/                   # Testing guidelines
├── src/                           # Source code
│   ├── pages/                     # Next.js pages
│   ├── components/                # React components
│   ├── api/                       # REST API endpoints
│   ├── services/                  # Service modules
│   ├── hooks/                     # Custom React hooks
│   ├── utils/                     # Utility functions
│   └── types/                     # TypeScript type definitions
└── dev_team/                      # Development team documentation
    ├── NEXT_STEPS.md              # Project roadmap and next steps
    ├── GIT_WORKFLOW.md            # Git workflow guidelines
    ├── TDD_GUIDELINES.md          # Test-driven development approach
    ├── LINTER_SETUP.md            # Linter configuration and usage
    ├── CLAUDE_CODE_TOOLS.md       # Claude Code CLI tools usage
    ├── COLLABORATION_MODEL.md     # Sequence-based work approach
    ├── roles/                     # Role definitions
    ├── prompts/                   # Implementation prompts
    ├── sequences/                 # Implementation sequences
    ├── tasks/                     # Detailed task assignments
    ├── status/                    # Implementation status reports
    ├── integration/               # Integration testing docs
    └── testing/                   # Testing reports and plans
```

## Communication Protocols and Documentation Standards

All team members MUST adhere to these communication and documentation protocols:

1. **Documentation Location Standards**:
   - Architecture documentation belongs in `/docs/architecture/`
   - API documentation belongs in `/docs/api/`
   - Testing guidelines belong in `/docs/testing/`
   - Team documentation belongs in `/dev_team/`
   - Status updates belong in `/dev_team/status/`
   - Integration testing documentation belongs in `/dev_team/integration/`
   - Testing reports belong in `/dev_team/testing/`

2. **File Naming Convention**:
   - Use ALL_CAPS_WITH_UNDERSCORES.md for all documentation files
   - Be specific in naming (e.g., ENTITY_CONTEXT_TEST_RESULTS.md not TEST_RESULTS.md)

## Technology Stack

- **Frontend**: Next.js with React and TypeScript
- **API Layer**: REST API endpoints with Next.js API routes
- **Database**: PostgreSQL with Prisma ORM
- **Authentication**: JWT with secure HttpOnly cookies
- **Financial Data**: Tiller Excel import (4,349 transactions)
- **AI Integration**: Claude API for financial insights
- **Styling**: TailwindCSS with custom design system
- **State Management**: React Context and SWR for data fetching
- **Data Visualization**: D3.js and React-based charting
- **Testing**: Jest, React Testing Library, Cypress

## Resources

- Full requirements in `/docs/REQUIREMENTS.md`
- Architecture details in `/docs/ARCHITECTURE.md`
- Implementation plan in `/docs/IMPLEMENTATION_PLAN.md`
- Implementation sequence in `/docs/IMPLEMENTATION_SEQUENCE.md`
- Next steps and priorities in `/dev_team/NEXT_STEPS.md`