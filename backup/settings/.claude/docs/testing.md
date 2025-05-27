# Testing Guidelines

## Test-Driven Development (TDD)

Bray.Doc's projects follow strict TDD practices:

1. **Red**: Write a failing test first
2. **Green**: Write minimal code to pass the test
3. **Refactor**: Improve code while keeping tests green

## General Testing Principles

- Each test should test ONE thing
- Tests must be independent (no shared state)
- Tests must be repeatable (same result every time)
- Test behavior, not implementation details
- No mocks unless absolutely necessary (prefer real implementations)

## Test Organization

```
tests/
├── unit/          # Unit tests for individual functions/classes
├── integration/   # Tests for component interactions
├── e2e/          # End-to-end tests
└── fixtures/     # Test data and utilities
```

## Naming Conventions

### Python (pytest)
```python
def test_function_name_should_behavior_when_condition():
    """Test that function behaves correctly under specific condition."""
    pass

def test_calculator_add_should_return_sum_when_given_two_numbers():
    """Test that calculator.add returns correct sum."""
    pass
```

### JavaScript (Jest)
```javascript
describe('ComponentName', () => {
  describe('methodName', () => {
    it('should perform expected behavior when condition is met', () => {
      // test implementation
    });
  });
});
```

## Test Structure

### Arrange-Act-Assert (AAA)
```python
def test_user_creation():
    # Arrange
    user_data = {"name": "Test User", "email": "test@example.com"}
    
    # Act
    user = create_user(user_data)
    
    # Assert
    assert user.name == "Test User"
    assert user.email == "test@example.com"
```

### Given-When-Then (BDD style)
```javascript
it('should calculate total price with tax', () => {
  // Given
  const items = [{ price: 10 }, { price: 20 }];
  const taxRate = 0.1;
  
  // When
  const total = calculateTotal(items, taxRate);
  
  // Then
  expect(total).toBe(33); // 30 + 3 tax
});
```

## Coverage Requirements

- Minimum 80% code coverage
- 100% coverage for critical business logic
- Focus on branch coverage, not just line coverage
- Don't write tests just for coverage numbers

## Testing Anti-Patterns to Avoid

### ❌ Testing Implementation
```python
# Bad - tests internal implementation
def test_sort_uses_quicksort():
    with patch('module.quicksort') as mock_quicksort:
        sort_items([3, 1, 2])
        mock_quicksort.assert_called_once()
```

### ✅ Testing Behavior
```python
# Good - tests behavior
def test_sort_returns_ordered_items():
    result = sort_items([3, 1, 2])
    assert result == [1, 2, 3]
```

### ❌ Dependent Tests
```python
# Bad - tests depend on order
def test_create_user():
    global user_id
    user_id = create_user("test").id

def test_get_user():
    user = get_user(user_id)  # Depends on previous test
```

### ✅ Independent Tests
```python
# Good - each test is independent
def test_create_user():
    user = create_user("test")
    assert user.id is not None

def test_get_user():
    user = create_user("test")
    retrieved = get_user(user.id)
    assert retrieved.name == "test"
```

## Framework-Specific Guidelines

### pytest (Python)
- Use fixtures for common setup
- Parametrize tests for multiple scenarios
- Use pytest.raises for exception testing
- Group related tests in classes when appropriate

### Jest (JavaScript)
- Use beforeEach/afterEach for setup/teardown
- Mock external dependencies sparingly
- Use test.each for parametrized tests
- Snapshot testing for UI components (with care)

## Integration Testing

- Test API endpoints with real database (test DB)
- Use transactions and rollback for data isolation
- Test error scenarios and edge cases
- Verify proper status codes and response formats

## E2E Testing

- Focus on critical user journeys
- Use stable selectors (data-testid)
- Run against dedicated test environment
- Keep E2E tests fast and reliable

## Performance Testing

- Set performance budgets
- Test with realistic data volumes
- Monitor test execution time
- Fail tests that exceed time limits

## Test Data

### Fixtures
- Use meaningful test data
- Create factory functions for complex objects
- Avoid random data unless testing randomness
- Clean up test data after tests

### Example Factory (Python)
```python
def create_test_user(**kwargs):
    """Create a user with test defaults."""
    defaults = {
        "name": "Test User",
        "email": "test@example.com",
        "active": True
    }
    return User(**{**defaults, **kwargs})
```

### Example Factory (JavaScript)
```javascript
function createTestUser(overrides = {}) {
  return {
    name: 'Test User',
    email: 'test@example.com',
    active: true,
    ...overrides
  };
}
```

## Continuous Integration

- All tests must pass before merging
- Run tests on multiple Python/Node versions
- Fail fast on first test failure in CI
- Cache dependencies for faster builds

## Testing Commands

### Python
```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src --cov-report=html

# Run specific test file
pytest tests/test_specific.py

# Run tests matching pattern
pytest -k "test_user"

# Run with verbose output
pytest -v
```

### JavaScript
```bash
# Run all tests
npm test

# Run with coverage
npm test -- --coverage

# Run in watch mode
npm test -- --watch

# Run specific file
npm test -- user.test.js

# Update snapshots
npm test -- -u
```