# Extracted Content from cash_flow_forecasting

**Original Path:** /Users/braydon/projects/personal/home_tiller_enhancements/features/cash_flow_forecasting
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Cash Flow Forecasting Feature

## Feature Overview
This file provides guidance to Claude when working with the Cash Flow Forecasting feature. This feature generates cash flow projections based on historical Tiller transaction data, incorporating inheritance payment schedules and providing cash crunch detection.

## Development Guidelines

### Test-Driven Development (TDD)
- Follow strict TDD approach: tests first, then implementation
- Red-Green-Refactor cycle:
  1. Write failing tests (RED)
  2. Implement minimal code to pass tests (GREEN)
  3. Refactor for quality and maintainability (REFACTOR)
- Test coverage target: 90%

### Code Quality Standards
- Type annotations for all functions
- Comprehensive docstrings
- Modular design with single responsibility
- Error handling and validation
- Performance considerations for large datasets

### Dependencies
- lib/data_access: Use for all data access operations
- lib/analysis_engines: Use for analytical functions
- lib/report_generation: Use for report creation
- Multi-Entity Tracking: For entity-specific forecasts

## Implementation Context

### Current Implementation
The current implementation in `scripts/cash_flow_forecast.py` includes:
- Basic historical pattern analysis
- Recurring transaction identification
- Monthly cash flow projection
- Inheritance payment scheduling
- Cash crunch detection
- Simple visualization and reporting

### Migration Path
1. Extract core functionality into modular components
2. Create test suite for each component
3. Enhance with scenario planning capabilities
4. Improve visualization and reporting
5. Add multi-entity support
6. Optimize performance for large datasets

## Role-Specific Instructions

### For Test Developer
- Create comprehensive test cases with mock historical data
- Test various scenarios including edge cases
- Ensure tests for inheritance scheduling
- Test cash crunch detection with various thresholds
- Create performance tests for large datasets

### For Developer
- Implement code to meet test requirements
- Use statistical techniques for pattern recognition
- Ensure visualization components are configurable
- Optimize calculation performance
- Document all configuration parameters

### For Architect
- Design clean interfaces between components
- Ensure proper integration with Data Access Layer
- Plan for scenario management data structures
- Design modular visualization framework

### For QA
- Verify forecast accuracy against manual calculations
- Test with various historical data patterns
- Validate cash crunch detection
- Verify visualization quality
- Test performance with large datasets

## Technical Requirements

### Component Structure
- `transaction_analyzer.py`: Historical pattern analysis
- `recurring_identifier.py`: Recurring transaction detection
- `cash_flow_projector.py`: Core projection engine
- `inheritance_manager.py`: Inheritance payment tracking
- `cash_crunch_detector.py`: Cash crunch identification
- `scenario_planner.py`: Scenario planning tools
- `forecast_visualizer.py`: Visualization capabilities

### Key Functions Required
- `analyze_historical_patterns(transactions) -> patterns`
- `identify_recurring_transactions(transactions) -> recurring`
- `forecast_cash_flow(patterns, inheritance, months_ahead) -> forecast`
- `identify_cash_crunches(forecast, min_balance) -> warnings`
- `create_scenario(base_forecast, adjustments) -> scenario`
- `create_visualizations(forecast) -> charts`
- `export_forecast(forecast, format) -> report`

### Data Structures
- Transaction: Dict with date, description, amount, category
- RecurringTransaction: Dict with amount, frequency, confidence
- ForecastPeriod: Dict with income, expenses, inheritance, net flow
- Forecast: DataFrame of ForecastPeriods with cumulative balance
- Scenario: Named forecast with parameter adjustments
- CashCrunch: Dict with date, projected balance, shortfall
- Inheritance: Dict with date, amount

## Resources and References
- PRD section: [PRD_TILLER_ENHANCEMENTS.md#cash-flow-forecasting](/PRD_TILLER_ENHANCEMENTS.md)
- Current implementation: [scripts/cash_flow_forecast.py](/scripts/cash_flow_forecast.py)
- Test cases: To be developed in [tests/](/features/cash_flow_forecasting/tests/)
- Requirements: [requirements/](/features/cash_flow_forecasting/requirements/)