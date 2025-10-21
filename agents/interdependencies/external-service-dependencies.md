# External Service Dependencies

## Overview
This document catalogs all external service dependencies required for agent coordination workflows, organized by service category and agent requirements.

## GitHub Integration Services

### GitHub API and Features
**Purpose**: Issue tracking, PR coordination, and automated workflows
**Status**: Critical for GitHub-based coordination patterns

#### Required GitHub Features
```markdown
## Core API Access
- **Issues API**: Creating, updating, and managing coordination issues
- **Pull Requests API**: PR creation, status tracking, and coordination
- **Actions API**: Workflow triggering and status monitoring
- **Labels API**: Automated labeling for agent coordination
- **Comments API**: Agent status updates and communication

## Required Permissions
- **Repository Access**: Full read/write access to project repositories
- **Actions Access**: Ability to trigger and monitor GitHub Actions
- **Issue Management**: Create, update, and close issues
- **PR Management**: Create, review, and merge pull requests
```

#### GitHub Actions Dependencies
```yaml
# Required GitHub Actions Marketplace Actions
actions_required:
  - actions/checkout@v3          # Code checkout for workflows
  - actions/setup-node@v3        # Node.js environment setup
  - actions/setup-python@v4      # Python environment setup (AI projects)
  - github/super-linter@v4       # Code quality enforcement

# Custom Actions for Agent Coordination
custom_actions:
  - .github/actions/agent-coordination    # Agent workflow orchestration
  - .github/actions/quality-gates        # Quality gate enforcement
  - .github/actions/mcp-setup           # MCP server initialization
```

#### External Dependencies
```markdown
## GitHub Service Requirements
- **GitHub Enterprise/Pro**: For private repositories and advanced features
- **GitHub Actions Minutes**: Sufficient action minutes for coordination workflows
- **GitHub API Rate Limits**: Account for API rate limiting in coordination scripts
- **Webhook Reliability**: Stable webhook delivery for real-time coordination

## Integration Requirements
- **Personal Access Tokens**: Fine-grained tokens for repository access
- **GitHub CLI**: gh command-line tool for script automation
- **GitHub Apps**: Optional - for enhanced security and permissions
```

### GitHub CLI (gh)
**Purpose**: Command-line automation for GitHub operations
**Status**: Critical for automated coordination

#### Installation Requirements
```bash
# macOS installation via Homebrew
brew install gh

# Verify installation
gh --version

# Authentication
gh auth login
gh auth status
```

#### Agent Usage Patterns
```bash
# Coordination Agent Usage
gh issue create --title "Agent Coordination: Feature X" --body-file coordination-template.md
gh issue comment 123 --body "Agent status update"
gh issue list --label "agent-coordination"

# Implementation Agent Usage  
gh pr create --title "Implementation: Feature X" --body "Implementation complete"
gh pr review 456 --approve
gh pr merge 456 --squash

# Review Agent Usage
gh pr review 456 --request-changes --body "Review feedback"
gh pr comment 456 --body "Quality gate status update"
```

## Development Tool Dependencies

### Node.js Ecosystem
**Purpose**: JavaScript/TypeScript development and tooling
**Status**: Critical for most projects

#### Version Requirements
```bash
# Required versions
node --version    # >= 16.0.0 (LTS recommended)
npm --version     # >= 8.0.0 (or yarn >= 1.22.0)

# Global packages required
npm install -g typescript     # TypeScript compiler
npm install -g eslint        # Code linting
npm install -g prettier      # Code formatting
```

#### Project Dependencies
```json
{
  "dependencies_by_project_type": {
    "personal_react": {
      "required": ["react", "typescript", "next.js"],
      "testing": ["jest", "@testing-library/react"],
      "quality": ["eslint", "prettier", "@typescript-eslint/parser"]
    },
    "work_healthcare": {
      "required": ["react", "typescript", "express", "prisma"],
      "security": ["helmet", "bcrypt", "jsonwebtoken"],
      "compliance": ["audit-trail", "encryption-libraries"]
    },
    "experiments_ai": {
      "required": ["typescript", "fastapi", "langchain"],
      "ai": ["openai", "@anthropic-ai/sdk"],
      "experimentation": ["jupyter", "mlflow"]
    }
  }
}
```

### Python Ecosystem (AI Projects)
**Purpose**: AI/ML development and experimentation
**Status**: Required for AI experiment projects

#### Version Requirements
```bash
# Required versions
python --version    # >= 3.9.0
pip --version      # >= 21.0.0

# Virtual environment management
python -m venv venv
source venv/bin/activate  # macOS/Linux
```

