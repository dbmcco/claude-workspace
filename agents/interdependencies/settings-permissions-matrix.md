# Settings and Permissions Matrix

## Overview
This document provides a comprehensive matrix of settings configurations and permission requirements for all agent coordination components, ensuring proper access control and security across the entire system.

## Claude Code Settings.json Configuration

### Core Agent Configuration
```json
{
  "agent_coordination": {
    "enabled": true,
    "coordination_patterns": ["sequential", "parallel", "github_issue_based"],
    "default_pattern": "sequential",
    "quality_gates_enforced": true
  },
  "mcps": {
    "obsidian": {
      "command": "node",
      "args": ["/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js"],
      "env": {
        "OBSIDIAN_VAULT_PATH": "/users/braydon/obsidian/bvault"
      },
      "permissions": {
        "file_system": ["read", "write"],
        "vault_access": "full",
        "note_creation": true,
        "cross_referencing": true
      }
    },
    "journal": {
      "command": "node",
      "args": ["/Users/braydon/projects/claude-workspace/mcps/journal-mcp/dist/server.js"],
      "env": {
        "JOURNAL_DATA_PATH": "/Users/braydon/.claude-workspace/journal",
        "LOG_LEVEL": "info"
      },
      "permissions": {
        "file_system": ["read", "write"],
        "data_persistence": true,
        "session_storage": true,
        "pattern_learning": true
      }
    },
    "reminders": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-reminders"],
      "env": {},
      "permissions": {
        "system_reminders": ["read", "write"],
        "calendar_access": "optional",
        "notification_creation": true
      }
    }
  }
}
```

### Agent-Specific Settings
```json
{
  "agents": {
    "research_agent": {
      "role": "research",
      "required_mcps": ["obsidian", "journal"],
      "optional_mcps": ["reminders"],
      "permissions": {
        "file_system": {
          "read_access": ["src/", "docs/", "*.md", "*.json", "*.ts", "*.js"],
          "write_access": ["research-analysis.md", "architecture-docs/"],
          "forbidden": ["node_modules/", ".git/", "dist/"]
        },
        "tools": {
          "required": ["Grep", "Glob", "Read", "WebSearch"],
          "optional": ["WebFetch"],
          "forbidden": ["Edit", "Write", "MultiEdit"]
        },
        "external_services": {
          "web_search": true,
          "web_fetch": true,
          "github_read": true,
          "github_write": false
        }
      }
    },
    "implementation_agent": {
      "role": "implementation",
      "required_mcps": ["journal"],
      "optional_mcps": ["obsidian", "reminders"],
      "permissions": {
        "file_system": {
          "read_access": ["src/", "tests/", "*.md", "*.json", "*.ts", "*.js"],
          "write_access": ["src/", "tests/", "package.json"],
          "forbidden": [".git/", "node_modules/", "dist/"]
        },
        "tools": {
          "required": ["TodoWrite", "Edit", "MultiEdit", "Read", "Bash"],
          "optional": ["Grep", "Glob"],
          "forbidden": ["WebFetch"]
        },
        "external_services": {
          "npm_install": true,
          "test_execution": true,
          "github_read": true,
          "github_write": true
        }
      }
    },
    "review_agent": {
      "role": "review",
      "required_mcps": ["journal"],
      "optional_mcps": ["obsidian"],
      "permissions": {
        "file_system": {
          "read_access": ["src/", "tests/", "docs/", "*.md", "*.json", "*.ts", "*.js"],
          "write_access": ["review-reports/", "quality-analysis.md"],
          "forbidden": ["src/", ".git/", "node_modules/"]
        },
        "tools": {
          "required": ["Read", "Grep", "Bash"],
          "optional": ["WebSearch", "Glob"],
          "forbidden": ["Edit", "Write", "MultiEdit"]
        },
        "external_services": {
          "security_scanning": true,
          "quality_tools": true,
          "github_read": true,
          "github_write": false
        }
      }
    },
    "coordination_agent": {
      "role": "coordination",
      "required_mcps": ["journal", "reminders"],
      "optional_mcps": ["obsidian"],
      "permissions": {
        "file_system": {
          "read_access": ["src/", "docs/", "*.md", "*.json"],
          "write_access": ["coordination-plans/", "workflow-status.json"],
          "forbidden": ["src/", ".git/", "node_modules/"]
        },
        "tools": {
          "required": ["TodoWrite", "Read", "Write"],
          "optional": ["Grep", "Glob", "Bash"],
          "forbidden": ["Edit", "MultiEdit"]
        },
        "external_services": {
          "github_full": true,
          "all_mcps": true,
          "workflow_orchestration": true
        }
      }
    }
  }
}
```

