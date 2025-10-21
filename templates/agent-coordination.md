# Agent-Enabled Project Template

## Template Overview
This template provides the complete configuration for enabling multi-agent coordination in any project, including Claude memory setup, MCP server configuration, and GitHub workflow integration.

## Project Initialization

### 1. Claude Memory Structure
Create the following directory structure in your project root:

```
project-root/
├── .claude/
│   ├── memories/
│   │   ├── base/
│   │   │   ├── interaction-style.md
│   │   │   ├── core-principles.md
│   │   │   ├── code-standards.md
│   │   │   └── version-control.md
│   │   ├── workflows/
│   │   │   ├── tdd.md
│   │   │   ├── agent-coordination.md
│   │   │   └── llm-driven-development.md
│   │   └── project-specific/
│   │       ├── architecture.md
│   │       ├── dependencies.md
│   │       └── quality-gates.md
│   └── settings/
│       ├── mcp-config.json
│       ├── agent-roles.json
│       └── coordination-patterns.json
├── CLAUDE.md
└── .github/
    ├── workflows/
    │   ├── agent-coordination.yml
    │   ├── quality-gates.yml
    │   └── mcp-health-check.yml
    └── ISSUE_TEMPLATE/
        ├── multi-agent-feature.md
        └── single-agent-task.md
```

### 2. Core CLAUDE.md Template
```markdown
# {PROJECT_NAME} - Claude Memory

@./.claude/memories/base/interaction-style.md
@./.claude/memories/base/core-principles.md
@./.claude/memories/base/code-standards.md
@./.claude/memories/workflows/tdd.md
@./.claude/memories/workflows/agent-coordination.md
@./.claude/memories/project-specific/architecture.md

## Project Overview
**Type**: {PROJECT_TYPE} # personal/work/experiments
**Tech Stack**: {TECH_STACK} # React, TypeScript, Node.js, etc.
**Complexity**: {COMPLEXITY} # simple/moderate/complex
**Agent Coordination**: Enabled

## Agent Configuration
**Primary Pattern**: {COORDINATION_PATTERN} # sequential/parallel/github_issue_based
**Required Agents**: {AGENT_LIST} # @research-agent, @implementation-agent, @review-agent
**MCP Servers**: {MCP_SERVERS} # obsidian, journal, reminders

## Quality Standards
- **Test Coverage**: >90% for core logic
- **Performance**: <500ms response times
- **Security**: Comprehensive security review required
- **Documentation**: Maintained and current

## External Dependencies
{EXTERNAL_DEPENDENCIES} # List project-specific dependencies

## Coordination Notes
{COORDINATION_NOTES} # Project-specific coordination requirements

## Success Metrics
- Agent coordination effectiveness: >95%
- Quality gate pass rate: >98%
- Feature delivery time: Target {DELIVERY_TIME}
- User satisfaction: >4.5/5
```

### 3. MCP Configuration Template
```json
{
  "mcps": {
    "obsidian": {
      "command": "node",
      "args": ["/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js"],
      "env": {
        "OBSIDIAN_VAULT_PATH": "/users/braydon/obsidian/bvault"
      }
    },
    "journal": {
      "command": "node",
      "args": ["/Users/braydon/projects/claude-workspace/mcps/journal-mcp/dist/server.js"],
      "env": {
        "JOURNAL_DATA_PATH": "/Users/braydon/.claude-workspace/journal"
      }
    },
    "reminders": {
      "command": "npx",
      "args": ["@modelcontextprotocol/server-reminders"],
      "env": {}
    }
  },
  "agent_coordination": {
    "enabled": true,
    "patterns": {
      "default": "{DEFAULT_PATTERN}",
      "available": ["sequential", "parallel", "github_issue_based"]
    },
    "quality_gates": {
      "enforced": true,
      "required_checks": ["lint", "type-check", "test", "coverage"]
    }
  },
  "project_context": {
    "type": "{PROJECT_TYPE}",
    "tech_stack": ["{TECH_STACK}"],
    "complexity": "{COMPLEXITY}",
    "agent_requirements": {
      "research": "{RESEARCH_REQUIRED}",
      "implementation": "required",
      "review": "required",
      "deployment": "{DEPLOYMENT_REQUIRED}"
    }
  }
}
```

