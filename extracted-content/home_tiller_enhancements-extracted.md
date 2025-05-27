# Extracted Content from home_tiller_enhancements

**Original Path:** /Users/braydon/projects/personal/home_tiller_enhancements
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Tiller spreadsheet enhancement project that develops financial analysis and categorization tools for the Tiller Personal Finance spreadsheet. The codebase includes Python scripts for automated transaction categorization, cash flow forecasting, and multi-entity expense tracking.

## Important: Secret Data Locations
All sensitive Excel files containing financial data have been moved to iCloud-synced ProjectSecrets.
See `.secrets.md` for the exact paths to these files. When working with data files, use the full paths listed there.

## Multi-Agent Implementation

This project is being implemented using multiple Claude AI agents with specialized roles:

1. **Project Manager (PM)**: Coordinates tasks, tracks progress, and manages the overall implementation plan.
2. **Test Developer (TD)**: Creates comprehensive test suites following TDD principles.
3. **Developer (DEV)**: Implements code to pass tests and ensures quality standards.
4. **Architect (ARCH)**: Designs system architecture and ensures architectural compliance.
5. **Quality Assurance (QA)**: Manages quality tools and ensures quality standards.

### Current Status (2025-05-23)
- ✅ **Phase 1 Complete**: Project initialization and requirements
- ✅ **Phase 2a Complete**: Testing framework implementation
- ✅ **Architect**: DAL design complete with full documentation
- 🔴 **ACTIVE**: Test Developer creating DAL tests
- 🔴 **ACTIVE**: Developer implementing DAL
- 📋 **PENDING**: Human user testing of enhanced categorization workflow

