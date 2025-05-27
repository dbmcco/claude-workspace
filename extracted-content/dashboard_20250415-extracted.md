# Extracted Content from dashboard_20250415

**Original Path:** /Users/braydon/projects/work/LDA/dashboard_core/extra_projects/dashboard_20250415
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Dashboard 20250415 - Project Memory

This file serves as Claude's project memory. It provides essential context about the project, current status, and guidance for development.

## Project Overview

**Purpose:** A unified dashboard platform that consolidates lessons from previous dashboard initiatives to create a comprehensive analytics platform for healthcare archive systems, supporting multiple clients and deployment options.

**Status:** 45% complete - Implementation phase

**Type:** Dashboard

## Current Status

**Last Updated:** April 29, 2025

**Recent Accomplishments:**
- Completed requirements gathering from previous dashboard projects
- Established technology stack and architecture
- Created initial project structure
- Designed unmapped datasets analysis feature to improve data coverage
- Created implementation plan for UCSF's enhanced system and user requirements
- Implemented and tested unmapped datasets analysis script
- Implemented and tested unmapped projects analysis script
- Implemented and tested enhanced system information script
- Created HTML-based report template with new visualizations
- Successfully tested features across multiple clients (UCSF, BLES, NGHS, UCLA)

**Current Focus:**
- Reconciling new report template with existing template
- Integrating unmapped datasets and projects analysis into main workflow
- Ensuring backward compatibility with existing reports
- Updating run scripts to include new analysis steps
- Implementing enhanced user information tracking

**Next Steps:**
- Complete the report template integration using the integration guide
- Update run_all_analyses.sh to always include the new analysis steps
- Update system_details_analysis.py to reference enhanced data
- Create dedicated documentation for users explaining the new features
- Improve CSS-based visualizations for HTML-only mode

## Technical Stack

- **Frontend:** React, TypeScript, Material UI, Chart.js, D3.js
- **Backend:** Node.js, GraphQL, Express
- **Database:** PostgreSQL
- **Deployment:** Containerized with Docker and Kubernetes

## Architecture

The dashboard uses a modular component architecture with a central GraphQL API for data access. It follows a multi-tenant design with strict data isolation between clients. Visualization components are separated from data fetching logic to allow for flexible display options while maintaining consistent data interpretation.

## Key Files

- `README.md` - Project documentation and setup instructions
- `README-Braydon's MacBook Pro.md` - Machine-specific configuration
- `README-Bs_Asus.md` - Machine-specific configuration
- `docs/ENHANCED_FEATURES_DOCUMENTATION.md` - Documentation of the new features
- `docs/REPORT_TEMPLATE_INTEGRATION_GUIDE.md` - Guide for integrating the new report template
- `docs/UNMAPPED_DATASETS_IMPLEMENTATION_PLAN.md` - Original implementation plan for unmapped datasets
- `docs/COMPREHENSIVE_MAPPING_PLAN.md` - Updated plan for both unmapped datasets and projects
- `docs/REPORTING_SYSTEM.md` - Documentation of the report generation system
- `scripts/analysis/unmapped_datasets_analysis.py` - Script for analyzing unmapped datasets
- `scripts/analysis/unmapped_projects_analysis.py` - Script for analyzing unmapped projects
- `scripts/analysis/data_profile_analysis.py` - Script for enhanced system information
- `scripts/run_all_analyses_updated.sh` - Updated run script with new analysis steps
- `data/outputs/Client_EnhancedReport_Template.py` - Original report template
- `data/outputs/Client_EnhancedReport_Template_UCSF.py` - New template with enhanced features
- `data/outputs/UCSF/UCSF_Improved_Report_20250429.html` - HTML-only enhanced report

## Database Strategy

- **Development:** Local PostgreSQL with synthetic data
- **Production:** Managed PostgreSQL with schema isolation per client
- **VPN Requirements:** Yes - Required for production data access

## Project-Specific Challenges

- **VPN Connectivity:** Will implement checkpoint-resume pattern for 3m46s VPN timeout
- **Multi-tenancy:** Planning schema-based isolation for client data separation
- **Integration Points:** Will connect to LDA Warehouse via GraphQL, with optional direct database access
- **Data Coverage:** Implemented unmapped datasets and projects analysis to identify incomplete mappings
- **Enhanced System Metrics:** Added system status, access type, and system type classification
- **User Access Tracking:** Tracking detailed system access history per user
- **Template Integration:** Need to reconcile new and existing report templates

## Implementation Results

Our implementation of the enhanced features has revealed important insights:

### Unmapped Datasets Analysis
This feature checks if datasets in logs are mapped to projects in the relationship data.

Key findings:
- For all clients tested (UCSF, BLES, NGHS, UCLA), all datasets in logs are properly mapped to projects
- This indicates good data quality in terms of dataset-to-project mappings
- The feature correctly identifies when datasets are properly mapped
- Output in `unmapped_datasets.csv` and `unmapped_datasets_summary.csv`

### Unmapped Projects Analysis
This feature checks if projects have database mappings in the project_details table.

Key findings:
- For UCSF: 56 total projects, but only 17 (30.36%) have database mappings
- For BLES: 20 total projects, but only 7 (35%) have database mappings
- This indicates a significant gap in project-to-database mappings
- The feature correctly identifies projects without database mappings
- Output in `unmapped_projects.csv` and `unmapped_projects_summary.csv`