#### AI Framework Dependencies
```python
# requirements.txt for AI projects
langchain>=0.1.0
openai>=1.0.0
anthropic>=0.18.0
fastapi>=0.100.0
pydantic>=2.0.0
numpy>=1.24.0
pandas>=2.0.0
jupyter>=1.0.0
```

### Quality Assurance Tools
**Purpose**: Code quality enforcement and automated testing
**Status**: Critical for all projects

#### ESLint Configuration
```javascript
// .eslintrc.js - Required for all agents
module.exports = {
  extends: [
    '@typescript-eslint/recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended'
  ],
  rules: {
    '@typescript-eslint/no-unused-vars': 'error',
    '@typescript-eslint/no-explicit-any': 'error',
    'react-hooks/exhaustive-deps': 'error'
  },
  settings: {
    react: { version: 'detect' }
  }
};
```

#### TypeScript Configuration
```json
{
  "compilerOptions": {
    "strict": true,
    "noImplicitAny": true,
    "noImplicitReturns": true,
    "noUnusedLocals": true,
    "noUnusedParameters": true
  }
}
```

## Deployment and Hosting Services

### Vercel (Personal Projects)
**Purpose**: Frontend deployment and hosting
**Status**: Primary deployment platform for personal projects

#### Integration Requirements
```bash
# Vercel CLI installation
npm install -g vercel

# Authentication
vercel login

# Project setup
vercel --prod    # Production deployment
vercel --preview # Preview deployment
```

#### Configuration Dependencies
```json
{
  "vercel_requirements": {
    "build_settings": {
      "build_command": "npm run build",
      "output_directory": "dist",
      "install_command": "npm install"
    },
    "environment_variables": {
      "NODE_ENV": "production",
      "NEXT_PUBLIC_API_URL": "${API_URL}"
    },
    "domains": {
      "custom_domains": "Optional",
      "ssl_certificates": "Auto-managed"
    }
  }
}
```

### Netlify (Alternative Deployment)
**Purpose**: Alternative frontend deployment platform
**Status**: Secondary option for personal projects

#### Integration Requirements
```bash
# Netlify CLI installation
npm install -g netlify-cli

# Authentication
netlify login

# Site deployment
netlify deploy --prod
```

### Cloud Database Services
**Purpose**: Production database hosting
**Status**: Required for data-intensive projects

#### PostgreSQL (Supabase/Neon/PlanetScale)
```yaml
database_providers:
  supabase:
    purpose: "Full-stack backend with auth"
    pricing: "Free tier available"
    integration: "Direct PostgreSQL access"
    
  neon:
    purpose: "Serverless PostgreSQL"
    pricing: "Usage-based"
    integration: "Standard PostgreSQL driver"
    
  planetscale:
    purpose: "MySQL-compatible serverless"
    pricing: "Generous free tier"
    integration: "MySQL drivers with branching"
```

## AI and Machine Learning Services

### OpenAI API
**Purpose**: GPT model access for AI coordination and experiments
**Status**: Critical for AI experiment projects

#### API Requirements
```bash
# Environment setup
export OPENAI_API_KEY="sk-..."
export OPENAI_ORG_ID="org-..."

# Rate limiting considerations
OPENAI_RATE_LIMIT_REQUESTS_PER_MINUTE=60
OPENAI_RATE_LIMIT_TOKENS_PER_MINUTE=150000
```

#### Usage Patterns by Agent
```typescript
// Research Agent - Document analysis
const completion = await openai.chat.completions.create({
  model: "gpt-4",
  messages: [
    {
      role: "system", 
      content: "Analyze this codebase architecture..."
    },
    {
      role: "user",
      content: codebaseAnalysis
    }
  ],
  max_tokens: 2000
});

// Coordination Agent - Workflow planning
const planningCompletion = await openai.chat.completions.create({
  model: "gpt-3.5-turbo",
  messages: [
    {
      role: "system",
      content: "Create coordination plan for multi-agent workflow..."
    }
  ]
});
```

### Anthropic API
**Purpose**: Claude model access for agent coordination
**Status**: Primary AI service for agent workflows

#### API Configuration
```bash
# Environment setup
export ANTHROPIC_API_KEY="sk-ant-..."

# Rate limiting
ANTHROPIC_RATE_LIMIT_REQUESTS_PER_MINUTE=50
ANTHROPIC_RATE_LIMIT_TOKENS_PER_MINUTE=40000
```

### Monitoring and Analytics Services

#### Vercel Analytics
**Purpose**: Performance monitoring for deployed applications
**Status**: Recommended for personal projects

```javascript
// Analytics integration
import { Analytics } from '@vercel/analytics/react';

export default function App() {
  return (
    <>
      <MyApp />
      <Analytics />
    </>
  );
}
```

