# MCP Server Dependencies

## Overview
This document details all Model Context Protocol (MCP) server dependencies required for agent coordination, including installation requirements, configuration patterns, and integration specifications.

## Core MCP Servers

### Obsidian MCP Server
**Purpose**: Vault-based knowledge management and cross-referencing
**Status**: Critical for research and documentation agents

#### Installation Requirements
```bash
# Prerequisites
node --version    # Required: Node.js 16+
npm --version     # Required: npm 8+

# Installation
cd /Users/braydon/projects/experiments/obsidian_mcp
npm install
npm run build

# Verify installation
node dist/index.js --help
```

#### Configuration Requirements
```json
{
  "obsidian": {
    "command": "node",
    "args": ["/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js"],
    "env": {
      "OBSIDIAN_VAULT_PATH": "/users/braydon/obsidian/bvault"
    },
    "permissions": {
      "file_system": "read",
      "vault_access": "full"
    }
  }
}
```

#### Agent Dependencies
```markdown
## Agents Requiring Obsidian MCP
- **@research-agent**: Critical - For architectural analysis and pattern discovery
- **@documentation-agent**: Critical - For note creation and knowledge synthesis
- **@coordination-agent**: Recommended - For project context and cross-referencing
- **@review-agent**: Optional - For accessing project documentation during review

## Required Functions
- mcp__obsidian__query_vault: Intelligent vault searching
- mcp__obsidian__search_notes: Content and filename searching  
- mcp__obsidian__get_note: Full note content retrieval
- mcp__obsidian__create_note: Note creation with frontmatter
- mcp__obsidian__write_note: Note content updates
- mcp__obsidian__get_backlinks: Relationship mapping
```

#### External Dependencies
```markdown
## Obsidian Application
- **Requirement**: Obsidian app installed and configured
- **Vault Location**: /users/braydon/obsidian/bvault
- **Vault Permissions**: Read/write access required
- **Plugin Dependencies**: None (uses file system access)

## File System Requirements
- **Read Access**: Full vault directory tree
- **Write Access**: Note creation and modification
- **Path Sensitivity**: Case-sensitive file paths on macOS
```

### Journal MCP Server
**Purpose**: Agent activity logging and cross-session learning
**Status**: Critical for agent coordination

#### Installation Requirements
```bash
# Prerequisites  
node --version    # Required: Node.js 16+
npm --version     # Required: npm 8+

# Installation
cd /Users/braydon/projects/claude-workspace/mcps/journal-mcp
npm install
npm run build

# Verify installation
node dist/server.js --test
```

#### Configuration Requirements
```json
{
  "journal": {
    "command": "node",
    "args": ["/Users/braydon/projects/claude-workspace/mcps/journal-mcp/dist/server.js"],
    "env": {
      "JOURNAL_DATA_PATH": "/Users/braydon/.claude-workspace/journal",
      "LOG_LEVEL": "info"
    },
    "permissions": {
      "file_system": "read_write",
      "data_persistence": "required"
    }
  }
}
```

#### Agent Dependencies
```markdown
## Agents Requiring Journal MCP
- **@coordination-agent**: Critical - For workflow orchestration and learning
- **@implementation-agent**: Critical - For progress tracking and pattern storage
- **@review-agent**: Critical - For quality metrics and review history
- **ALL agents**: Recommended - For activity logging and learning integration

## Required Functions
- mcp__journal__log_agent_activity: Activity and outcome logging
- mcp__journal__store_session_memory: Cross-session learning storage
- mcp__journal__get_agent_context: Historical context retrieval
- mcp__journal__retrieve_relevant_memories: Pattern-based memory search
- mcp__journal__update_user_pattern: User preference learning
```

#### External Dependencies
```markdown
## File System Requirements
- **Data Directory**: /Users/braydon/.claude-workspace/journal
- **Write Permissions**: Full read/write access to journal directory
- **Storage Space**: Minimum 1GB for journal data
- **Backup Requirements**: Regular backup of journal data recommended

## No External Services
- **Self-Contained**: No external API dependencies
- **Local Storage**: All data stored locally
- **No Network**: No internet connectivity required
```