## Project-Type Specific Templates

### Personal React Project Template
```markdown
# Personal React Project - Agent Configuration

## Project Specifics
- **Type**: personal
- **Tech Stack**: React, TypeScript, Next.js, Tailwind CSS
- **Deployment**: Vercel
- **Complexity**: moderate

## Agent Assignments
- **@research-agent**: Architecture analysis and pattern discovery
- **@implementation-agent**: TDD implementation with React best practices
- **@ui-agent**: Component design and user experience
- **@review-agent**: Code quality and performance review
- **@deployment-agent**: Vercel deployment automation

## Quality Gates
```bash
npm run lint           # ESLint + React rules
npm run type-check     # TypeScript strict mode
npm test              # Jest + React Testing Library
npm run test:coverage # >90% coverage required
npm run build         # Next.js build validation
```

## MCP Requirements
- **Obsidian**: For documentation and pattern library
- **Journal**: For development progress tracking
- **Reminders**: For feature milestone tracking

## External Dependencies
- **Vercel**: For deployment and hosting
- **GitHub**: For repository and workflow management
- **npm**: For package management
```

### Work Healthcare Project Template
```markdown
# Healthcare Analytics Project - Agent Configuration

## Project Specifics
- **Type**: work/healthcare
- **Tech Stack**: React, TypeScript, Node.js, PostgreSQL
- **Compliance**: HIPAA
- **Security Level**: high

## Agent Assignments
- **@research-agent**: Architecture analysis with security focus
- **@auth-agent**: HIPAA-compliant authentication system
- **@data-agent**: Secure database design and encryption
- **@implementation-agent**: TDD with security-first approach
- **@security-agent**: Comprehensive security review
- **@review-agent**: Code quality and compliance validation
- **@deployment-agent**: Secure deployment with audit logging

## Quality Gates
```bash
npm run lint               # ESLint with security rules
npm run type-check         # TypeScript strict mode
npm test                  # Jest with security tests
npm run test:security     # Security vulnerability scanning
npm run test:compliance   # HIPAA compliance validation
npm run audit             # Dependency security audit
```

## MCP Requirements
- **Obsidian**: For compliance documentation
- **Journal**: For audit trail and security logging
- **Healthcare**: For HIPAA-compliant data handling

## External Dependencies
- **AWS HIPAA**: For compliant hosting
- **Healthcare APIs**: For HL7/FHIR integration
- **Security Tools**: For vulnerability scanning
- **Audit Services**: For compliance monitoring
```

### Experiments AI Project Template
```markdown
# AI Experiments Project - Agent Configuration

## Project Specifics
- **Type**: experiments/ai
- **Tech Stack**: Python, TypeScript, LangChain, FastAPI
- **Focus**: AI coordination and experimentation
- **Complexity**: complex

## Agent Assignments
- **@research-agent**: AI architecture and framework analysis
- **@coordination-agent**: Multi-agent AI workflow orchestration
- **@implementation-agent**: AI integration implementation
- **@ai-agent**: AI model coordination and optimization
- **@review-agent**: AI ethics and safety review
- **@deployment-agent**: AI service deployment

## Quality Gates
```bash
python -m pytest          # Python testing
npm run lint              # TypeScript linting
npm run type-check        # TypeScript validation
python -m mypy .          # Python type checking
npm run test:ai-ethics    # AI ethics validation
npm run test:performance  # AI performance benchmarks
```

## MCP Requirements
- **Obsidian**: For AI research documentation
- **Journal**: For experiment tracking and learning
- **AI Tools**: For model coordination and management

## External Dependencies
- **OpenAI API**: For GPT model access
- **Anthropic API**: For Claude model access
- **Vector Databases**: For embeddings and similarity search
- **ML Platforms**: For experiment tracking
```

## GitHub Workflow Templates

