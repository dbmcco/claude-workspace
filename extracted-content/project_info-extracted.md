# Extracted Content from project_info

**Original Path:** /Users/braydon/projects/work/LDA/dashboard_core/docs/project_info
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Dashboard Core - Analysis Project

This project focuses exclusively on data analysis and business requirements for dashboard projects, separating analysis from application development. It follows a multi-agent approach with specialized roles to consolidate knowledge from all existing dashboard projects.

## Current Status Summary

**IMPORTANT: We have established secure connectivity to production.**

- We are successfully querying the production database (`ldaoi1pgsdev01.lda.corp`)
- The Database Specialist has completed the System-First SQL implementation plan
- The Data Analyst is implementing CSV exports with the System-First approach (restart required due to context limits)
- We're using a sequence-based task progression model with Git workflow integration

## Key Architectural Change

We've transitioned from a "Project-First" to "System-First" approach that:
- Starts with systems in logs rather than project mappings
- Uses both explicit mappings AND pattern matching for system identification
- Provides complete historical data coverage (2009-2025)
- Discovers additional systems missing from current project mappings

## Project Goals

1. Consolidate business requirements from all dashboard projects
2. Document LDA_warehouse schema and connection patterns
3. Establish standard analysis methodologies and metrics
4. Create templates for common reports and visualizations
5. Define data enrichment processes for integrating with spreadsheets

## Project Structure

- `/dev_team/` - Role-specific documentation and specialized knowledge
  - `/dev_team/ANALYST.md` - Analyst role definition and responsibilities
  - `/dev_team/DATABASE_SPECIALIST.md` - Database specialist role definition
  - `/dev_team/VISUALIZATION_EXPERT.md` - Visualization expert role definition
  - `/dev_team/COORDINATION_PLAN.md` - Multi-agent coordination framework
  - `/dev_team/COMMUNICATION_POLICY.md` - Communication protocols and templates
  - `/dev_team/messages/` - Role-specific and team-wide messages
  - `/dev_team/status/` - Status reports from all roles
- `/docs/` - Core documentation for analysis methodology and requirements
- `/data/` - Data dictionaries and sample datasets
- `/analysis/` - Analysis methodologies and standard calculations
- `/templates/` - Report templates and standardized visualizations

## Multi-Agent Model

This project uses specialized roles to organize knowledge:

1. **Business Analyst** - Focuses on business requirements and metrics definitions
2. **Database Specialist** - Documents database schemas and connection patterns 
3. **Visualization Expert** - Defines visualization standards and report templates
4. **Data Analyst** - Implements calculations against actual data, creates queries
5. **Development Manager** - Coordinates implementation and resolves alignment issues

## Role Onboarding Instructions

When starting work as a specific role, follow these steps:

1. **Review Role Definition**
   ```bash
   # For Analyst role
   cat /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/ANALYST.md
   
   # For Database Specialist role
   cat /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/DATABASE_SPECIALIST.md
   
   # For Visualization Expert role
   cat /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/VISUALIZATION_EXPERT.md
   ```

2. **Check Communication Policy**
   ```bash
   cat /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/COMMUNICATION_POLICY.md
   ```

3. **Review Coordination Plan**
   ```bash
   cat /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/COORDINATION_PLAN.md
   ```

4. **Check Latest Messages**
   ```bash
   # For Data Analyst role messages
   ls -la /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/messages/DATA_ANALYST/
   
   # For Database Specialist messages
   ls -la /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/messages/DATABASE_SPECIALIST/
   
   # For Business Analyst messages
   ls -la /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/messages/BUSINESS_ANALYST/
   ```

5. **Review Latest Status Updates**
   ```bash
   ls -la /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/status/
   ```

6. **Review Latest Coordination Update**
   ```bash
   cat /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_core/dev_team/COORDINATION_UPDATE.md
   ```

## Communication Protocol

All project communication follows a structured approach defined in `/dev_team/COMMUNICATION_POLICY.md`. Key aspects include:

1. **Role-Specific Messages**
   - Located in `/dev_team/messages/[ROLE]/`
   - Used for direct communication between development manager and specific roles
   - Follow the specified template with timestamp, clear action items, and response requirements