## File System Permissions Matrix

### Directory Access Patterns
```markdown
| Directory | Research | Implementation | Review | Coordination | Notes |
|-----------|----------|----------------|--------|--------------|-------|
| `/src/` | Read | Read/Write | Read | Read | Core source code |
| `/tests/` | Read | Read/Write | Read | Read | Test files |
| `/docs/` | Read/Write | Read | Read/Write | Read/Write | Documentation |
| `/node_modules/` | Forbidden | Forbidden | Forbidden | Forbidden | Dependencies |
| `/.git/` | Forbidden | Forbidden | Forbidden | Forbidden | Version control |
| `/dist/` | Forbidden | Forbidden | Read | Read | Build artifacts |
| `/research-analysis/` | Read/Write | Read | Read | Read | Research outputs |
| `/coordination-plans/` | Read | Read | Read | Read/Write | Workflow plans |
| `/review-reports/` | Read | Read | Read/Write | Read | Quality reports |
```

### File Type Permissions
```json
{
  "file_permissions": {
    "*.ts": {
      "research_agent": "read",
      "implementation_agent": "read_write",
      "review_agent": "read",
      "coordination_agent": "read"
    },
    "*.js": {
      "research_agent": "read",
      "implementation_agent": "read_write",
      "review_agent": "read",
      "coordination_agent": "read"
    },
    "*.json": {
      "research_agent": "read",
      "implementation_agent": "read_write",
      "review_agent": "read",
      "coordination_agent": "read_write"
    },
    "*.md": {
      "research_agent": "read_write",
      "implementation_agent": "read",
      "review_agent": "read_write",
      "coordination_agent": "read_write"
    },
    "package.json": {
      "research_agent": "read",
      "implementation_agent": "read_write",
      "review_agent": "read",
      "coordination_agent": "read"
    },
    "package-lock.json": {
      "research_agent": "read",
      "implementation_agent": "read_write",
      "review_agent": "read",
      "coordination_agent": "forbidden"
    }
  }
}
```

## MCP Server Permission Configuration

### Obsidian MCP Permissions
```json
{
  "obsidian_mcp_permissions": {
    "vault_access": {
      "research_agent": {
        "read_notes": true,
        "write_notes": true,
        "create_notes": true,
        "delete_notes": false,
        "modify_vault_config": false
      },
      "implementation_agent": {
        "read_notes": true,
        "write_notes": false,
        "create_notes": false,
        "delete_notes": false,
        "modify_vault_config": false
      },
      "review_agent": {
        "read_notes": true,
        "write_notes": true,
        "create_notes": true,
        "delete_notes": false,
        "modify_vault_config": false
      },
      "coordination_agent": {
        "read_notes": true,
        "write_notes": true,
        "create_notes": true,
        "delete_notes": false,
        "modify_vault_config": false
      }
    },
    "function_access": {
      "mcp__obsidian__query_vault": ["all_agents"],
      "mcp__obsidian__search_notes": ["all_agents"],
      "mcp__obsidian__get_note": ["all_agents"],
      "mcp__obsidian__create_note": ["research_agent", "review_agent", "coordination_agent"],
      "mcp__obsidian__write_note": ["research_agent", "review_agent", "coordination_agent"],
      "mcp__obsidian__get_backlinks": ["research_agent", "coordination_agent"]
    }
  }
}
```

