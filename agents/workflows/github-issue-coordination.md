# GitHub Issue-Based Agent Coordination

## Overview
GitHub Issue-Based Agent Coordination uses GitHub's native issue tracking, labeling, and automation features to orchestrate multi-agent workflows, providing transparent collaboration and automated coordination through the GitHub API.

## Architecture Pattern

```mermaid
graph TD
    A[User Request] --> B[GitHub Issue Creation]
    B --> C[Issue Template Processing]
    C --> D[Automated Agent Assignment]
    D --> E[Agent Workflow Triggers]
    
    E --> F[@research-agent Branch]
    E --> G[@implementation-agent Branch]
    E --> H[@review-agent Branch]
    
    F --> I[Research PR]
    G --> J[Implementation PR]
    H --> K[Review PR]
    
    I --> L[Automated Integration]
    J --> L
    K --> L
    
    L --> M[Final Review & Merge]
    M --> N[Issue Auto-Close]
```

## GitHub Integration Components

### Issue Templates
Create specialized issue templates for agent coordination:

#### Multi-Agent Feature Template
```markdown
---
name: Multi-Agent Feature Development
about: Template for features requiring multiple specialized agents
title: '[FEATURE] '
labels: ['agent-coordination', 'feature', 'multi-agent']
assignees: []
---

## Feature Request
### Description
[Clear description of the feature to implement]

### Requirements
- [ ] User story definition
- [ ] Acceptance criteria
- [ ] Performance requirements
- [ ] Security considerations

### Agent Coordination
**Coordination Pattern**: [sequential/parallel/hybrid]
**Estimated Complexity**: [simple/moderate/complex]

### Agent Assignments (Auto-assigned based on requirements)
- [ ] **@research-agent**: Architectural analysis and planning
- [ ] **@implementation-agent**: TDD implementation
- [ ] **@review-agent**: Quality assurance and security review
- [ ] **@deployment-agent**: Production deployment

### Dependencies
**External Dependencies**: [List any external service dependencies]
**Internal Dependencies**: [List any internal system dependencies]
**MCP Requirements**: [List required MCP servers]

### Success Criteria
- [ ] All quality gates pass
- [ ] Performance targets met (<500ms response time)
- [ ] Security review approved
- [ ] Documentation updated
- [ ] Tests achieve >90% coverage

### Coordination Schedule
**Target Timeline**: [X days]
- Day 1: Research and analysis
- Day 2-3: Implementation
- Day 4: Review and testing
- Day 5: Deployment

### Agent Communication
Use this issue for:
- ✅ Status updates from agents
- ✅ Blocker escalation
- ✅ Integration coordination
- ✅ Context sharing between agents

---
**Coordination Issue**: This issue serves as the central coordination point for all agent activities.
```

#### Single-Agent Task Template
```markdown
---
name: Single-Agent Task
about: Template for tasks requiring a single specialized agent
title: '[TASK] '
labels: ['agent-task', 'single-agent']
assignees: []
---

## Task Description
[Clear description of the task]

### Agent Assignment
**Recommended Agent**: [based on task analysis]
**Reason**: [why this agent is optimal]

### Context Requirements
- [ ] Project documentation reviewed
- [ ] Dependencies identified
- [ ] Success criteria defined

### Deliverables
- [ ] [Specific deliverable 1]
- [ ] [Specific deliverable 2]
- [ ] Quality gates passed

### Success Criteria
[Specific, measurable success criteria]

---
**Agent Task**: This task will be handled by a single specialized agent.
```

### Label System
Implement comprehensive labeling for agent coordination:

```json
{
  "agent_labels": {
    "agent-coordination": "Overall coordination activities",
    "agent:research": "Research agent activities",
    "agent:implementation": "Implementation agent activities", 
    "agent:review": "Review agent activities",
    "agent:deployment": "Deployment agent activities",
    "agent:ui": "UI specialist activities",
    "agent:auth": "Authentication specialist activities",
    "agent:data": "Data specialist activities"
  },
  "workflow_labels": {
    "workflow:sequential": "Sequential workflow pattern",
    "workflow:parallel": "Parallel workflow pattern",
    "workflow:hybrid": "Hybrid workflow pattern"
  },
  "status_labels": {
    "status:planning": "In planning phase",
    "status:in-progress": "Work in progress",
    "status:review": "Under review",
    "status:blocked": "Blocked waiting for dependencies",
    "status:ready-to-merge": "Ready for final merge",
    "status:deployed": "Successfully deployed"
  },
  "priority_labels": {
    "priority:critical": "Critical priority",
    "priority:high": "High priority", 
    "priority:medium": "Medium priority",
    "priority:low": "Low priority"
  }
}
```