2. **Status Updates**
   - Located in `/dev_team/status/`
   - Milestone-based updates from each role and development manager
   - Include completed work, in-progress items, blockers, and next steps

3. **Coordination Updates**
   - Located in `/dev_team/COORDINATION_UPDATE.md`
   - Provides project-wide status and coordination information
   - Updated whenever significant developments or milestone completions occur

## Role-Specific Documentation

### Business Analyst Resources
- Business requirements documentation: `/docs/BUSINESS_REQUIREMENTS.md`
- Analysis methodology guide: `/docs/ANALYSIS_METHODOLOGY.md`
- Metrics dictionary: `/docs/METRICS_DICTIONARY.md`
- Metrics tier definitions: `/docs/METRICS_TIER_DEFINITIONS.md`

### Database Specialist Resources
- LDA warehouse integration: `/docs/LDA_WAREHOUSE_INTEGRATION.md`
- Database assessment: `/docs/DATA_AVAILABILITY_ASSESSMENT.md`
- SQL standards: `/docs/SQL_STANDARDS.md`

### Data Analyst Resources
- Metrics implementation plan: `/docs/METRICS_IMPLEMENTATION_PLAN.md`
- Real data mandate: `/docs/REAL_DATA_MANDATE.md`
- Tier 1 metrics template: `/docs/TIER1_METRICS_TEMPLATE.md`

### Visualization Expert Resources
- Visualization standards: `/docs/VISUALIZATION_STANDARDS.md`
- Report templates: `/docs/REPORT_TEMPLATES.md`
- Dashboard layout recommendations: `/analysis/DASHBOARD_LAYOUT_RECOMMENDATIONS.md`

## Progress Tracking and Next Steps

### Sequence-Based Task Progression

We follow a sequence-based task progression model, rather than date-based deadlines. See `/dev_team/TASK_SEQUENCE_MODEL.md` for the current sequence status.

**Current Sequence: Historical Data Implementation with System-First Approach**

| Agent | Task | Status | Next Step |
|-------|------|--------|-----------|
| Senior Code Architect | Connection Pattern Enhancement | ✅ COMPLETE | N/A |
| Data Architect | SQL Optimization Guidance | ✅ COMPLETE | N/A |
| Data Analyst | System-First Approach Test Results | ✅ COMPLETE | N/A |
| Database Specialist | Revised SQL with System-First Approach | ✅ COMPLETE | N/A |
| Data Analyst | CSV Quality Fixes & System-First Exports | ⏳ IN PROGRESS | Implementing System-First exports |
| Business Analyst | Historical Context & Insights | ⏻ PENDING | Wait for Data Analyst handoff |
| Development Manager | Final Integration | ⏻ PENDING | Wait for Business Analyst handoff |

**ARCHITECTURAL CHANGE**: We've transitioned from a "Project-First" approach to a "System-First" approach. This fundamental change:
1. Starts with systems in logs rather than project mappings
2. Uses both explicit mappings AND pattern matching for system identification
3. Provides complete historical data coverage (2009-2025)
4. Discovers additional systems missing from current project mappings

The Database Specialist has completed the implementation plan in SYSTEM_FIRST_SQL_IMPLEMENTATION.md, and the Data Analyst is currently implementing CSV exports using this approach.

### Getting Started Tomorrow

When starting new sessions tomorrow, the sequence of agents to start and their initial prompts should be:

1. **Start with Data Architect**
```
I'm the business stakeholder for the dashboard_core project. You're our Data Architect responsible for ensuring database accuracy.

Please check the team announcement at /dev_team/messages/TEAM/2025-05-08_14-00_TIER1_IMPLEMENTATION_PLAN.md and the COLLABORATION_SEQUENCE.md document.

Your current task (Sequence 1) is to validate the database schema and create query templates for all Tier 1 metrics defined in /docs/FEATURE_BASED_TIERS.md. Please create:
1. /docs/DATABASE_SCHEMA_VALIDATION.md confirming the actual schema structure
2. /docs/TIER1_QUERY_TEMPLATES.md with reusable query templates

When complete, send the message: "My Tier 1 validation is complete. It's Database Specialist's turn to implement SQL queries."
```