### Journal MCP Permissions
```json
{
  "journal_mcp_permissions": {
    "data_access": {
      "all_agents": {
        "log_activity": true,
        "read_own_logs": true,
        "read_cross_agent_logs": true,
        "store_session_memory": true,
        "retrieve_memories": true
      },
      "coordination_agent": {
        "read_all_logs": true,
        "modify_coordination_data": true,
        "manage_workflow_state": true,
        "access_learning_patterns": true
      }
    },
    "function_access": {
      "mcp__journal__log_agent_activity": ["all_agents"],
      "mcp__journal__store_session_memory": ["all_agents"],
      "mcp__journal__get_agent_context": ["all_agents"],
      "mcp__journal__retrieve_relevant_memories": ["all_agents"],
      "mcp__journal__update_user_pattern": ["coordination_agent"],
      "mcp__journal__manage_workflow_state": ["coordination_agent"]
    }
  }
}
```

### Reminders MCP Permissions
```json
{
  "reminders_mcp_permissions": {
    "system_access": {
      "coordination_agent": {
        "create_reminders": true,
        "update_reminders": true,
        "delete_reminders": true,
        "list_all_reminders": true
      },
      "implementation_agent": {
        "create_reminders": true,
        "update_own_reminders": true,
        "delete_own_reminders": true,
        "list_own_reminders": true
      },
      "review_agent": {
        "create_reminders": true,
        "update_own_reminders": true,
        "delete_own_reminders": false,
        "list_own_reminders": true
      }
    },
    "reminder_lists": {
      "Agent Coordination": ["coordination_agent"],
      "Implementation Tasks": ["implementation_agent", "coordination_agent"],
      "Review Tasks": ["review_agent", "coordination_agent"],
      "Quality Gates": ["all_agents"]
    }
  }
}
```

## External Service Permissions

### GitHub API Permissions
```json
{
  "github_permissions": {
    "repository_access": {
      "research_agent": {
        "read_code": true,
        "read_issues": true,
        "read_prs": false,
        "write_issues": false,
        "write_prs": false,
        "manage_branches": false
      },
      "implementation_agent": {
        "read_code": true,
        "read_issues": true,
        "read_prs": true,
        "write_issues": true,
        "write_prs": true,
        "manage_branches": true
      },
      "review_agent": {
        "read_code": true,
        "read_issues": true,
        "read_prs": true,
        "write_issues": false,
        "write_prs": false,
        "review_prs": true
      },
      "coordination_agent": {
        "read_code": true,
        "read_issues": true,
        "read_prs": true,
        "write_issues": true,
        "write_prs": true,
        "manage_branches": true,
        "trigger_workflows": true
      }
    },
    "required_scopes": [
      "repo",           # Full repository access
      "workflow",       # GitHub Actions workflow access
      "read:org",       # Organization access
      "user:email"      # User email access
    ]
  }
}
```

### AI Service API Permissions
```json
{
  "ai_service_permissions": {
    "openai_api": {
      "research_agent": {
        "models": ["gpt-4", "gpt-3.5-turbo"],
        "max_tokens_per_request": 4000,
        "max_requests_per_hour": 100,
        "functions": ["chat_completions", "embeddings"]
      },
      "coordination_agent": {
        "models": ["gpt-3.5-turbo"],
        "max_tokens_per_request": 2000,
        "max_requests_per_hour": 50,
        "functions": ["chat_completions"]
      }
    },
    "anthropic_api": {
      "all_agents": {
        "models": ["claude-3-sonnet", "claude-3-haiku"],
        "max_tokens_per_request": 4000,
        "max_requests_per_hour": 100,
        "functions": ["messages"]
      }
    }
  }
}
```

## System-Level Permissions

### macOS System Permissions
```markdown
## Required System Permissions
- **File System Access**: Full access to project directories
- **Reminders Access**: System Reminders app integration
- **Network Access**: HTTP/HTTPS for external APIs
- **Process Execution**: Node.js, npm, Python processes

## Permission Grant Process
1. **First Run**: System will prompt for permissions
2. **Security Settings**: Grant access through System Preferences > Privacy
3. **Keychain Access**: Store API keys securely in keychain
4. **Terminal Access**: Full disk access for Claude Code CLI
```

