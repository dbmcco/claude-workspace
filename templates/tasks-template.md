# {PROJECT_NAME} - Task Tracking

ABOUTME: Standardized task tracking and management for project coordination
ABOUTME: Integrated with project manager role for real-time status updates

## Active Tasks

### In Progress

*Currently active work items - limit to 1-2 tasks maximum*

#### Task: {CURRENT_TASK_NAME}
- **Status**: In Progress
- **Assigned**: {AGENT_OR_ROLE}
- **Started**: {DATE}
- **Description**: {CLEAR_TASK_DESCRIPTION}
- **Acceptance Criteria**:
  - [ ] {SPECIFIC_DELIVERABLE_1}
  - [ ] {SPECIFIC_DELIVERABLE_2}
  - [ ] {SPECIFIC_DELIVERABLE_3}
- **Next Action**: {IMMEDIATE_NEXT_STEP}
- **Blockers**: {NONE_OR_SPECIFIC_BLOCKER}
- **Estimated Completion**: {DATE_OR_TIMEFRAME}

### Ready to Start

*Clarified tasks ready for immediate work*

#### Task: {READY_TASK_NAME}
- **Status**: Ready
- **Priority**: {P1/P2/P3/P4}
- **Energy Level**: {HIGH/MEDIUM/LOW}
- **Context**: {@computer/@calls/@thinking/@errands/@waiting}
- **Time Estimate**: {REALISTIC_TIME_ESTIMATE}
- **Description**: {CLEAR_TASK_DESCRIPTION}
- **Acceptance Criteria**:
  - [ ] {SPECIFIC_DELIVERABLE_1}
  - [ ] {SPECIFIC_DELIVERABLE_2}
- **Dependencies**: {NONE_OR_PREREQUISITE_TASKS}
- **Why Now**: {BUSINESS_JUSTIFICATION}

### Needs Clarification

*Tasks requiring interview/refinement before work can begin*

#### Task: {UNCLEAR_TASK_NAME}
- **Status**: Needs Clarification
- **Original Request**: {VAGUE_REQUIREMENT}
- **Clarification Questions**:
  - What would 'done' look like specifically?
  - What's the very next physical action required?
  - Who else needs to be involved?
  - What information is needed first?
- **Interview Scheduled**: {DATE_OR_PENDING}
- **Clarity Score**: {1-5}/5
- **Actionability Score**: {1-5}/5

### Blocked/Waiting

*Tasks waiting on external dependencies or decisions*

#### Task: {BLOCKED_TASK_NAME}
- **Status**: Blocked
- **Blocked By**: {SPECIFIC_DEPENDENCY}
- **Blocking Since**: {DATE}
- **Follow-up Action**: {WHAT_TO_DO_NEXT}
- **Follow-up Date**: {WHEN_TO_CHECK}
- **Escalation Path**: {IF_STILL_BLOCKED}

## Completed Tasks

### This Week

#### ✅ Task: {COMPLETED_TASK_NAME}
- **Completed**: {DATE}
- **Delivered**: {WHAT_WAS_DELIVERED}
- **Quality Gates**: {PASS/FAIL_STATUS}
- **Lessons Learned**: {KEY_INSIGHTS}

### Last Week

*Recent completions for context and patterns*

## Task Management Processes

### Task Interview Framework

For vague or overwhelming tasks, apply systematic clarification:

**Phase 1: Assessment**
- Clarity Score (1-5): How specific is the outcome?
- Actionability Score (1-5): How clear is the next step?
- Relevance Score (1-5): How important is this really?
- Granularity Level: Project/Epic/Story/Task/Subtask

**Phase 2: Clarification Questions**
- For Vague Tasks: "What would 'done' look like specifically?"
- For Overwhelming Projects: "What are the 3 main outcomes you want?"
- For Stuck Tasks: "What's really blocking this?"
- For Scheduling: "How much energy does this require?"

**Phase 3: Transformation to Standard Format**
```
[VERB] [SPECIFIC OBJECT] [SUCCESS CRITERIA] [CONTEXT] [TIME ESTIMATE]

Examples:
- Email Diana about retirement planning options @calls 15min
- Draft partner outreach template using Clay data @computer 45min
- Review insurance options and make decision @thinking 30min
```

### Priority Assignment

**Priority Matrix:**
- **P1 (Do First)**: Important + Urgent + Clear next action
- **P2 (Schedule)**: Important + Not urgent + Actionable
- **P3 (Delegate/Simplify)**: Not important + Urgent
- **P4 (Eliminate)**: Not important + Not urgent

**Energy Level Matching:**
- **High Energy**: Complex problem-solving, creative work, difficult conversations
- **Medium Energy**: Routine execution, planning, organization
- **Low Energy**: Administrative tasks, reading, follow-ups

**Context Tags:**
- **@computer**: Focus work, writing, research, development
- **@calls**: Phone calls, video meetings, conversations
- **@thinking**: Planning, strategy, decision-making
- **@errands**: Out of office, physical world tasks
- **@waiting**: Blocked on others, follow-up items

### Sub-Agent Work Delegation

When delegating to specialized agents:

```bash
# Standard delegation pattern
Task("Task Name", "@agent_role specific work description")

# Examples
Task("Database Schema", "@architect design user authentication schema")
Task("API Tests", "@tdd write comprehensive API endpoint tests")
Task("Code Review", "@quality review authentication implementation")
Task("Git Commit", "@git commit authentication feature with tests")
```

### Quality Gates Integration

Every task must pass quality gates before completion:

**Technical Tasks:**
- [ ] All tests pass (npm test)
- [ ] Code coverage >90% (npm run test:coverage)
- [ ] No linting errors (npm run lint)
- [ ] TypeScript strict mode (npm run type-check)
- [ ] Production build successful (npm run build)

**Non-Technical Tasks:**
- [ ] Acceptance criteria met
- [ ] Deliverables reviewed
- [ ] Documentation updated
- [ ] Stakeholders notified

## Task Statistics

### Current Sprint Metrics
- **Total Active Tasks**: {COUNT}
- **Completed This Week**: {COUNT}
- **Average Completion Time**: {DAYS}
- **Quality Gate Pass Rate**: {PERCENTAGE}
- **Blocked Task Resolution Time**: {DAYS}

### Task Flow Health
- **Tasks Clarified/Week**: {COUNT}
- **Clarification Success Rate**: {PERCENTAGE}
- **Energy Level Distribution**: High {%} | Medium {%} | Low {%}
- **Context Distribution**: Computer {%} | Calls {%} | Thinking {%} | Other {%}

## Usage Notes

### For Project Managers
- Update task status in real-time as work progresses
- Use task interview system for requirement clarification
- Maintain no more than 1-2 active tasks to preserve focus
- Regular sync with project_status.md for milestone tracking

### For Sub-Agents
- Reference this file for task context and acceptance criteria
- Update progress and blockers immediately
- Flag quality gate failures for PM attention
- Document lessons learned for future tasks

### For Braydon
- Tasks are always actionable with clear next steps
- Provides visibility into project progress and bottlenecks
- Supports strategic decisions about priorities and resource allocation
- Integrated with project management role for consistent coordination