# Extracted Content from automated_categorization

**Original Path:** /Users/braydon/projects/personal/home_tiller_enhancements/features/automated_categorization
**Extraction Date:** Tue May 27 09:40:51 EDT 2025

---

# Automated Transaction Categorization Feature

## Feature Overview
This file provides guidance to Claude when working with the Automated Transaction Categorization feature. This feature enables automatic categorization of financial transactions from Tiller with multi-entity tracking, approval workflow, and machine learning.

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

## Implementation Context

### Current Implementation
The current implementation in `scripts/categorization_with_approval.py` includes:
- Basic pattern-based categorization
- Simple entity tracking
- Interactive approval workflow
- Rudimentary learning mechanism
- Report generation

### Migration Path
1. Extract core functionality into modular components
2. Create test suite for each component
3. Enhance with machine learning capabilities
4. Improve approval workflow
5. Refine entity tracking
6. Optimize performance for large datasets

## Role-Specific Instructions

### For Test Developer
- Create comprehensive test cases for all components
- Use mocking for external dependencies
- Test both happy paths and edge cases
- Ensure tests are isolated and reproducible
- Add performance tests for large datasets

### For Developer
- Implement code to meet test requirements
- Follow modular design patterns
- Ensure backward compatibility with existing data
- Optimize for readability and maintainability
- Document all public APIs

### For Architect
- Ensure component interfaces are well-defined
- Verify architectural alignment with overall system
- Validate dependency management
- Review for scalability and extensibility

### For QA
- Verify code quality standards
- Ensure comprehensive test coverage
- Validate error handling and edge cases
- Verify performance with large datasets
- Confirm usability of approval workflow

## Technical Requirements

### Component Structure
- `categorizer.py`: Core categorization engine
- `approval_workflow.py`: Interactive approval system
- `entity_tracker.py`: Multi-entity management
- `ml_classifier.py`: Machine learning component
- `rule_generator.py`: Rule creation and management
- `report_generator.py`: Categorization reports

### Key Functions Required
- `categorize_transaction(transaction) -> categorization`
- `calculate_confidence(transaction, categorization) -> float`
- `identify_entity(transaction) -> entity`
- `queue_for_approval(transaction, categorization) -> approval_item`
- `learn_from_approval(approval_decision) -> rule`
- `generate_autocat_rules(approved_categorizations) -> rules`

### Data Structures
- Transaction: Dict with date, description, amount, account
- Categorization: Dict with category, entity, client, confidence
- Rule: Dict with patterns, result, confidence_boost
- Entity: Enum of Personal, SetEarth, Aclara, Shared
- ApprovalItem: Dict with transaction, categorization, status

## Resources and References
- PRD section: [PRD_TILLER_ENHANCEMENTS.md#automated-transaction-categorization](/PRD_TILLER_ENHANCEMENTS.md)
- Current implementation: [scripts/categorization_with_approval.py](/scripts/categorization_with_approval.py)
- Test cases: To be developed in [tests/](/features/automated_categorization/tests/)
- Requirements: [requirements/](/features/automated_categorization/requirements/)