### Reminders MCP Server
**Purpose**: Task management and deadline tracking
**Status**: Recommended for coordination workflows

#### Installation Requirements
```bash
# Prerequisites
npm --version     # Required: npm 8+

# Installation (via npm package)
npx @modelcontextprotocol/server-reminders --help

# Verify installation
npx @modelcontextprotocol/server-reminders --version
```

#### Configuration Requirements
```json
{
  "reminders": {
    "command": "npx",
    "args": ["@modelcontextprotocol/server-reminders"],
    "env": {},
    "permissions": {
      "system_reminders": "read_write",
      "calendar_access": "optional"
    }
  }
}
```

#### Agent Dependencies
```markdown
## Agents Using Reminders MCP
- **@coordination-agent**: Recommended - For milestone and deadline tracking
- **@implementation-agent**: Optional - For task management during development
- **@deployment-agent**: Recommended - For deployment scheduling and monitoring

## Required Functions
- mcp__reminders__create_reminder: Task and milestone creation
- mcp__reminders__update_reminder: Status updates and modifications
- mcp__reminders__get_reminders: Task retrieval and filtering
- mcp__reminders__search_reminders: Finding specific tasks
```

#### External Dependencies
```markdown
## macOS System Integration
- **Reminders App**: Access to system Reminders application
- **Permissions**: System permissions for Reminders access
- **iCloud Sync**: Optional but recommended for cross-device access

## Permission Requirements
- **First Run**: Will prompt for Reminders app access permission
- **Ongoing**: Maintains permission through system keychain
- **Revocation**: Can be revoked through System Preferences > Privacy
```

## Project-Specific MCP Servers

### Healthcare Analytics MCP
**Purpose**: HIPAA-compliant data handling and healthcare workflow integration
**Status**: Required for healthcare projects only

#### Installation Requirements
```bash
# Custom MCP server (project-specific)
cd /Users/braydon/projects/claude-workspace/mcps/healthcare-mcp
npm install
npm run build

# Security validation
npm run test:hipaa-compliance
```

#### Configuration Requirements
```json
{
  "healthcare_data": {
    "command": "node",
    "args": ["/Users/braydon/projects/claude-workspace/mcps/healthcare-mcp/dist/server.js"],
    "env": {
      "HIPAA_COMPLIANCE": "true",
      "ENCRYPTION_KEY": "${HEALTHCARE_ENCRYPTION_KEY}",
      "AUDIT_LOG_PATH": "/Users/braydon/.claude-workspace/audit",
      "DATA_CLASSIFICATION": "PHI"
    },
    "security_level": "high",
    "audit_required": true
  }
}
```

#### External Dependencies
```markdown
## HIPAA Compliance Requirements
- **Encryption**: AES-256 encryption for data at rest
- **Audit Logging**: Comprehensive audit trail for all PHI access
- **Access Controls**: Role-based access control implementation
- **Data Retention**: Configurable data retention policies

## Healthcare Standards
- **HL7 FHIR**: Healthcare data interchange standards
- **ICD-10**: Medical coding standards integration
- **SNOMED CT**: Clinical terminology integration
```

### AI Tools MCP (Experiments)
**Purpose**: AI model coordination and experimental framework integration
**Status**: Required for AI experiment projects only

#### Installation Requirements
```bash
# Python-based MCP server
cd /Users/braydon/projects/claude-workspace/mcps/ai-tools-mcp
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Verify installation
python server.py --test
```

#### Configuration Requirements
```json
{
  "ai_tools": {
    "command": "python",
    "args": ["/Users/braydon/projects/claude-workspace/mcps/ai-tools-mcp/server.py"],
    "env": {
      "OPENAI_API_KEY": "${OPENAI_API_KEY}",
      "ANTHROPIC_API_KEY": "${ANTHROPIC_API_KEY}",
      "EXPERIMENT_DATA_PATH": "/Users/braydon/.claude-workspace/experiments",
      "RATE_LIMIT_ENABLED": "true"
    },
    "capabilities": [
      "model_coordination",
      "experiment_tracking",
      "ai_workflow_management"
    ]
  }
}
```

