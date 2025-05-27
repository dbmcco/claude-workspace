# Extracted Content from multi_entity_tracking

**Original Path:** /Users/braydon/projects/personal/home_tiller_enhancements/features/multi_entity_tracking
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Multi-Entity Tracking Feature

## Feature Overview
This file provides guidance to Claude when working with the Multi-Entity Tracking feature. This feature enables tracking and management of financial transactions across multiple entities (Personal, Set Earth S-Corp, Aclara Consulting, and Shared expenses).

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
- Automated Transaction Categorization: For pattern matching capabilities

## Implementation Context

### Current Implementation
The current implementation across several scripts includes:
- Basic entity suggestion in `scripts/vendor_analysis.py`
- Simple entity tracking in `scripts/categorization_with_approval.py`
- Entity pattern identification in `scripts/categorize_vendors.py`

### Migration Path
1. Extract entity-related functionality from existing scripts
2. Create modular components for entity management
3. Develop comprehensive entity identification engine
4. Implement client-specific tracking
5. Build shared expense management
6. Create entity-specific reporting

## Role-Specific Instructions

### For Test Developer
- Create comprehensive test cases for all components
- Test entity assignment with various transaction types
- Test shared expense calculations with multiple scenarios
- Ensure client expense tracking accuracy tests
- Test entity overrides and learning capability

### For Developer
- Implement code to meet test requirements
- Use enum or similar for entity types
- Ensure high accuracy in entity identification
- Implement robust contribution calculation for shared expenses
- Create clean interfaces between entity components

### For Architect
- Design clean interfaces between entity management components
- Ensure proper integration with Data Access Layer
- Plan for scalability to additional entities
- Design for extensibility in client tracking

### For QA
- Verify entity assignment accuracy
- Test shared expense calculations edge cases
- Validate client expense tracking
- Verify cross-entity reporting
- Test manual override functionality

## Technical Requirements

### Component Structure
- `entity_manager.py`: Core entity definition and management
- `entity_identifier.py`: Entity assignment engine
- `client_tracker.py`: Client-specific expense tracking
- `shared_expense.py`: Shared expense management
- `business_tracker.py`: Business expense tracking
- `entity_reporting.py`: Entity-specific reporting

### Key Functions Required
- `identify_entity(transaction) -> entity`
- `track_client_expense(transaction, client) -> client_expense`
- `calculate_shared_contribution(expense, split_percentages) -> contributions`
- `track_business_expense(transaction, entity) -> business_expense`
- `generate_entity_report(entity, date_range) -> report`
- `override_entity(transaction, new_entity, reason) -> updated_transaction`

### Data Structures
- Entity: Enum of Personal, SetEarth, Aclara, Shared
- Transaction: Dict with date, description, amount, account
- ClientExpense: Dict with transaction, client, reimbursable status
- SharedExpense: Dict with transaction, contributors, split percentages
- BusinessExpense: Dict with transaction, business_type, tax_relevance
- EntityReport: Dict with entity, transactions, categories, totals

## Resources and References
- PRD section: [PRD_TILLER_ENHANCEMENTS.md#multi-entity-tracking](/PRD_TILLER_ENHANCEMENTS.md)
- Current implementation: Various scripts in [scripts/](/scripts/)
- Test cases: To be developed in [tests/](/features/multi_entity_tracking/tests/)
- Requirements: [requirements/](/features/multi_entity_tracking/requirements/)