### GitHub Actions Integration

#### Agent Coordination Workflow
```yaml
# .github/workflows/agent-coordination.yml
name: Agent Coordination Workflow

on:
  issues:
    types: [opened, labeled]
  issue_comment:
    types: [created]

jobs:
  coordinate_agents:
    runs-on: ubuntu-latest
    if: contains(github.event.issue.labels.*.name, 'agent-coordination')
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
          
      - name: Parse agent requirements
        id: parse_requirements
        run: |
          echo "Parsing issue requirements for agent assignment"
          # Parse issue body to extract agent requirements
          node .github/scripts/parse-agent-requirements.js
          
      - name: Create agent branches
        run: |
          # Create feature branches for each assigned agent
          git checkout -b feature/${{ github.event.issue.number }}-research
          git push origin feature/${{ github.event.issue.number }}-research
          
      - name: Trigger agent workflows
        run: |
          # Trigger individual agent workflows based on assignments
          gh workflow run agent-research.yml -f issue_number=${{ github.event.issue.number }}
          
      - name: Update issue with coordination info
        run: |
          gh issue comment ${{ github.event.issue.number }} --body "
          ## Agent Coordination Initiated
          
          **Coordination ID**: coord-${{ github.event.issue.number }}
          **Pattern**: ${{ steps.parse_requirements.outputs.pattern }}
          **Agents Assigned**: ${{ steps.parse_requirements.outputs.agents }}
          
          ### Branches Created
          - \`feature/${{ github.event.issue.number }}-research\`
          - \`feature/${{ github.event.issue.number }}-implementation\`
          - \`feature/${{ github.event.issue.number }}-review\`
          
          ### Next Steps
          Agents will begin work according to the ${{ steps.parse_requirements.outputs.pattern }} pattern.
          "
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

#### Agent Status Tracking
```yaml
# .github/workflows/agent-status-tracking.yml
name: Agent Status Tracking

on:
  pull_request:
    types: [opened, synchronize, closed]
  workflow_run:
    workflows: ["Agent Research", "Agent Implementation", "Agent Review"]
    types: [completed]

jobs:
  update_coordination_status:
    runs-on: ubuntu-latest
    
    steps:
      - name: Extract issue number
        id: extract_issue
        run: |
          issue_number=$(echo "${{ github.event.pull_request.head.ref }}" | grep -o '[0-9]\+' | head -1)
          echo "issue_number=$issue_number" >> $GITHUB_OUTPUT
          
      - name: Update coordination status
        run: |
          # Update the coordination issue with current status
          coordination_status=$(node .github/scripts/calculate-coordination-status.js)
          
          gh issue comment ${{ steps.extract_issue.outputs.issue_number }} --body "
          ## Agent Status Update
          
          **Timestamp**: $(date -Iseconds)
          **Overall Progress**: $coordination_status
          
          ### Agent Status
          $(node .github/scripts/get-agent-status.js ${{ steps.extract_issue.outputs.issue_number }})
          
          ### Quality Gates
          $(node .github/scripts/get-quality-status.js ${{ steps.extract_issue.outputs.issue_number }})
          "
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Agent-Specific Workflows