### Key Coordination Files
- **COORDINATION.md**: Single source of truth for project status, tasks, and decisions.
- **MULTI_AGENT_IMPLEMENTATION_PLAN.md**: Detailed plan for multi-agent implementation.
- **Feature-specific CLAUDE.md files**: Each feature directory contains its own CLAUDE.md file.
- **Assignment files in /coordination/**: Specific task assignments for each agent
- **pm_todo_list.md**: Project Manager's persistent todo list with inter-session context

### Recent Achievements
- Fixed critical categorization bug (4,468 transactions issue)
- Enhanced categorization with smart suggestions and transaction type detection
- Implemented comprehensive testing framework for real Tiller data
- Completed RealCodeQuality framework
- Designed complete Data Access Layer architecture

### Next Steps
1. Complete DAL implementation (Test Developer + Developer)
2. **REMINDER**: Bray.Doc wants to do human user testing - see `/human/user_testing_guide.md`
3. Begin feature migration to new architecture
4. Configure pre-commit hooks with RealCodeQuality

### Task Workflow
1. PM assigns tasks and manages coordination
2. TD creates failing tests (RED phase)
3. DEV implements code to pass tests (GREEN phase)
4. DEV refactors for improved quality (REFACTOR phase)
5. QA ensures quality standards are met
6. ARCH validates architectural compliance
7. PM validates feature completion

## Core Architecture

The project is transitioning to a feature-focused architecture, but currently includes these key components:

1. **TillerAnalyzer** (analyze_tiller_spreadsheet.py): Analyzes the structure of Tiller spreadsheets, including sheets, formulas, charts, and data patterns.

2. **CategorizeWithApproval** (categorization_with_approval.py): Handles transaction categorization with multi-entity tracking (Set Earth S-Corp, Aclara, Shared accounts, Personal).

3. **TillerCashFlowForecaster** (cash_flow_forecast.py): Generates cash flow predictions based on historical transaction patterns and includes inheritance payment scheduling.

4. **Vendor Analysis Tools** (vendor_analysis.py, categorize_vendors.py): Analyzes vendor patterns and generates categorization rules.

5. **Spending Pattern Analyzer** (spending_pattern_analyzer.py): Identifies spending trends, anomalies, and patterns by day-of-week and season.

6. **RealCodeQuality** (real_code_quality/): Comprehensive code quality framework that integrates industry-standard tools (flake8, pylint, black, mypy, coverage) for automated linting, static analysis, formatting, and test coverage analysis.

## RealCodeQuality Framework

The project now includes a comprehensive code quality framework that provides:

### Features
- **Multi-tool Integration**: Flake8, Pylint, Black, MyPy, Coverage.py
- **Language Support**: Python (with JavaScript/TypeScript planned)
- **Multiple Report Formats**: Console, JSON, HTML
- **Automated Fixes**: Black formatting and other auto-fixable issues
- **Quality Gates**: Pre-commit, pre-push, and CI/CD integration
- **Configuration Management**: Flexible, per-tool configuration

### Quality Commands
```bash
# Install quality tools
pip install -r requirements_quality.txt

# Analyze code quality
python -m real_code_quality.cli analyze
python -m real_code_quality.cli analyze --files script1.py script2.py
python -m real_code_quality.cli analyze --format json --output report.json

# Auto-fix issues  
python -m real_code_quality.cli fix --auto

# Generate configuration
python -m real_code_quality.cli config --generate

# Check tool availability
python -m real_code_quality.cli info

# Run demonstration
python demo_quality.py
```

### Quality Configuration
- Configuration file: `.quality-config.json`
- Supports per-tool thresholds and options
- Language-aware analysis selection
- Flexible exclude patterns

## Common Commands

### Install dependencies
```bash
pip install -r requirements.txt
```

### Run analysis scripts
```bash
# Analyze spreadsheet structure
python scripts/analyze_tiller_spreadsheet.py

# Run categorization with approval workflow
python scripts/categorization_with_approval.py <path_to_tiller_file>

# Generate cash flow forecast
python scripts/cash_flow_forecast.py <path_to_tiller_file>

# Analyze vendor patterns
python scripts/vendor_analysis.py

# Run test categories
python scripts/test_categories.py

# Check data structure
python scripts/check_data_structure.py

# Analyze spending patterns
python enhancements/spending_pattern_analyzer.py <path_to_tiller_file>
```

### Command Options

Most scripts support these common flags:
- `--help`: Show help information
- `--debug`: Enable debug output
- `--output FILE`: Save output to file
- `--limit N`: Process only N recent transactions
- `--plot`: Generate visual charts
- `--report`: Generate detailed reports

### Client-specific options
```bash
# Client-specific categorization
python scripts/categorization_with_approval.py <path_to_tiller_file> --client Anthropic

# Tax reconciliation
python scripts/categorization_with_approval.py <path_to_tiller_file> --tax-reconcile

# Entity-specific analysis
python scripts/vendor_analysis.py --entity "Set Earth"
```

## Environment Setup

```bash
# Set the path to your Tiller file
export TILLER_FILE="/path/to/Tiller_Personal.xlsx"

# Enable debugging (optional)
export DEBUG=true
```

## Key Entities Tracked
- Set Earth (S-Corp)
- Aclara (Consulting)
- Shared accounts (6152)
- Personal transactions

## Configuration
- Categorization rules are defined in `config/categorization_rules_template.json`
- The project uses AutoCat integration for automatic transaction categorization within Tiller

## Output Files
- Analysis results go to `/analysis/`
- Categorization outputs go to `/categorization/` and `/output/`
- Excel files are generated for categorized transactions, client expenses, and entity summaries

## Implementation Notes

### Transaction Categorization
The three-stage categorization process includes:
1. Automated categorization with confidence scoring
2. Interactive human review with bulk operations
3. Learning system to improve future categorizations

### Cash Flow Forecasting
The forecasting includes:
- Historical pattern analysis
- Inheritance payment scheduling
- Seasonal trend detection
- Multi-entity cash projection

### Multi-Entity Management
Entity-specific tracking includes:
- Shared account contribution tracking
- S-Corp distribution management
- Tax payment reconciliation
- Business expense reimbursements

## Quality Standards
- Test-Driven Development (TDD) approach for all features
- Minimum 80% test coverage for all code
- All functions must have type annotations
- All modules must have documentation
- Code must pass linting with flake8 and formatting with black
- All public APIs must have examples

## Best Practices
1. Always backup the Tiller file before processing
2. Run categorization weekly for best results
3. Review and approve categorizations before bulk applying
4. Use `--debug` flag to troubleshoot issues
5. Check `output/` directory for results
6. Always update COORDINATION.md when starting or completing work
7. Follow TDD principles - tests first, then implementation
8. When working as an agent, focus on your assigned role and tasks
9. **REMINDER**: Human user testing is ready - enhanced categorization workflow is production-ready for testing