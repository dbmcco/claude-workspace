# AGENTS.md

- Scope: Applies to this directory subtree.
- Precedence: Deeper AGENTS.md overrides higher-level files. System/developer/user prompts take precedence over this file.
- Purpose: Guidance for Codex CLI agents working in this project.
- Practices: Keep edits minimal and scoped; follow repo style; fix root causes; update docs; avoid unrelated changes.
- Validation: Prefer running existing builds/tests; verify only what you change.
- Claude CLI: See `claude-workspace/` for shared standards; keep guidance consistent across tools.

# Codex Workspace Context

@./memories/base/interaction-style.md
@./memories/base/core-principles.md
@./memories/base/code-standards.md
@./memories/base/version-control.md
@./memories/workflows/tdd.md
@./memories/workflows/llm-driven-development.md

## Codex Usage
- Planning: use `update_plan` with one in-progress step; mark completed as you go.
- Preambles: concise, grouped 1–2 sentence preambles before related tool calls.
- Edits: use `apply_patch` for file changes; keep edits minimal and scoped.
- Approvals: sandbox-first; escalate for network/destructive/out-of-scope writes with a one-line justification.
- Testing/formatting: run precise, repo-configured commands for changed code only.