#### Research Agent Workflow
```yaml
# .github/workflows/agent-research.yml
name: Agent Research

on:
  workflow_dispatch:
    inputs:
      issue_number:
        description: 'Issue number for coordination'
        required: true
        type: string

jobs:
  research_analysis:
    runs-on: ubuntu-latest
    
    steps:
      - name: Checkout code
        uses: actions/checkout@v3
        
      - name: Setup Claude Code Environment
        run: |
          # Setup MCP servers and dependencies
          npm install
          npm run setup:mcp-servers
          
      - name: Execute Research Agent
        run: |
          # Execute research agent with proper context
          claude --agent=research \
                 --issue=${{ github.event.inputs.issue_number }} \
                 --context=@./.claude/memories/workflows/agent-coordination.md \
                 --output=research-analysis.md
                 
      - name: Create Research PR
        run: |
          git checkout feature/${{ github.event.inputs.issue_number }}-research
          git add research-analysis.md
          git commit -m "Research: Analysis for issue #${{ github.event.inputs.issue_number }}"
          git push origin feature/${{ github.event.inputs.issue_number }}-research
          
          gh pr create \
            --title "Research: Analysis for #${{ github.event.inputs.issue_number }}" \
            --body "Research analysis completed by @research-agent" \
            --label "agent:research,status:ready-for-implementation" \
            --assignee "@implementation-agent"
            
      - name: Update coordination issue
        run: |
          gh issue comment ${{ github.event.inputs.issue_number }} --body "
          ✅ **Research Phase Complete**
          
          **Agent**: @research-agent
          **Deliverable**: Research analysis available in PR #$(gh pr list --search 'Research: Analysis for #${{ github.event.inputs.issue_number }}' --json number --jq '.[0].number')
          **Status**: Ready for implementation
          **Next**: @implementation-agent can begin work
          "
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

## Coordination Scripts

### Agent Requirements Parser
```javascript
// .github/scripts/parse-agent-requirements.js
const fs = require('fs');
const core = require('@actions/core');

function parseAgentRequirements(issueBody) {
  const requirements = {
    pattern: 'sequential', // default
    agents: [],
    complexity: 'moderate',
    mcpServers: []
  };
  
  // Parse coordination pattern
  const patternMatch = issueBody.match(/\*\*Coordination Pattern\*\*:\s*\[([^\]]+)\]/);
  if (patternMatch) {
    requirements.pattern = patternMatch[1];
  }
  
  // Parse complexity
  const complexityMatch = issueBody.match(/\*\*Estimated Complexity\*\*:\s*\[([^\]]+)\]/);
  if (complexityMatch) {
    requirements.complexity = complexityMatch[1];
  }
  
  // Parse agent assignments
  const agentMatches = issueBody.match(/- \[ \] \*\*@([^:]+)\*\*:/g);
  if (agentMatches) {
    requirements.agents = agentMatches.map(match => 
      match.match(/@([^:]+)/)[1]
    );
  }
  
  // Parse MCP requirements
  const mcpMatch = issueBody.match(/\*\*MCP Requirements\*\*:\s*\[([^\]]+)\]/);
  if (mcpMatch) {
    requirements.mcpServers = mcpMatch[1].split(',').map(s => s.trim());
  }
  
  return requirements;
}

// Execute parsing
const issueBody = process.env.GITHUB_EVENT_ISSUE_BODY || fs.readFileSync('/github/workflow/event.json', 'utf8');
const requirements = parseAgentRequirements(issueBody);

// Set outputs for GitHub Actions
core.setOutput('pattern', requirements.pattern);
core.setOutput('agents', requirements.agents.join(','));
core.setOutput('complexity', requirements.complexity);
core.setOutput('mcp_servers', requirements.mcpServers.join(','));

console.log('Agent requirements parsed:', requirements);
```

### Coordination Status Calculator
```javascript
// .github/scripts/calculate-coordination-status.js
const { Octokit } = require('@octokit/rest');

const octokit = new Octokit({
  auth: process.env.GITHUB_TOKEN
});

async function calculateCoordinationStatus(issueNumber) {
  const { data: issue } = await octokit.rest.issues.get({
    owner: process.env.GITHUB_REPOSITORY.split('/')[0],
    repo: process.env.GITHUB_REPOSITORY.split('/')[1],
    issue_number: issueNumber
  });
  
  // Get related PRs
  const { data: prs } = await octokit.rest.pulls.list({
    owner: process.env.GITHUB_REPOSITORY.split('/')[0],
    repo: process.env.GITHUB_REPOSITORY.split('/')[1],
    state: 'all'
  });
  
  const relatedPRs = prs.filter(pr => 
    pr.head.ref.includes(issueNumber.toString())
  );
  
  // Calculate status
  const totalAgents = issue.body.match(/- \[ \] \*\*@([^:]+)\*\*:/g)?.length || 0;
  const completedPRs = relatedPRs.filter(pr => pr.state === 'closed').length;
  const progressPercentage = totalAgents > 0 ? (completedPRs / totalAgents * 100).toFixed(0) : 0;
  
  return {
    overall_progress: `${progressPercentage}%`,
    total_agents: totalAgents,
    completed_agents: completedPRs,
    related_prs: relatedPRs.length,
    status: progressPercentage === '100' ? 'complete' : 'in_progress'
  };
}