2. **Then Database Specialist**
```
I'm the business stakeholder for the dashboard_core project. You're our Database Specialist responsible for SQL implementation.

Please check the team announcement at /dev_team/messages/TEAM/2025-05-08_14-00_TIER1_IMPLEMENTATION_PLAN.md and the COLLABORATION_SEQUENCE.md document.

Your current task (Sequence 2) is to implement SQL queries for all Tier 1 metrics following the Data Architect's validation. Your deliverable is:
- /docs/TIER1_SQL_IMPLEMENTATION.md with complete SQL for all 15 Tier 1 metrics

These queries will be run against three clients (Wellstar, Baycare, and UCSF), so ensure they use proper parameterization for client selection.

When complete, send the message: "My Tier 1 SQL implementation is complete. It's Data Analyst's turn for execution and exports."
```

3. **Then Data Analyst**
```
I'm the business stakeholder for the dashboard_core project. You're our Data Analyst responsible for execution and exports.

Please check the team announcement at /dev_team/messages/TEAM/2025-05-08_14-00_TIER1_IMPLEMENTATION_PLAN.md and the COLLABORATION_SEQUENCE.md document.

Your current task (Sequence 3) is to execute the SQL queries against all three client datasets and generate CSV exports. Your deliverables are:
1. CSV files in /reports/wellstar/, /reports/baycare/, and /reports/ucsf/ directories
2. /docs/TIER1_QUERY_EXECUTION.md with execution notes and observations

When complete, send the message: "My Tier 1 query execution and CSV exports are complete. It's Business Analyst's turn for review."
```

4. **Finally Business Analyst**
```
I'm the business stakeholder for the dashboard_core project. You're our Business Analyst responsible for requirements and insights.

Please check the team announcement at /dev_team/messages/TEAM/2025-05-08_14-00_TIER1_IMPLEMENTATION_PLAN.md and the COLLABORATION_SEQUENCE.md document.

Your current task (Sequence 4) is to review the CSV outputs and provide business context for all Tier 1 metrics. Your deliverables are:
1. /docs/TIER1_METRICS_GUIDE.md with interpretation guidance for all metrics
2. /docs/TIER1_PRELIMINARY_INSIGHTS.md with initial business insights

When complete, send the message: "My Tier 1 business context is complete. Ready for final integration."
```

### Project Status Summary (as of May 8, 2025)

#### Documentation Status

| Document | Status | Owner |
|---------|--------|-------|
| BUSINESS_REQUIREMENTS.md | Completed | Business Analyst |
| METRICS_DICTIONARY.md | Completed | Business Analyst |
| METRICS_TIER_DEFINITIONS.md | Completed | Development Manager |
| FEATURE_BASED_TIERS.md | Completed | Business Analyst |
| ANALYSIS_METHODOLOGY.md | Completed | Business Analyst |
| DATA_AVAILABILITY_ASSESSMENT.md | Completed | Database Specialist |
| LDA_WAREHOUSE_INTEGRATION.md | Completed | Database Specialist |
| SQL_STANDARDS.md | Completed & Updated | Development Manager |
| METRICS_IMPLEMENTATION_PLAN.md | Completed | Development Manager |
| REAL_DATA_MANDATE.md | Completed | Development Manager |
| TEST_RUN_RESULTS_DATA_ANALYST.md | Completed | Data Analyst |
| TEST_RUN_RESULTS_DATABASE_SPECIALIST.md | Completed | Database Specialist |
| TEST_RUN_RESULTS_BUSINESS_ANALYST.md | Completed | Business Analyst |

#### Implementation Status

