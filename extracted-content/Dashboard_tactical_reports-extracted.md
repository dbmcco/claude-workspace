# Extracted Content from Dashboard_tactical_reports

**Original Path:** /Users/braydon/projects/work/LDA/dashboard_core/extra_projects/Dashboard_tactical_reports
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Dashboard_tactical_reports - Project Memory

This file serves as Claude's project memory. It provides essential context about the project, current status, and guidance for development.

## Project Overview

**Purpose:** A tactical report generation system that produces client-specific, static HTML usage reports based on log data from the PostgreSQL database and optional financial data from Monday.com.

**Status:** 85% complete - Refinement phase

**Type:** Dashboard/Reporting

## Current Status

**Last Updated:** April 25, 2025

**Recent Accomplishments:**
- Completed financial data integration from Monday.com
- Implemented PDF export functionality for reports
- Added validation framework for data integrity checks

**Current Focus:**
- Enhancing report visualizations with interactive elements
- Implementing PowerBI integration for advanced analytics

**Next Steps:**
- Automate report generation schedule
- Create client-specific branded templates
- Expand test coverage for data validation

## Technical Stack

- **Frontend:** HTML, CSS, JavaScript, Chart.js, Jinja2 Templates
- **Backend:** Python, pandas, Flask
- **Database:** PostgreSQL, Parquet files for intermediate storage
- **Deployment:** Server-based scheduled execution

## Architecture

The system follows an ETL architecture pattern: data is extracted from multiple sources (PostgreSQL database, Monday.com API), transformed using pandas for analysis, and loaded into template-based reports. The application separates data processing logic from presentation templates, allowing for flexible report generation with consistent analysis.

## Key Files

- `generate_dashboard.py` - Main report generation script
- `src/data_loader.py` - Data extraction from multiple sources
- `src/analysis.py` - Data transformation and analysis
- `templates/report_template.html` - HTML report template
- `scripts/validate_schema.py` - Data validation utilities

## Database Strategy

- **Development:** Local Parquet files with sample data
- **Production:** PostgreSQL database accessed via VPN, Monday.com API
- **VPN Requirements:** Yes - Required for accessing production PostgreSQL database

## Project-Specific Challenges

- **VPN Connectivity:** Implements checkpoint-resume pattern for 3m46s VPN timeout
- **Data Validation:** Comprehensive validation of source data before reporting
- **Integration Points:** PostgreSQL database, Monday.com API, PowerBI datasets

## Agent Guidance

### For Manager Role
Focus on report delivery schedules and client-specific requirements. Monitor validation results for data quality issues.

### For Frontend Developer Role
Work on report templates and visualization components. Ensure consistent styling across reports.

### For Backend Developer Role
Maintain data extraction and transformation logic. Optimize performance for larger datasets.

### For Database Specialist Role
Implement efficient queries for data extraction. Ensure proper indexing for reporting queries.

## Common Commands

Common operations for this project:

```bash
# Generate dashboard report
python generate_dashboard.py

# Generate PDF version
./generate_dashboard_pdf.sh

# Run data validation
./scripts/run_validation.sh

# Serve dashboard for preview
python serve_dashboard.py
```

## Issues and Decisions

**Open Issues:**
- PowerBI integration planning in progress
- Some validation checks need refinement for edge cases

**Recent Decisions:**
- Adopted Parquet for intermediate storage - April 12, 2025 - Better performance than CSV for large datasets
- Standardized on Jinja2 templates - April 5, 2025 - More flexible than hardcoded HTML generation