### Enhanced System Information
This feature adds extended metadata to system details.

Key classifications:
- System Status: Active (used within last year), Static (1-2 years), Vault (2+ years)
- System Types: Financial, Lab, Ancillary, EHR, etc.
- Access Types: Web, Longview, API
- Output in `system_details_enhanced.csv` and related summary files

## Enhanced Requirements Overview

The project now includes expanded requirements from UCSF that have been adopted for all clients:

### System Information Enhancements
- **Status Classification:** Tracking if systems are Active, Static, or Vault
- **Access Type Categorization:** Web, Longview, API access methods
- **System Type Classification:** Financial, Lab, Ancillary, EHR, etc.
- **Job Number ID Tracking:** For cross-referencing with financial systems

### User Information Enhancements
- **Last Access Tracking:** Timestamps for most recent system access by each user
- **Systems Accessed Details:** Complete list of systems accessed by each user
- **Per-System Last Access:** Tracking last access for each user-system combination

These requirements have been implemented and tested, with comprehensive documentation available.

## Report Generation Challenges

We've identified two parallel report generation approaches:

1. **Matplotlib-based Approach**
   - Uses Python libraries (matplotlib, seaborn) for visualization
   - Creates detailed, interactive charts
   - Requires these libraries to be installed
   - The original and enhanced templates use this approach

2. **HTML/CSS-based Approach**
   - Uses pure HTML and CSS for visualization
   - Creates responsive, lightweight reports
   - No external library dependencies
   - The UCSF_Improved_Report_20250429.html uses this approach

The integration of these approaches is outlined in the REPORT_TEMPLATE_INTEGRATION_GUIDE.md.

## Agent Guidance

### For Manager Role
Focus on feature prioritization based on lessons learned from previous dashboards. Establish clear milestones for incremental delivery. For the enhanced requirements, start with the consolidated implementation plan at `docs/ENHANCED_REQUIREMENTS_IMPLEMENTATION_PLAN.md` which covers both unmapped datasets and UCSF's requirements.

### For Frontend Developer Role
Review previous dashboard components for reusable patterns. Create a consistent component library with proper TypeScript typing. Develop new visualizations for system status, data profiles, and unmapped datasets following the implementation plan.

### For Backend Developer Role
Design GraphQL schema with efficient resolvers. Ensure proper data isolation between tenants. Implement the enhanced analysis scripts following the implementation plan, focusing on the new system_details and user_classifications extensions.

### For Database Specialist Role
Implement schema design with proper indexing for dashboard queries. Create data access patterns that support both direct and API-based access. Validate the SQL query approaches outlined in the implementation plan, particularly for patient counts and disease state metrics.

### For Data Scientist Role
Focus on developing meaningful data profile metrics from patient data. Create algorithms to identify top disease states and follow-on opportunities. Build statistical models to predict system usage patterns based on historical data.

## Common Commands

Common operations for this project:

```bash
# Generate reports for all clients
cd /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_20250415/data/outputs/
./generate_all_reports.sh

# Run analysis for a specific client (e.g., UCSF)
cd /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_20250415/scripts/
./run_all_analyses.sh --client UCSF

# Run updated analysis with new features for a specific client
cd /mnt/c/Users/b/OneDrive\ -\ LEGACY\ DATA\ ACCESS/Tech/dashboard_20250415/scripts/
./run_all_analyses_updated.sh --client UCSF

# Run unmapped datasets analysis for a specific client
python3 ./analysis/unmapped_datasets_analysis.py --client UCSF --output-dir ../data/outputs/UCSF/latest

# Run unmapped projects analysis for a specific client
python3 ./analysis/unmapped_projects_analysis.py --client UCSF --output-dir ../data/outputs/UCSF/latest

# Run enhanced system details analysis for a specific client
python3 ./analysis/data_profile_analysis.py --client UCSF --input-file ../data/outputs/UCSF/latest/system_details.csv --output-dir ../data/outputs/UCSF/latest

# Generate HTML-only improved report
cp /path/to/template.html ../data/outputs/UCSF/UCSF_Improved_Report_$(date +%Y%m%d).html

# Run test mode for validation without database connection
python3 ./analysis/unmapped_datasets_analysis.py --client UCSF --test
```

## Issues and Decisions

**Open Issues:**
- Report template integration needs to be completed
- GraphQL schema design pending finalization
- Component library structure under review
- Need to determine best approach for clinical data access for disease state metrics

**Recent Decisions:**
- Created comprehensive documentation of enhanced features - April 29, 2025
- Developed integration guide for reconciling new and original templates - April 29, 2025
- Implemented and validated unmapped datasets and projects analysis - April 29, 2025
- Implemented enhanced system information tracking - April 29, 2025
- Adopted UCSF's enhanced system and user requirements for all clients - April 28, 2025
- Combined implementation plans for unmapped datasets and enhanced requirements - April 28, 2025
- Added unmapped datasets feature to identify datasets with logging activity not mapped to projects - April 27, 2025
- Consolidated previous dashboard approaches - April 15, 2025 - Taking best practices from Dashboard_first, Dashboard_OCI, and Dashboard_apache
- Standardized on TypeScript - April 15, 2025 - Better type safety and developer experience