| Component | Status | Owner | Due Date |
|-----------|--------|-------|----------|
| SQL Implementation Reset | Completed | Data Analyst | May 3, 2025 |
| Unique Users Metric | Completed | Data Analyst | May 3, 2025 |
| Session Calculation | Completed | Database Specialist | May 4, 2025 |
| Metrics Prioritization | Completed | Business Analyst | May 5, 2025 |
| Internal Test Validation | Completed | All Team | May 7, 2025 |
| Feature-Based Tiers Approach | Completed | Business Analyst | May 8, 2025 |
| Tier 1 Implementation Plan | In Progress | All Team | May 9, 2025 |
| Tier 3 Data Acquisition Planning | Completed | Database Specialist | May 7, 2025 |

#### Current Focus: Tier 1 Implementation for Three Clients

We're implementing all Tier 1 "Fundamental Facts" metrics for three clients (Wellstar, Baycare, and UCSF) by May 9, 2025. These metrics answer basic questions about "How many, when, who" and include:

1. **System Inventory**
   - System Count - Total number of unique systems
   - System List - Comprehensive list of all systems
   - System Access Status - Active/inactive status

2. **Basic Timeframes**
   - First Access Date - Date of first recorded access
   - Last Access Date - Date of most recent access
   - Access Lifespan - Time between first and last access

3. **User Counts**
   - Unique Users - Count of distinct users
   - User List - List of all users
   - User-System Matrix - Mapping of users to systems

4. **User Access Timeline**
   - User First Access - First access date by user
   - User Last Access - Most recent access by user
   - User Access Lifespan - Duration of user interaction

5. **Basic Volume Metrics**
   - Total Access Events - Count of interactions
   - Access Events by System - Distribution across systems
   - Access Events by User - Distribution by user

All results will be exported as CSV files to client-specific directories in `/reports`.

#### Critical Findings from Data Assessment

- Schema differs significantly from initial documentation:
  - No dedicated tables for systems, users, departments, or roles
  - Client identification requires complex mapping through multiple tables
  - No native session tracking in the schema

- Implementation feasibility categorized into tiers:
  - **Tier 1 (7 metrics)**: Immediately implementable with existing data
  - **Tier 2 (8 metrics)**: Require session calculation implementation
  - **Tier 3 (9 metrics)**: Require significant data acquisition

- Critical join strategy confirmed:
  - Must retrieve all log data first, then apply client mapping
  - Use LEFT JOINs to preserve log data integrity
  - Never filter logs by client/project initially

#### Project Mandates

1. **REAL DATA ONLY**: All implementation must use real data, real connections, and real code. No mock data, test connections, example code, or anything synthetic permitted.

2. **SQL-BASED IMPLEMENTATION**: All metrics must be implemented as SQL queries against the LDA_warehouse database, not as scripts or other analysis tools.

3. **PROPER JOIN STRATEGY**: All implementations must follow the critical join strategy to prevent artificial data limitations.

#### Multi-Agent Status

- **Business Analyst**: Working on metrics prioritization within each tier based on business value; due May 5, 2025

- **Database Specialist**: Working on session calculation implementation for Tier 2 metrics; due May 4, 2025

- **Data Analyst**: Implementing SQL-based unique users metric following established standards; due May 3, 2025

- **Development Manager**: Coordinating implementation plan, established SQL standards, and created metrics tier definitions; updated status on May 2, 2025

- **Visualization Expert**: Not yet onboarded; pending initial metric implementation

#### Implementation Timeline

```
May 2  May 3  May 4  May 5  May 6  May 7  May 8  May 9  May 10 May 11
|------|------|------|------|------|------|------|------|------|------|
   |      |
   |      └── Unique Users Implementation (DA)
   |
   └── SQL Standards (DM)
          |                |
          |                └── Metrics Prioritization (BA)
          |
          └── Session Calculation (DS)
                                  |                           |
                                  |                           └── Tier 3 Data Acquisition Plan (DS)
                                  |
                                  └── Additional Tier 1 Metrics (DA)
```

## Reference Materials

- LDA_warehouse schema documentation in `/tech/data_service`
- Visualization components from Dashboard_first
- Business requirements from dashboard_20250415
- Report templates from Dashboard_tactical_reports
- Multi-client architecture from Dashboard_OCI

## Next Coordination Update

The next coordination update will be issued on May 5, 2025, after reviewing the Unique Users implementation, session calculation approach, and metrics prioritization.