### Agent Coordination Workflow
```yaml
# .github/workflows/agent-coordination.yml
name: Agent Coordination

on:
  issues:
    types: [opened, labeled]
  issue_comment:
    types: [created]

jobs:
  coordinate_agents:
    if: contains(github.event.issue.labels.*.name, 'agent-coordination')
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: npm install
        
      - name: Setup MCP servers
        run: npm run setup:mcp
        
      - name: Parse coordination requirements
        id: parse
        run: |
          node .github/scripts/parse-coordination.js \
            --issue-number="${{ github.event.issue.number }}" \
            --issue-body="${{ github.event.issue.body }}"
            
      - name: Create agent branches
        run: |
          for agent in ${{ steps.parse.outputs.agents }}; do
            git checkout -b "feature/${{ github.event.issue.number }}-${agent}"
            git push origin "feature/${{ github.event.issue.number }}-${agent}"
          done
          
      - name: Trigger agent workflows
        run: |
          for agent in ${{ steps.parse.outputs.agents }}; do
            gh workflow run "agent-${agent}.yml" \
              -f issue_number="${{ github.event.issue.number }}" \
              -f coordination_pattern="${{ steps.parse.outputs.pattern }}"
          done
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Quality Gates Workflow
```yaml
# .github/workflows/quality-gates.yml
name: Quality Gates

on:
  pull_request:
    branches: [main, develop]
  push:
    branches: [main, develop]

jobs:
  quality_gates:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Install dependencies
        run: npm install
        
      - name: Run ESLint
        run: npm run lint
        
      - name: Run TypeScript check
        run: npm run type-check
        
      - name: Run tests
        run: npm test
        
      - name: Check test coverage
        run: npm run test:coverage
        
      - name: Security audit
        run: npm audit
        
      - name: Build project
        run: npm run build
        
      - name: Update coordination status
        if: always()
        run: |
          node .github/scripts/update-coordination-status.js \
            --pr-number="${{ github.event.pull_request.number }}" \
            --status="${{ job.status }}"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Setup Scripts

### Project Initialization Script
```bash
#!/bin/bash
# setup-agent-coordination.sh

set -e

PROJECT_NAME="$1"
PROJECT_TYPE="$2"
COORDINATION_PATTERN="${3:-sequential}"

if [ -z "$PROJECT_NAME" ] || [ -z "$PROJECT_TYPE" ]; then
    echo "Usage: $0 <project_name> <project_type> [coordination_pattern]"
    echo "Project types: personal, work, experiments"
    echo "Coordination patterns: sequential, parallel, github_issue_based"
    exit 1
fi

echo "Setting up agent coordination for $PROJECT_NAME ($PROJECT_TYPE)..."

# Create directory structure
mkdir -p .claude/{memories/{base,workflows,project-specific},settings}
mkdir -p .github/{workflows,ISSUE_TEMPLATE,scripts}

# Copy base memory files
cp -r /Users/braydon/projects/claude-workspace/memories/base/* .claude/memories/base/
cp -r /Users/braydon/projects/claude-workspace/memories/workflows/* .claude/memories/workflows/

# Generate project-specific CLAUDE.md
cat > CLAUDE.md << EOF
# $PROJECT_NAME - Claude Memory

@./.claude/memories/base/interaction-style.md
@./.claude/memories/base/core-principles.md
@./.claude/memories/base/code-standards.md
@./.claude/memories/workflows/tdd.md
@./.claude/memories/workflows/agent-coordination.md
@./.claude/memories/project-specific/architecture.md

## Project Overview
**Type**: $PROJECT_TYPE
**Agent Coordination**: Enabled
**Primary Pattern**: $COORDINATION_PATTERN

## Quality Standards
- Test Coverage: >90% for core logic
- Performance: <500ms response times
- Security: Comprehensive security review required

EOF

# Generate MCP configuration
cat > .claude/settings/mcp-config.json << EOF
{
  "mcps": {
    "obsidian": {
      "command": "node",
      "args": ["/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js"],
      "env": {
        "OBSIDIAN_VAULT_PATH": "/users/braydon/obsidian/bvault"
      }
    },
    "journal": {
      "command": "node",
      "args": ["/Users/braydon/projects/claude-workspace/mcps/journal-mcp/dist/server.js"],
      "env": {
        "JOURNAL_DATA_PATH": "/Users/braydon/.claude-workspace/journal"
      }
    }
  },
  "agent_coordination": {
    "enabled": true,
    "default_pattern": "$COORDINATION_PATTERN"
  }
}
EOF

# Copy GitHub workflows
cp /Users/braydon/projects/claude-workspace/agents/workflows/*.yml .github/workflows/
cp /Users/braydon/projects/claude-workspace/templates/github-issue-templates/* .github/ISSUE_TEMPLATE/

# Copy coordination scripts
cp /Users/braydon/projects/claude-workspace/tools/coordination-scripts/* .github/scripts/

echo "✅ Agent coordination setup complete!"
echo "📁 Directory structure created"
echo "📄 CLAUDE.md generated"
echo "⚙️  MCP configuration created"
echo "🔧 GitHub workflows installed"
echo ""
echo "Next steps:"
echo "1. Customize .claude/memories/project-specific/ files"
echo "2. Update CLAUDE.md with project-specific details"
echo "3. Configure GitHub repository settings"
echo "4. Test MCP server connections"
```