### Environment Variable Management
```bash
# Required environment variables
export OBSIDIAN_VAULT_PATH="/users/braydon/obsidian/bvault"
export JOURNAL_DATA_PATH="/Users/braydon/.claude-workspace/journal"
export OPENAI_API_KEY="sk-..."
export ANTHROPIC_API_KEY="sk-ant-..."
export GITHUB_TOKEN="ghp_..."

# Optional environment variables  
export VERCEL_TOKEN="..."
export SENTRY_DSN="..."
export LOG_LEVEL="info"
export RATE_LIMIT_ENABLED="true"
```

## Security Configuration

### Access Control Implementation
```typescript
// Agent permission validation
interface AgentPermissions {
  agent_id: string;
  file_system: FileSystemPermissions;
  tools: ToolPermissions;
  mcps: MCPPermissions;
  external_services: ExternalServicePermissions;
}

class PermissionValidator {
  validateFileAccess(agent: string, path: string, operation: 'read' | 'write'): boolean {
    const permissions = this.getAgentPermissions(agent);
    return this.checkFileSystemPermission(permissions, path, operation);
  }
  
  validateToolUsage(agent: string, tool: string): boolean {
    const permissions = this.getAgentPermissions(agent);
    return permissions.tools.allowed.includes(tool);
  }
  
  validateMCPAccess(agent: string, mcpFunction: string): boolean {
    const permissions = this.getAgentPermissions(agent);
    return this.checkMCPPermission(permissions, mcpFunction);
  }
}
```

### Audit Logging Configuration
```json
{
  "audit_logging": {
    "enabled": true,
    "log_level": "info",
    "destinations": [
      "journal_mcp",
      "file_system"
    ],
    "events": {
      "file_access": true,
      "mcp_calls": true,
      "external_api_calls": true,
      "permission_violations": true,
      "workflow_state_changes": true
    },
    "retention": {
      "audit_logs": "90_days",
      "session_data": "30_days",
      "error_logs": "180_days"
    }
  }
}
```

## Configuration Validation

### Settings Validation Script
```bash
#!/bin/bash
# validate-agent-settings.sh

echo "=== Agent Settings Validation ==="

# Check MCP server availability
echo "Checking MCP servers..."
if [ -f "/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js" ]; then
    echo "✅ Obsidian MCP server found"
else
    echo "❌ Obsidian MCP server missing"
fi

# Check environment variables
echo "Checking environment variables..."
if [ -n "$OBSIDIAN_VAULT_PATH" ]; then
    echo "✅ OBSIDIAN_VAULT_PATH set"
else
    echo "❌ OBSIDIAN_VAULT_PATH missing"
fi

# Check permissions
echo "Checking file permissions..."
if [ -r "/users/braydon/obsidian/bvault" ]; then
    echo "✅ Obsidian vault readable"
else
    echo "❌ Obsidian vault not accessible"
fi

echo "=== Validation Complete ==="
```

### Automated Permission Testing
```typescript
// Permission testing suite
describe('Agent Permissions', () => {
  test('research agent can read source files', async () => {
    const validator = new PermissionValidator();
    expect(validator.validateFileAccess('research_agent', 'src/index.ts', 'read')).toBe(true);
  });
  
  test('research agent cannot write source files', async () => {
    const validator = new PermissionValidator();
    expect(validator.validateFileAccess('research_agent', 'src/index.ts', 'write')).toBe(false);
  });
  
  test('implementation agent can use Edit tool', async () => {
    const validator = new PermissionValidator();
    expect(validator.validateToolUsage('implementation_agent', 'Edit')).toBe(true);
  });
  
  test('review agent cannot use Edit tool', async () => {
    const validator = new PermissionValidator();
    expect(validator.validateToolUsage('review_agent', 'Edit')).toBe(false);
  });
});
```

This comprehensive permissions matrix ensures secure, controlled access across all agent coordination components while maintaining the flexibility needed for effective multi-agent workflows.