# MCP System Architecture

## Overview

The Claude workspace now features a unified MCP (Model Context Protocol) integration system that provides consistent access to 5 core MCPs across all projects and agents.

## Supported MCPs

### 1. Obsidian MCP
- **Purpose**: Vault access and note intelligence
- **Functions**: `mcp__obsidian__*`
- **Key Capabilities**: query_vault, search_notes, create_note, get_backlinks
- **Location**: `/Users/braydon/projects/experiments/mcp/obsidian_mcp/`

### 2. Journal MCP 
- **Purpose**: Agent coordination and cross-session learning
- **Functions**: `mcp__journal__*`
- **Key Capabilities**: log_agent_activity, store_session_memory, get_agent_context
- **Location**: `/Users/braydon/projects/experiments/mcp/journal-mcp/`

### 3. Todoist MCP
- **Purpose**: Task creation and project management
- **Functions**: `mcp__todoist__*`
- **Key Capabilities**: create_task, get_tasks, update_task, delete_task
- **Location**: `/Users/braydon/projects/experiments/mcp/todoist_mcp/`

### 4. Reminders MCP
- **Purpose**: Apple Reminders system integration
- **Functions**: `mcp__reminders__*`
- **Key Capabilities**: create_reminder, list_reminder_lists, update_reminder
- **Location**: `/Users/braydon/projects/experiments/mcp/reminders_mcp/`

### 5. Notes MCP
- **Purpose**: Apple Notes system integration  
- **Functions**: `mcp__notes__*`
- **Key Capabilities**: create_note, search_notes, list_notes, update_note
- **Location**: `/Users/braydon/projects/experiments/mcp/notes_mcp/`

### 6. Canva MCP
- **Purpose**: Design and creative tools
- **Functions**: Canvas design integration
- **Key Capabilities**: NPX-based integration with Canva CLI
- **Location**: NPM package `@canva/cli@latest`

## Configuration Architecture

### Master Configuration Files

1. **Root MCP Standard**: `/Users/braydon/projects/mcp-standard.json`
   - Central configuration for all MCPs
   - Used by Claude Desktop and deployment scripts

2. **Global Workspace Config**: `/Users/braydon/projects/claude-workspace/settings/global-mcp-config.json`
   - Workspace-wide MCP settings with tool descriptions
   - Includes permissions and tool function mappings

3. **Template Configuration**: `/Users/braydon/projects/claude-workspace/templates/mcp-config-with-journal.json`
   - Template for project-level MCP configurations
   - Inherits from global settings

4. **Claude Desktop Template**: `/Users/braydon/projects/claude-workspace/templates/claude_desktop.json`
   - Standard Claude Desktop configuration
   - Ready for deployment to `~/.config/claude_desktop/`

### Project-Level Inheritance

Projects inherit MCP access through:

1. **Template System**: New projects get full MCP configuration via templates
2. **Permission Inheritance**: All project settings include `mcp__*__*` permissions
3. **Global Flag**: `enableAllProjectMcpServers: true` in project configurations
4. **Automatic Discovery**: Claude recursively discovers MCP configurations

## Deployment Infrastructure

### Core Deployment Scripts

1. **Universal Deployment**: `deploy-all-mcps.sh`
   - Builds all 5 MCPs from source
   - Deploys unified configuration to Claude Desktop
   - Updates workspace settings and templates

2. **Project Deployment**: `deploy-project-mcps.sh`
   - Updates individual project `.mcp.json` files
   - Adds all MCPs to existing projects
   - Configures permissions and inheritance

3. **Notes MCP Specific**: `deploy-notes-mcp.sh`
   - Targeted deployment for Apple Notes MCP
   - Useful for isolated testing and updates

4. **Validation Suite**: `validate-mcp-deployment.sh`
   - Comprehensive validation of entire MCP system
   - Checks builds, configurations, permissions
   - Provides detailed deployment status

### Permission System

All MCPs use standardized permissions:

```json
{
  "permissions": {
    "allow": [
      "mcp__obsidian__*",
      "mcp__journal__*", 
      "mcp__todoist__*",
      "mcp__reminders__*",
      "mcp__notes__*"
    ]
  },
  "enableAllProjectMcpServers": true
}
```

## Usage Patterns

### Root Access
From `/Users/braydon/projects/claude.md`, all MCPs are available:
- `mcp__obsidian__query_vault` - Search Obsidian vault
- `mcp__todoist__create_task` - Create Todoist tasks
- `mcp__reminders__create_reminder` - Add Apple Reminders
- `mcp__notes__create_note` - Create Apple Notes
- `mcp__journal__log_agent_activity` - Log agent coordination

### Project Access
All subprojects inherit MCP access automatically through:
- Standardized `.mcp.json` configurations
- Permission inheritance from workspace settings
- Global MCP server enablement flag

### Agent Coordination
Multiple Claude agents can access all MCPs simultaneously:
- Shared configuration ensures consistency
- Journal MCP enables cross-agent learning
- No conflicts between agent MCP usage

## Maintenance Procedures

### Adding New MCPs

1. Create MCP in `/Users/braydon/projects/experiments/mcp/new_mcp/`
2. Update `mcp-standard.json` with new MCP configuration
3. Add permissions to project settings templates
4. Update deployment scripts to include new MCP
5. Run validation to ensure proper integration

### Updating Existing MCPs

1. Update MCP source code
2. Run `deploy-all-mcps.sh` to rebuild and redeploy
3. Test with `validate-mcp-deployment.sh`
4. Update project configurations if needed

### Troubleshooting

1. **Build Issues**: Check individual MCP directories for build errors
2. **Permission Issues**: Verify MCP permissions in project settings
3. **Configuration Issues**: Use validation script to identify problems
4. **Access Issues**: Ensure Claude Desktop has been restarted after deployment

## System Benefits

1. **Consistency**: All projects and agents use identical MCP configurations
2. **Maintainability**: Central configuration management reduces fragmentation
3. **Scalability**: Easy to add new MCPs or update existing ones
4. **Reliability**: Comprehensive validation ensures system integrity
5. **Flexibility**: Individual MCPs can be deployed separately when needed

## Integration Points

- **GitHub Issues**: Todoist and Reminders MCPs for task management
- **Documentation**: Obsidian MCP for knowledge management
- **Agent Learning**: Journal MCP for cross-session coordination
- **Creative Work**: Canva MCP for design integration
- **Quick Notes**: Apple Notes MCP for rapid capture