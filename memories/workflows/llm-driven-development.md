# LLM-Driven Development Principles

## MCP Integration
- Use MCPs (Model Context Protocol) wherever possible
- Configure MCPs specifically for each project type
- Leverage MCPs for tool integration and data access

## GitHub-Native TDD Workflow Integration
- **Source of Truth**: GitHub Issues with comprehensive TDD-focused templates
- **Automated Workflow**: Issue creation → Auto-labeling → Branch creation → TDD development
- **AI Trigger Pattern**: `@claude implement this` comment → GitHub Actions → TDD-compliant development
- **State Management**: Automated TDD progression (tdd/ready → tdd/red → tdd/green → tdd/refactor → tdd/complete)
- **Quality Integration**: All AI development must pass >90% coverage and comprehensive quality gates
- **Issue Lifecycle**: GitHub Issues → TDD Development → Quality Gates → PR Review → Auto-close with "Fixes #123"

## Rule-Based Documentation
- Don't write "human" documentation; use rule + reusable prompt files
- Keep rules/prompts very small and granular (ticket-sized)
- Make rules conditionally applied using globs
- Only auto-include "system rules" - everything else conditional

## LLM-Generated Consistency
- Use the LLM to generate prompts and rules
- This forces consistency across prompts (very important)
- Version control all generated prompts and rules

## TDD-Integrated LLM Workflow
- **GitHub-Native Agile**: GitHub Issues → TDD Development → Quality Gates → Merge
- **Automated Decomposition**: Use issue templates to break epics into TDD-compliant tickets
- **AI Development Patterns**: LLM follows RED→GREEN→REFACTOR cycle automatically
- **Quality-First**: Every LLM-generated code must pass comprehensive quality gates
- **State Tracking**: Automated label-based progress tracking through TDD phases

## Multi-Agent Coordination Patterns
- **Parallel Deployment**: Deploy multiple Claude agents simultaneously for complex features
- **Domain Separation**: Assign agents to specific domains (auth, data, UI, testing)
- **Coordination Protocol**: Use GitHub Issues as coordination layer between agents
- **Quality Sync**: All agents must pass same quality gates before integration
- **Context Sharing**: Shared context through GitHub issue comments and PR descriptions

## Modular Context Management
- Keep code VERY modular so LLM can maintain focused context
- Rules should provide all key context (like broader architecture)
- Goal: LLM only needs files related to strict 'current task' scope
- Avoid context pollution with irrelevant information

## Rewrite vs Iteration Strategy
- Iterating on code is harder than writing from scratch
- Provided code is well-architected, no rewrite should be larger than a regular ticket
- If ticket is too large, split it up
- Prefer small, focused rewrites over large refactoring