# AGENTS.md Template - Beads Integration

Add this to your project's AGENTS.md (or create AGENTS.md if it doesn't exist):

---

## Issue Tracking

This project uses **bd (beads)** for issue tracking.
Run `bd prime` for workflow context, or install hooks (`bd hooks install`) for auto-injection.

**Quick reference:**
- `bd ready` - Find unblocked work
- `bd create "Title" --type task --priority 2` - Create issue
- `bd close <id>` - Complete work
- `bd sync` - Sync with git (run at session end)

For full workflow details: `bd prime`

---

## Installation Notes

### Initialize beads in a project:
```bash
cd /path/to/project
bd init
```

### Optional: Install git hooks for auto-sync:
```bash
bd hooks install
```

### For GitHub Copilot users:
Add the same content to `.github/copilot-instructions.md`

## How It Works

- `bd prime` provides dynamic workflow context (~80 lines)
- `bd hooks install` auto-injects `bd prime` at session start
- AGENTS.md only needs this minimal pointer, not full instructions
- This keeps AGENTS.md lean while `bd prime` provides up-to-date workflow details
