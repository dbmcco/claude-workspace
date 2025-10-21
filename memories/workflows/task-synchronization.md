# Task Synchronization Workflow

**Note**: This workflow has been migrated to a skill. Use the `syncing-task-completions` skill for systematic sync operations. This file remains as reference documentation.

## Systematic Task Sync Prevention

### Problem Statement
Tasks marked complete in daily notes (✅ with dates) don't automatically sync to master task lists, creating confusion about project progress and completion status.

### Solution Architecture
**Specialist Agents**: Two focused sub-agents handle systematic synchronization
- **@sync-scanner**: Finds completed tasks needing sync to master lists
- **@sync-updater**: Updates master lists with completion markers and dates

### Integration Points

#### 1. Claude Workspace Integration
Task synchronization system embedded in `claude-workspace/` for project-wide availability across all sessions.

#### 2. Hook-Based Reminders  
Sync reminder hook (`settings/hooks/sync-reminder.json`) triggers when:
- Completion patterns detected: "✅ 2025-", "marked complete", "finished.*[project]"
- Weekly review activities: "Sunday evening", "weekly review"
- Completion threshold reached: 3+ tasks completed without sync

#### 3. Agent Coordination Pattern
```bash
# Weekly sync (Sunday evenings)
Task("@sync-scanner find all completed tasks from this week that need syncing to master lists")
# Wait for scanner report
Task("@sync-updater apply all sync requirements from scanner report")
```

#### 4. Emergency Sync Recovery
```bash  
# When drift discovered
Task("@sync-scanner find all completed tasks from past [timeframe] needing sync")
Task("@sync-updater update all master lists with missing completions")
```

### Monitored Master Lists
- `LFW/Light Forge Works Tasks.md` - Business development and operations
- `Areas/Companies/Navicyte - UD/Navicyte Master Command Center.md` - Startup mentoring
- `Areas/Family/Diana/Diana Estate Master Tasks.md` - Estate administration  
- `Areas/Companies/Aclara sale/Aclara Master Task List.md` - Business transition
- `Areas/Home/Home Admin Master Tasks.md` - Personal administration
- `Areas/Companies/Synthyra/Synthyra Master Command Center.md` - Partnership development

### Quality Standards

#### @sync-scanner Output Format
```markdown
## Sync Requirements Report

### [Master List Name] (from path/to/master.md)
- [x] **P1** Task description ✅ 2025-08-07  
- [x] **P2** Another completed task ✅ 2025-08-06
```

#### @sync-updater Process
1. Read current master list content
2. Locate specific tasks by description matching
3. Update from `[ ]` to `[x]` with completion date
4. Preserve all formatting, priorities, and structure
5. Verify updates with targeted section updates

### Success Metrics
- **Sync Lag**: <7 days between daily completion and master update
- **Accuracy Rate**: 100% task matching and completion date accuracy
- **Process Compliance**: Weekly sync sessions completed consistently  
- **Drift Prevention**: Zero sync gaps >7 days with hook system active

### Hook Integration Benefits
- **Proactive Reminders**: Automatic detection of sync need vs manual memory
- **Context-Aware**: Triggers based on actual completion patterns, not arbitrary schedules
- **Suppressible**: "sync completed" or "no sync needed" bypasses unnecessary reminders
- **Frequency Managed**: Maximum weekly frequency prevents notification spam

### Implementation Status
✅ **Specialist Agents**: @sync-scanner and @sync-updater configured with focused prompts
✅ **Claude Workspace Integration**: Sync system embedded in workspace for project-wide access  
✅ **Hook System**: Trigger patterns and reminder logic implemented
✅ **Documentation**: Complete workflow process documented
🎯 **Next**: Test sync agents with current LFW completion sync requirements

This systematic approach transforms manual sync memory into automated process enforcement through specialist agents and integrated hook triggers available across all projects.