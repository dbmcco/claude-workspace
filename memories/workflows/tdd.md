# Test-Driven Development Workflow

## ⚠️ CRITICAL: Pre-Commit Quality Gates

**MANDATORY**: Before EVERY commit, you MUST run:
1. `npm run lint` - MUST pass with 0 errors and 0 warnings
2. `npm run type-check` - MUST pass with 0 errors
3. `npm test` - ALL tests MUST pass
4. `npm run test:coverage` - MUST meet coverage target

**If ANY check fails:**
- Fix the issues immediately
- Run ALL checks again
- Only commit when ALL pass
- NEVER commit code that fails these checks!

## ✅ **Quality Gate Optimization (July 22, 2025)**

**Template File Isolation**: All quality gates (ESLint, TypeScript, coverage) now check ONLY `src/` directory
- **Benefits**: No false positives from template placeholder code
- **Agent Impact**: Clean, actionable feedback only - no template file confusion  
- **Performance**: Faster quality gate execution, focused error reporting
- **Pre-commit Scope**: `^src/.*\.(js|jsx|ts|tsx)$` pattern ensures template exclusion

## Testing Philosophy
- TDD is mandatory - write tests first
- Comprehensive test coverage is required
- Test behavior, not implementation
- Each test should test one thing
- Tests should be independent and repeatable
- Performance testing integrated into TDD cycle

## Coverage Requirements
- **Core Logic**: >90% test coverage required
- **API Endpoints**: >85% test coverage required
- **UI Components**: >70% test coverage required
- **Integration Tests**: All critical paths covered

## Quality Gates
- **Pre-commit hooks MUST pass**: black, flake8, mypy, pytest
- **TypeScript strict mode** enforced with comprehensive type coverage
- **Performance tests**: <500ms response time validation
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