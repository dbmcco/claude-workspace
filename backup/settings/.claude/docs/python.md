# Python Development Guidelines

## Package Management

- Use pip with requirements.txt for simple projects
- Use pyproject.toml for complex projects (e.g., agent_unified)
- Always use virtual environments (venv or virtualenv)
- Pin dependency versions for reproducibility
- Consider using uv for modern Python package management

## Project Structure

```
project/
├── src/           # Source code
├── tests/         # Test files
├── docs/          # Documentation
├── scripts/       # Utility scripts
└── pyproject.toml # or requirements.txt
```

## Code Style

- **Formatter**: Black (line length: 88)
- **Import sorting**: isort
- **Linting**: flake8, pylint for comprehensive checks
- **Type checking**: mypy with strict mode
- **Docstrings**: Google style for all public functions and classes

## Type Hints

- Required for all public functions
- Use from `typing` import for complex types
- Example:
```python
def process_data(items: List[Dict[str, Any]]) -> Optional[str]:
    """Process data items and return result."""
```

## Testing

- **Framework**: pytest exclusively
- **Coverage**: Minimum 80% coverage required
- **Structure**: Mirror source structure in tests/
- **Fixtures**: Use pytest fixtures over test classes
- **Naming**: test_<function_name>_<scenario>

## Common Patterns

### Error Handling
```python
try:
    result = risky_operation()
except SpecificError as e:
    logger.error(f"Operation failed: {e}")
    raise CustomError(f"Failed to process: {e}") from e
```

### Configuration
- Use environment variables via python-dotenv
- Pydantic for configuration validation
- Never hardcode credentials or secrets

### Logging
```python
import logging
logger = logging.getLogger(__name__)
```

## Async Code

- Use asyncio for concurrent operations
- async/await syntax for all async functions
- aiohttp for async HTTP requests
- Consider trio for complex async workflows

## Database Access

- SQLAlchemy for SQL databases
- Pymongo for MongoDB
- Always use connection pooling
- Never construct SQL queries with string formatting

## Agent-Specific (experiments/)

- Use role-specific CLAUDE.md files for agent behavior
- Implement quality gates as decorators
- State management through Pydantic models
- Event-driven coordination patterns