// Execute if called directly
if (require.main === module) {
  const issueNumber = process.argv[2];
  calculateCoordinationStatus(issueNumber).then(status => {
    console.log(JSON.stringify(status, null, 2));
  });
}

module.exports = { calculateCoordinationStatus };
```

## MCP Integration for GitHub Coordination

### Journal MCP GitHub Integration
```typescript
// Enhanced journal logging for GitHub coordination
const logGitHubCoordination = async (coordinationData: {
  issue_number: number;
  pattern: string;
  agents: string[];
  progress: number;
}) => {
  await mcp__journal__log_agent_activity({
    agent_id: "@coordination-agent",
    task_description: `GitHub coordination for issue #${coordinationData.issue_number}`,
    reasoning: `Using ${coordinationData.pattern} pattern with ${coordinationData.agents.length} agents`,
    outcome: coordinationData.progress === 100 ? "completed" : "in_progress",
    evidence: {
      github_issue: coordinationData.issue_number,
      coordination_pattern: coordinationData.pattern,
      agents_involved: coordinationData.agents,
      progress_percentage: coordinationData.progress
    },
    context: `GitHub-native coordination workflow`,
    github_integration: true
  });
};
```

### Obsidian MCP Documentation Integration
```typescript
// Create coordination documentation in Obsidian vault
const documentGitHubCoordination = async (issueData: any) => {
  const coordinationNote = `
# Agent Coordination: Issue #${issueData.number}

## Overview
- **Title**: ${issueData.title}
- **Pattern**: ${issueData.coordination_pattern}
- **Status**: ${issueData.status}

## Agent Assignments
${issueData.agents.map(agent => `- **${agent}**: ${issueData.agent_status[agent]}`).join('\n')}

## GitHub Integration
- **Issue**: [#${issueData.number}](${issueData.html_url})
- **PRs**: ${issueData.related_prs.map(pr => `[#${pr.number}](${pr.html_url})`).join(', ')}

## Lessons Learned
${issueData.lessons_learned || 'To be updated upon completion'}

---
Tags: #agent-coordination #github-integration #${issueData.coordination_pattern}
`;

  await mcp__obsidian__create_note({
    notePath: `agent-coordination/github-issue-${issueData.number}.md`,
    title: `Agent Coordination: Issue #${issueData.number}`,
    content: coordinationNote,
    tags: ['agent-coordination', 'github-integration', issueData.coordination_pattern]
  });
};
```

## Success Metrics and Monitoring

### Coordination Effectiveness Dashboard
```json
{
  "github_coordination_metrics": {
    "issue_resolution_time": {
      "sequential_pattern": "3.2 days average",
      "parallel_pattern": "1.8 days average",
      "hybrid_pattern": "2.4 days average"
    },
    "agent_coordination_success": {
      "successful_handoffs": "94%",
      "blocked_workflows": "6%",
      "rework_required": "8%"
    },
    "github_integration_effectiveness": {
      "automated_status_updates": "98%",
      "pr_coordination_success": "92%",
      "issue_auto_close_rate": "89%"
    },
    "quality_metrics": {
      "first_time_deployment_success": "91%",
      "post_deployment_issues": "4%",
      "rollback_rate": "2%"
    }
  }
}
```

### Automated Reporting
```yaml
# .github/workflows/coordination-reporting.yml
name: Weekly Coordination Report

on:
  schedule:
    - cron: '0 9 * * 1' # Every Monday at 9 AM

jobs:
  generate_report:
    runs-on: ubuntu-latest
    
    steps:
      - name: Generate coordination metrics
        run: |
          node .github/scripts/generate-coordination-report.js
          
      - name: Create report issue
        run: |
          gh issue create \
            --title "Weekly Agent Coordination Report - $(date +%Y-%m-%d)" \
            --body-file coordination-report.md \
            --label "report,agent-coordination"
```

This GitHub Issue-Based Agent Coordination system provides transparent, automated, and efficient coordination of multi-agent workflows using GitHub's native features and API integration.