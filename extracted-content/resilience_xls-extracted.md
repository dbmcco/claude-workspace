# Extracted Content from resilience_xls

**Original Path:** /Users/braydon/projects/work/resilience/resilience_xls
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This project is for developing a comprehensive Excel financial model for Resilience Creative, a film/TV production company specializing in climate impact content. The model tracks money flows between parent company and productions, generates professional financial statements for investors, foundations, and banks.

## Current Status & Issues (as of model diagnosis)

### Issues Identified:

1. **Corporate Expenses - Lack of Detail**
   - Only 4 basic line items (overhead, development, interest, depreciation)
   - Missing breakdown: executive salaries, office rent, legal fees, insurance, technology, marketing
   - $3.8M corporate overhead needs itemization

2. **Production Budget - Incomplete Implementation**
   - Only Development phase implemented
   - Missing: Pre-production, Production, Post-production, Distribution phases
   - Budget formula references non-existent cells: `=C8+C17+C26+C35+C44`
   - No residuals calculations

3. **Investor Returns - Hardcoded Values**
   - Cash flows hardcoded instead of formula-driven
   - Not linked to actual production performance
   - Exit value not based on revenue/EBITDA multiples

4. **Impact Metrics - Placeholder Only**
   - Just hardcoded Climate Impact Score = 8.5
   - Missing: audience reach, carbon footprint, educational impact, social metrics

5. **Financial Statements - Fundamental Issues**
   - P&L: Revenue/cost timing mismatch, missing intercompany eliminations
   - Balance Sheet: Wrong initial cash formula, missing assets/equity tracking
   - Cash Flow: Missing working capital changes, investing activities

### Required Fixes:

1. **Parent Company P&L**
   - Break out corporate overhead into detailed line items
   - Add executive compensation, facilities, professional services
   - Fix revenue recognition timing

2. **Production Models**
   - Implement all production phases (pre-prod through distribution)
   - Add residuals calculations over 5 years
   - Fix budget total formulas to reference correct cells

3. **Investor Returns**
   - Link cash flows to consolidated net income
   - Calculate distributions based on ownership %
   - Add formula-driven exit valuation

4. **Balance Sheet & Cash Flow**
   - Start with $5M initial equity correctly
   - Add content library as asset
   - Implement proper cash flow categories
   - Fix intercompany eliminations

5. **Impact Metrics**
   - Build out comprehensive impact measurements
   - Link to production audience data
   - Add climate scoring methodology

## Model Architecture
The Excel workbook should contain:
- Dashboard/Summary
- Key Assumptions & Parameters
- Parent Company Financials (P&L, BS, CF)
- Individual Production Models:
  - Blackout (4-part miniseries)
  - Planet Versus (documentary series)
  - EIS (8-part drama series)
- Consolidated Financials
- Investor Returns Analysis
- Impact Metrics

## Key Financial Components

### Intercompany Transactions
- Management fees: 15% from productions to parent
- Backend revenue share: 10% from productions to parent
- Equity investments and loans from parent to productions
- Proper elimination entries in consolidation

### Production Model Requirements
- Detailed budgets by phase (development through distribution)
- Revenue streams (brand partnerships, distribution, tax credits)
- 5-year projections with quarterly detail for years 1-2
- Content asset amortization (straight-line over 5 years)
- ROI, breakeven, and KPI calculations
- Residuals tracking (SAG, WGA, DGA, music rights)

### Investment Analysis
- Formula-driven cash flows (not hardcoded)
- IRR, multiple, and payback period calculations
- Waterfall distributions for different investor classes
- Exit valuation based on revenue multiples

## Technical Implementation Guidelines

### Formula Structure
- All calculations must be formula-driven (no hardcoded values)
- Clear cell references between sheets
- Proper error handling
- Input cells clearly separated from calculation cells

### Color Coding Convention
- Blue cells: User inputs
- Black cells: Calculations
- Green cells: Output/results
- Red cells: Flags/warnings

### Visual Design
- Conditional formatting for key metrics
- Data validation for input cells
- Charts and visualizations for dashboard
- Navigation links between sheets

## Key Metrics to Track
- Consolidated P&L, Balance Sheet, Cash Flow
- Portfolio library value
- Production-level ROI and breakeven
- Cash burn rate and runway
- Impact metrics for climate content
- Investor returns (IRR, multiple)