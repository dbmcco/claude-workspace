# Extracted Content from home_fin_analysis

**Original Path:** /Users/braydon/projects/personal/home_fin_analysis
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Purpose
This project creates Excel-based financial analysis tools for retirement planning. The primary deliverable is an .xlsx file with comprehensive retirement calculations including:
- Asset projections
- Social Security analysis
- Income replacement calculations
- Scenario modeling

## Excel Spreadsheet Generation
When creating Excel files based on fin_analysis_prompt.md:
- Use a Python script with openpyxl library
- Implement all formulas exactly as specified
- Apply appropriate formatting (currency, percentage, colors)
- Ensure all sheets are properly linked with VLOOKUP and references

## Development Commands
```bash
# Install dependencies
pip install openpyxl pandas numpy

# Run the Excel generation script
python generate_retirement_excel.py

# Test the generated Excel file
python test_excel_formulas.py
```

## Code Architecture
The project should be structured as:
- `generate_retirement_excel.py` - Main script to create the Excel file
- `excel_formatters.py` - Formatting utilities for cells and ranges
- `formula_builders.py` - Helper functions for complex Excel formulas
- `test_excel_formulas.py` - Tests to validate Excel calculations

## Key Technical Considerations
- Excel formulas must be compatible with all Excel versions from 2013+
- Use named ranges where appropriate for maintainability
- Implement data validation for input cells
- Add conditional formatting for visual clarity
- Ensure calculation order is correct for interdependent formulas