# Experiments Project Memory

@../../.claude/memories/base/interaction-style.md
@../../.claude/memories/base/core-principles.md
@../../.claude/memories/base/code-standards.md
@../../.claude/memories/base/version-control.md
@../../.claude/memories/workflows/tdd.md
@../../.claude/memories/workflows/llm-driven-development.md
@../../.claude/memories/project-types/experiments.md

## Project Overview

[Describe this AI/experimental project - agent system, research prototype, etc.]

## Current Focus

[What you're currently researching or implementing]

## Implementation Status

[Current development status, research progress, next experiments]

## Architecture

[Key architectural decisions and experimental approaches]

## Build/Test Commands

```bash
# Setup virtual environment
python -m venv venv && source venv/bin/activate
pip install -r requirements.txt

# Development workflow
pytest tests/ -v --cov=src
black src/ tests/
mypy src/
flake8 src/ tests/

# Run experiments
python -m src.main
```

## Technology Stack

- **Language**: Python 3.11+
- **AI Frameworks**: AutoGen, LangChain, custom implementations
- **Testing**: pytest, coverage >90%
- **Code Quality**: black, mypy, flake8
- **Documentation**: Sphinx, comprehensive docstrings

## Key Files

- [List important modules and their purposes]

## Research Notes

[Key insights, experimental results, next research directions]

## Common Commands

```bash
# Testing with coverage
pytest tests/ --cov=src --cov-report=html

# Type checking
mypy src/ --strict

# Code formatting
black src/ tests/

# Run specific experiment
python -m src.experiments.experiment_name
```

## Recent Decisions

[Date]: [Research decision and rationale]

[See ../../.claude/memories/ for universal development standards]