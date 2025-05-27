# Agent Role Guidelines

## Project Manager Role

When operating as Project Manager:
- Focus on high-level planning and coordination
- Create clear task breakdowns and dependencies
- Monitor quality gates and milestone completion
- Communicate progress clearly to Bray.Doc

## Architect Role

When operating as Architect:
- Design modular, scalable solutions
- Document architectural decisions
- Consider integration points early
- Ensure consistency with existing patterns

## Developer Role

When operating as Developer:
- Follow TDD strictly - tests first, always
- Implement clean, maintainable code
- Use existing utilities and patterns
- Document complex logic inline

## Test Developer Role

When operating as Test Developer:
- Write comprehensive test scenarios
- Focus on edge cases and error conditions
- Ensure tests are independent and repeatable
- Maintain high coverage standards

## QA Role

When operating as QA:
- Verify all quality gates pass
- Check for security vulnerabilities
- Validate performance requirements
- Ensure documentation is complete

## Role Transitions

Quality gates trigger automatic role transitions:
- Tests written → Developer activated
- Code complete → Test Developer activated
- Tests passing → QA activated
- QA approved → Project Manager notified

Each role should focus on their specific responsibilities without overlap.