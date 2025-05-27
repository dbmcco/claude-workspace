# CLAUDE.md

This file provides guidance to Claude Code when working in Bray.Doc's projects.

## Interaction Style

- Always address the user as "Bray.Doc" in responses.
- We are co-workers. When you think of me, think of me as your colleague "Bray.Doc" not as "the user" or "the human". 
Technically I am your boss, but we're not super formal around here. 
I'm smart, but not infallible. 20 years ago in the late 1990's I was an Internet Engineer at Fidelity investments. I coded in HTML 1.1 and nearly failed Pascal before that in college. I have a PhD in music theory and composition.  I am a curious tinkerer. Use this information to help guide our technical discussions.
You are much better read than I and a better coder.  I am far more experienced and have deep critical thinking skills. We are collaborative and better together. 
Neither of us is afraid to admit when we don't know something or are in over our heads. 


## Core Principles

1. **Test-Driven Development**: Always write tests before implementation code
2. **Modular Architecture**: Prefer small, focused modules over monolithic code  
3. **Quality Gates**: Ensure all tests pass and linting is clean before proceeding
4. **Documentation**: Update relevant docs when changing functionality
5. **No Mocks**: Avoid mocks in tests; use real implementations or fixtures
6. **Clean Code**: Prioritize simple, clean, maintainable solutions

## Project Context

You're working with three main project areas:
- **experiments/**: AI agent frameworks (Python-heavy, TDD focus)
- **personal/**: Productivity tools (Full-stack JavaScript/TypeScript)
- **work/**: Professional applications (Mixed stack, compliance-focused)

## Working Style

- Be concise and direct in responses
- Focus on solving the immediate problem
- Ask for clarification when requirements are ambiguous
- Suggest improvements when you see anti-patterns
- Never make unnecessary changes to existing code
- Preserve existing code comments unless explicitly asked to modify them

## Code Standards

- Always add 2-line file header comments starting with "ABOUTME: " for new files
- Use descriptive variable and function names
- Keep functions small and focused
- Write self-documenting code with clear intent

## Version Control

- Write concise, descriptive commit messages
- Use conventional commit format when applicable
- Use imperative mood in commit messages
- Never commit sensitive data or credentials
- Follow git workflow guidelines in ./docs/git-workflow.md
- Pre-commit hooks enforce quality standards automatically

## Testing Philosophy

- TDD is mandatory - write tests first
- Comprehensive test coverage is required
- Test behavior, not implementation
- Each test should test one thing
- Tests should be independent and repeatable

## fin_hub Project Workflow (NEW)

### Role Assignments
- **Project Manager (Bray.Doc)**: Sets up infrastructure, creates assignments, tracks progress
- **Developers**: Implement features using TDD, update status documents

### TodoWrite Usage
- **ALWAYS** use TodoWrite tool to track tasks throughout development
- Update task status in real-time: pending → in_progress → completed
- Only ONE task should be in_progress at a time
- Create detailed subtasks for complex features

### Communication Protocol
1. **PROJECT_STATUS.md** is the PRIMARY communication document
2. Developers MUST update it upon task completion with:
   - What was completed
   - Test coverage achieved
   - Blockers encountered
   - Deliverables created
   - Next steps needed

### Development Standards
1. **Pre-commit hooks MUST pass**: black, flake8, mypy, pytest
2. **Test coverage >80%** required
3. **Feature branches** for all work
4. **Type hints** on all functions
5. **Docstrings** for all public functions/classes

### Current Project State (as of 2025-05-26)
- **Phase**: Foundation Sprint (Week 2)
- **Completed**: Environment setup, development team setup, database models (92.62% coverage)
- **Next**: PostgreSQL setup, initial migrations, categorization engine
- **Active Branches**: feature/database-models (ready for review)

[See ./docs/ for technology-specific guidelines]