### MCP Setup Script
```bash
#!/bin/bash
# setup-mcp-servers.sh

echo "Setting up MCP servers for agent coordination..."

# Check prerequisites
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is required but not installed"
    exit 1
fi

if ! command -v npm &> /dev/null; then
    echo "❌ npm is required but not installed"
    exit 1
fi

# Setup Obsidian MCP
echo "📝 Setting up Obsidian MCP server..."
if [ ! -f "/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js" ]; then
    echo "❌ Obsidian MCP server not found. Please install first."
    exit 1
fi

# Setup Journal MCP
echo "📊 Setting up Journal MCP server..."
if [ ! -f "/Users/braydon/projects/claude-workspace/mcps/journal-mcp/dist/server.js" ]; then
    echo "Building Journal MCP server..."
    cd /Users/braydon/projects/claude-workspace/mcps/journal-mcp
    npm install
    npm run build
    cd - > /dev/null
fi

# Setup Reminders MCP
echo "⏰ Setting up Reminders MCP server..."
npx @modelcontextprotocol/server-reminders --version || {
    echo "Installing Reminders MCP server..."
    npm install -g @modelcontextprotocol/server-reminders
}

# Test MCP servers
echo "🧪 Testing MCP server connections..."
node -e "
const fs = require('fs');
const path = require('path');

const mcpConfig = JSON.parse(fs.readFileSync('.claude/settings/mcp-config.json', 'utf8'));
console.log('MCP Configuration loaded successfully');
console.log('Configured servers:', Object.keys(mcpConfig.mcps));
"

echo "✅ MCP servers setup complete!"
```

### Validation Script
```bash
#!/bin/bash
# validate-agent-setup.sh

echo "🔍 Validating agent coordination setup..."

# Check directory structure
echo "Checking directory structure..."
required_dirs=(
    ".claude/memories/base"
    ".claude/memories/workflows"
    ".claude/memories/project-specific"
    ".claude/settings"
    ".github/workflows"
    ".github/ISSUE_TEMPLATE"
)

for dir in "${required_dirs[@]}"; do
    if [ -d "$dir" ]; then
        echo "✅ $dir"
    else
        echo "❌ $dir (missing)"
    fi
done

# Check required files
echo "Checking required files..."
required_files=(
    "CLAUDE.md"
    ".claude/settings/mcp-config.json"
    ".github/workflows/agent-coordination.yml"
    ".github/workflows/quality-gates.yml"
)

for file in "${required_files[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ $file (missing)"
    fi
done

# Validate MCP configuration
echo "Validating MCP configuration..."
if node -e "
const config = require('./.claude/settings/mcp-config.json');
console.log('✅ MCP configuration valid');
console.log('Servers configured:', Object.keys(config.mcps).join(', '));
" 2>/dev/null; then
    echo "✅ MCP configuration valid"
else
    echo "❌ MCP configuration invalid"
fi

# Check MCP server availability
echo "Checking MCP server availability..."
if [ -f "/Users/braydon/projects/experiments/obsidian_mcp/dist/index.js" ]; then
    echo "✅ Obsidian MCP server available"
else
    echo "❌ Obsidian MCP server not found"
fi

if [ -f "/Users/braydon/projects/claude-workspace/mcps/journal-mcp/dist/server.js" ]; then
    echo "✅ Journal MCP server available"
else
    echo "❌ Journal MCP server not found"
fi

echo "🏁 Validation complete!"
```

This comprehensive template provides everything needed to enable agent coordination in any project, with project-type specific configurations and automated setup scripts.