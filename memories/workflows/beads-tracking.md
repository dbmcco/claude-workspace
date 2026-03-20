# Beads Integration

When working in repositories with beads initialized (`.beads/` directory), use `bd` commands for task tracking. The `bd prime` context is auto-injected via hooks at session start.

## When to Use What

| Scenario | Tool |
|----------|------|
| Repo has `.beads/` | Use `bd` commands (context auto-injected) |
| Repo lacks `.beads/` | Use TodoWrite |
| Quick in-conversation tracking | TodoWrite (ephemeral) |
| Multi-session/dependency tracking | Beads (git-backed, persistent) |

## Quick Reference

If hooks didn't fire or after compaction:
```bash
bd prime    # Re-inject workflow context
bd ready    # See unblocked work
```

## Initialize Beads in New Projects

```bash
bd init              # Creates .beads/ directory
bd setup claude      # Install hooks (already global)
```

Consider beads for projects with complex multi-step features, dependency relationships, or need for persistent cross-session task memory.
