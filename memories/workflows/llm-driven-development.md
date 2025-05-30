# LLM-Driven Development Principles

## MCP Integration
- Use MCPs (Model Context Protocol) wherever possible
- Configure MCPs specifically for each project type
- Leverage MCPs for tool integration and data access

## Rule-Based Documentation
- Don't write "human" documentation; use rule + reusable prompt files
- Keep rules/prompts very small and granular (ticket-sized)
- Make rules conditionally applied using globs
- Only auto-include "system rules" - everything else conditional

## LLM-Generated Consistency
- Use the LLM to generate prompts and rules
- This forces consistency across prompts (very important)
- Version control all generated prompts and rules

## Agile LLM Workflow
- Follow typical agile workflow: epics → tickets → backlogs
- Break work into ticket-sized chunks
- Use LLM to help decompose epics into implementable tickets

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