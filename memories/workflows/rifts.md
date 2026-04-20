# Speedrift — Default Workflow for All Repos

**ALWAYS bootstrap Workgraph + Driftdriver in every repo.** This is the standard development workflow. Use `/speedrift` (or `/rifts`) to trigger it.

Terminology:
- **Workgraph** (`wg`) is the task graph spine (dependencies, agent spawning, coordinator, messaging).
- **Driftdriver** is the drift-check orchestrator (routes to coredrift, specdrift, uxdrift, etc.).
- **Speedrift** / **Rifts** is the per-repo workflow entrypoint.

## Bootstrap (Every Repo, Every Session)

Run these steps at session start. They are all idempotent:

1. `wg init` — create `.workgraph/` if missing
2. `/Users/braydon/projects/experiments/driftdriver/bin/driftdriver install` — install wrappers + executor guidance
3. `./.workgraph/speedrift ensure-contracts --apply` — ensure open tasks have `wg-contract` blocks
4. `wg service start` — start the daemon (coordinator + auto-dispatch)

Optional lanes (add to install when needed):
- `--with-uxdrift` — UI/UX drift checking
- `--with-therapydrift` — self-healing cycle for persistent drift
- `--with-yagnidrift` — YAGNI/over-engineering detection
- `--with-redrift` — rebuild/migration artifact discipline

## Working with Workgraph from Claude Code

All `wg` commands work from Claude Code via Bash. Key patterns:

**Goal decomposition** — talk to the coordinator:
```bash
wg chat "Decompose this goal into tasks: <goal description>"
```

**Monitoring** — check status without leaving Claude Code:
```bash
wg status          # overview: agents, tasks, service
wg velocity        # completion rate trends
wg analyze         # full health report
wg discover        # recently completed tasks + artifacts
```

**Inter-agent messaging:**
```bash
wg msg send <task-id> "context or question"
wg msg list <task-id>
```

**Peer federation** — cross-repo visibility:
```bash
wg peer list       # registered peers
wg peer status     # health check all peers
```

**The TUI (`wg tui`) requires a real terminal** — run it in a separate tmux pane for visual monitoring. Everything the TUI shows is available via CLI commands above.

## Per-Task Protocol

At task start and just before completion:

```bash
./.workgraph/drifts check --task <id> --write-log --create-followups
```

- **Drift is advisory** — never block the main task.
- If drift shows up, prefer contract edits and follow-up tasks (keep the current task scoped).
- If `hardening_in_core`, avoid adding fallbacks/guardrails in the core task; complete the `harden:` follow-up instead.

## Lane Selection

Driftdriver auto-selects which drift tools run based on fenced blocks in task descriptions:
- `coredrift` always runs (scope/contract checking)
- `` ```specdrift `` / `` ```uxdrift `` / `` ```datadrift `` / etc. — optional lanes triggered by fences
- Complex/rebuild tasks auto-escalate to full suite