#### External Dependencies
```markdown
## AI Service APIs
- **OpenAI API**: GPT model access and coordination
- **Anthropic API**: Claude model access and coordination  
- **Rate Limiting**: Respect API rate limits and quotas
- **Cost Monitoring**: Track API usage and costs

## Python Dependencies
- **Python 3.9+**: Required runtime
- **Virtual Environment**: Isolated dependency management
- **Package Requirements**: See requirements.txt for full list
```

## MCP Server Health Monitoring

### Health Check Configuration
```bash
#!/bin/bash
# mcp-health-check.sh

echo "=== MCP Server Health Check ==="

# Check Obsidian MCP
if node /Users/braydon/projects/experiments/obsidian_mcp/dist/index.js --health; then
    echo "✅ Obsidian MCP: Healthy"
else
    echo "❌ Obsidian MCP: Unhealthy"
fi

# Check Journal MCP
if node /Users/braydon/projects/claude-workspace/mcps/journal-mcp/dist/server.js --health; then
    echo "✅ Journal MCP: Healthy"
else
    echo "❌ Journal MCP: Unhealthy"
fi

# Check Reminders MCP
if npx @modelcontextprotocol/server-reminders --health; then
    echo "✅ Reminders MCP: Healthy"
else
    echo "❌ Reminders MCP: Unhealthy"
fi

echo "=== Health Check Complete ==="
```

### Automated Monitoring
```yaml
# .github/workflows/mcp-health-monitoring.yml
name: MCP Server Health Monitoring

on:
  schedule:
    - cron: '0 */6 * * *'  # Every 6 hours
  workflow_dispatch:

jobs:
  health_check:
    runs-on: macos-latest  # macOS for Reminders access
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Setup Python
        uses: actions/setup-python@v4
        with:
          python-version: '3.9'
          
      - name: Run MCP health checks
        run: |
          chmod +x .github/scripts/mcp-health-check.sh
          .github/scripts/mcp-health-check.sh
          
      - name: Report health status
        run: |
          gh issue create \
            --title "MCP Server Health Report - $(date +%Y-%m-%d)" \
            --body-file mcp-health-report.md \
            --label "monitoring,mcp-health"
```

## Configuration Management

### Environment-Specific Configurations

#### Development Environment
```json
{
  "development": {
    "obsidian": {
      "vault_path": "/Users/braydon/obsidian/bvault-dev",
      "debug_mode": true
    },
    "journal": {
      "data_path": "/Users/braydon/.claude-workspace/journal-dev",
      "log_level": "debug"
    }
  }
}
```

#### Production Environment
```json
{
  "production": {
    "obsidian": {
      "vault_path": "/Users/braydon/obsidian/bvault",
      "debug_mode": false,
      "performance_optimized": true
    },
    "journal": {
      "data_path": "/Users/braydon/.claude-workspace/journal",
      "log_level": "info",
      "retention_days": 90
    }
  }
}
```

### Security Considerations
```markdown
## MCP Server Security
- **Environment Variables**: Use environment variables for sensitive data
- **File Permissions**: Restrict file system access to necessary directories
- **Network Security**: Prefer local MCP servers over network-based when possible
- **Audit Logging**: Enable comprehensive audit logging for sensitive operations

## Access Control
- **Principle of Least Privilege**: Grant minimum necessary permissions
- **Agent-Specific Access**: Different agents may need different MCP access levels
- **Permission Validation**: Regular validation of MCP server permissions
```

## Troubleshooting Guide

### Common Issues
```markdown
## Installation Issues
- **Node.js Version**: Ensure Node.js 16+ is installed
- **Permission Errors**: Check file system permissions for MCP directories
- **Path Issues**: Verify all paths are absolute and accessible

## Runtime Issues
- **Connection Failures**: Verify MCP server processes are running
- **Permission Denied**: Check system permissions for Reminders/Calendar access
- **Performance Issues**: Monitor MCP server resource usage

## Configuration Issues
- **Environment Variables**: Verify all required environment variables are set
- **Path Configuration**: Ensure all paths exist and are accessible
- **Dependency Conflicts**: Check for conflicting MCP server versions
```

This comprehensive documentation ensures all MCP server dependencies are properly understood, configured, and maintained for optimal agent coordination.