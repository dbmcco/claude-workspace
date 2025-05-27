# Quality Gate Criteria

## Code Quality Gates

### Linting Gate
- **Python**: Black, isort, flake8 must pass with zero errors
- **JavaScript**: ESLint must pass with zero errors
- **TypeScript**: tsc --noEmit must pass

### Testing Gate
- All unit tests must pass
- Code coverage must be ≥80% (≥95% for critical paths)
- No skipped tests without documented reason
- Integration tests must pass

### Security Gate
- Bandit (Python) scan must pass
- No hardcoded credentials or secrets
- Dependencies must pass security audit
- Input validation present on all endpoints

### Performance Gate
- Response times under defined thresholds
- Memory usage within limits
- No N+1 query problems
- Efficient algorithm complexity

## Documentation Gates

### Code Documentation
- All public functions have docstrings
- Complex logic has inline comments
- README updated for new features
- API changes documented

### Architecture Documentation
- Design decisions recorded
- Integration points documented
- Deployment requirements updated
- Migration guides for breaking changes

## Compliance Gates

### License Compliance
- All dependencies have compatible licenses
- License headers in source files
- NOTICE file updated
- No GPL dependencies in proprietary code

### Standards Compliance
- PEP 8 for Python code
- Airbnb style guide for JavaScript
- Accessibility standards (WCAG 2.1)
- API follows REST/GraphQL standards

## Automated Gate Execution

```python
# Run all gates
python scripts/quality_gates.py --gates all

# Run specific gates
python scripts/quality_gates.py --gates linting,testing,security

# Run with strict mode (fails on warnings)
python scripts/quality_gates.py --gates all --strict
```

## Gate Configuration

Located in `config/quality_gates.yaml`:
```yaml
gates:
  linting:
    enabled: true
    blocking: true
    tools:
      - black
      - isort
      - flake8
  
  testing:
    enabled: true
    blocking: true
    coverage_threshold: 80
    critical_coverage_threshold: 95
  
  security:
    enabled: true
    blocking: true
    tools:
      - bandit
      - safety
      - semgrep
```

## Human Checkpoint Gates

These gates require Bray.Doc's approval:

1. **Architecture Changes**: Major design decisions
2. **External Dependencies**: New third-party services
3. **API Breaking Changes**: Backward compatibility breaks
4. **Security Exceptions**: Bypassing security rules
5. **Performance Trade-offs**: Accepting slower performance

## Gate Failure Handling

When a gate fails:
1. Stop current work immediately
2. Fix the issue causing the failure
3. Re-run the gate to verify fix
4. Document any exceptions with justification
5. Get approval for exceptions from Bray.Doc

## Continuous Monitoring

Gates are monitored continuously:
- Pre-commit hooks catch issues early
- CI/CD pipeline enforces all gates
- Regular scheduled scans for security
- Performance regression tests daily