#### Sentry (Error Monitoring)
**Purpose**: Error tracking and performance monitoring
**Status**: Recommended for production applications

```javascript
// Sentry configuration
import * as Sentry from "@sentry/react";

Sentry.init({
  dsn: process.env.SENTRY_DSN,
  environment: process.env.NODE_ENV,
  tracesSampleRate: 1.0,
});
```

## Security and Compliance Services

### HIPAA-Compliant Services (Healthcare Projects)
**Purpose**: Healthcare data compliance and security
**Status**: Critical for healthcare analytics projects

#### AWS HIPAA Compliance
```yaml
aws_hipaa_services:
  compute:
    - EC2 (with HIPAA-eligible AMIs)
    - ECS (Fargate HIPAA-compliant)
    - Lambda (HIPAA-eligible)
  
  storage:
    - S3 (with encryption at rest)
    - RDS (encrypted instances)
    - DynamoDB (encryption enabled)
  
  security:
    - KMS (key management)
    - CloudTrail (audit logging)
    - WAF (web application firewall)
```

#### Security Scanning Services
```yaml
security_services:
  dependency_scanning:
    - Snyk (vulnerability scanning)
    - GitHub Dependabot (automated updates)
    - npm audit (built-in scanning)
  
  code_scanning:
    - SonarQube (static analysis)
    - CodeQL (semantic analysis)
    - ESLint Security Plugin
  
  runtime_scanning:
    - OWASP ZAP (penetration testing)
    - Burp Suite (security testing)
```

## Service Health Monitoring

### Dependency Health Checks
```typescript
// Service health monitoring
interface ServiceHealth {
  github_api: boolean;
  vercel_api: boolean;
  openai_api: boolean;
  anthropic_api: boolean;
  database: boolean;
}

async function checkServiceHealth(): Promise<ServiceHealth> {
  const health = {
    github_api: await checkGitHubAPI(),
    vercel_api: await checkVercelAPI(),
    openai_api: await checkOpenAIAPI(),
    anthropic_api: await checkAnthropicAPI(),
    database: await checkDatabase()
  };
  
  // Log health status
  await mcp__journal__log_agent_activity({
    agent_id: "@monitoring-agent",
    task_description: "Service health check",
    outcome: Object.values(health).every(Boolean) ? "healthy" : "degraded",
    evidence: health
  });
  
  return health;
}
```

### Automated Health Monitoring
```yaml
# .github/workflows/service-health.yml
name: Service Health Monitoring

on:
  schedule:
    - cron: '*/30 * * * *'  # Every 30 minutes
  workflow_dispatch:

jobs:
  health_check:
    runs-on: ubuntu-latest
    
    steps:
      - name: Check GitHub API
        run: |
          curl -f https://api.github.com/zen || echo "GitHub API unhealthy"
          
      - name: Check Vercel API  
        run: |
          curl -f https://api.vercel.com/v2/user \
            -H "Authorization: Bearer $VERCEL_TOKEN" || echo "Vercel API unhealthy"
        env:
          VERCEL_TOKEN: ${{ secrets.VERCEL_TOKEN }}
          
      - name: Check OpenAI API
        run: |
          curl -f https://api.openai.com/v1/models \
            -H "Authorization: Bearer $OPENAI_API_KEY" || echo "OpenAI API unhealthy"
        env:
          OPENAI_API_KEY: ${{ secrets.OPENAI_API_KEY }}
```

## Service Cost Management

### API Usage Monitoring
```typescript
// Cost tracking for API services
interface CostTracking {
  openai_tokens_used: number;
  anthropic_tokens_used: number;
  vercel_bandwidth: number;
  github_actions_minutes: number;
}

async function trackServiceCosts(): Promise<void> {
  const costs = await calculateServiceCosts();
  
  if (costs.monthly_total > COST_THRESHOLD) {
    await mcp__reminders__create_reminder({
      name: "Service costs exceeding threshold",
      listName: "Agent Coordination",
      dueDate: "01/16/2025 9:00 AM",
      priority: 1
    });
  }
}
```

### Cost Optimization Strategies
```markdown
## API Cost Optimization
- **Model Selection**: Use appropriate model sizes for tasks
- **Caching**: Cache frequent API responses
- **Rate Limiting**: Implement intelligent rate limiting
- **Batch Processing**: Group API calls when possible

## Infrastructure Cost Optimization
- **Serverless**: Use serverless functions for intermittent workloads
- **CDN**: Leverage CDNs for static asset delivery
- **Database Scaling**: Right-size database instances
- **Monitoring**: Set up cost alerts and budgets
```

This comprehensive documentation ensures all external service dependencies are properly understood, configured, and monitored for optimal agent coordination workflows.