# Test-Driven Development Workflow

## Testing Philosophy
- TDD is mandatory - write tests first
- Comprehensive test coverage is required
- Test behavior, not implementation
- Each test should test one thing
- Tests should be independent and repeatable

## Quality Gates
- **Pre-commit hooks MUST pass**: black, flake8, mypy, pytest
- **Test coverage >80%** required
- **Feature branches** for all work
- **Type hints** on all functions
- **Docstrings** for all public functions/classes
- Ensure all tests pass and linting is clean before proceeding

## TodoWrite Usage
- **ALWAYS** use TodoWrite tool to track tasks throughout development
- Update task status in real-time: pending → in_progress → completed
- Only ONE task should be in_progress at a time
- Create detailed subtasks for complex features

## Quality Enforcement
- Run linters before every commit
- Fix all linting errors before proceeding
- Maintain high test coverage standards
- Use quality gates to prevent regression