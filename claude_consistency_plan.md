# Pragmatic Claude Configuration Consistency Plan
*August 16, 2025*

## Executive Summary

This plan provides a **simple, direct approach** to achieving configuration consistency across projects without over-engineering. Focus: copy standard configurations to appropriate projects, ensuring consistent MCP access and settings.

**Timeline**: 1-2 days of focused work
**Risk**: Low (file copying with backups)
**Approach**: Direct file deployment, not architectural changes

## Current State Analysis

### Settings Files (30 active files)
- **Root/Parent levels**: Comprehensive settings serve as fallbacks - **KEEP AS-IS**
- **Standard development projects**: Need consistent dev tool permissions
- **Work/compliance projects**: Need restricted permissions for healthcare compliance  
- **Simple projects**: Need minimal configurations
- **MCP development projects**: Have specific MCP permissions - **KEEP AS-IS**

### MCP Configurations (22 active files)
- **All identical**: Standard configuration pointing to `/experiments/mcp/`
- **Missing in 8 projects**: Need MCP access added
- **MCPs stay in experiments/mcp/**: No architectural changes

### Key Insight
Most inconsistency comes from lack of standard configurations, not complex architecture problems. **Solution**: Create and deploy standard config files.

## Standard Configuration Files Created

### 1. settings-standard-dev.json
**For**: Most development projects
**Includes**: Standard dev tools (git, npm, node, python, pytest, gh, curl, etc.)
**Usage**: Personal projects, most work projects

### 2. settings-minimal.json  
**For**: Simple projects, documentation sites
**Includes**: Basic file operations, git, limited web access
**Usage**: Static sites, simple documentation projects

### 3. settings-work-compliance.json
**For**: Healthcare/compliance projects
**Includes**: Restricted permissions, no extensive bash commands
**Usage**: Navicyte, compliance-sensitive projects

### 4. mcp-standard.json
**For**: All projects needing MCP access
**Includes**: Obsidian, Reminders, Canva-dev MCPs
**Path**: Points to `/experiments/mcp/` (no changes to MCP locations)

### 5. Project Manager Standardization Templates
**For**: Complex projects requiring systematic task management
**Includes**: PM role CLAUDE.md, tasks.md, project_status.md templates
**Integration**: Memory imports for consistent PM behavior across projects

## Project Mapping

### Standard Development Projects → settings-standard-dev.json + mcp-standard.json
- `/Users/braydon/projects/personal/home_meal_planner`
- `/Users/braydon/projects/personal/moneycommand`
- `/Users/braydon/projects/personal/taskmgr`
- `/Users/braydon/projects/work/lfw/lfw-draftforge`
- `/Users/braydon/projects/work/lfw/lfw-website`
- `/Users/braydon/projects/work/lfw/lfw-forgeworks`
- `/Users/braydon/projects/work/lfw/lfw-marketing`
- `/Users/braydon/projects/work/resilience/resilience_py`

### Work/Compliance Projects → settings-work-compliance.json + mcp-standard.json
- `/Users/braydon/projects/work/navicyte`
- `/Users/braydon/projects/work/resilience/resilience_xls`

### Minimal Projects → settings-minimal.json + mcp-standard.json
- `/Users/braydon/projects/dbmcco.github.io`
- `/Users/braydon/projects/personal/paia`

### Keep Current Custom Configurations
- `/Users/braydon/projects` (root - comprehensive fallback)
- `/Users/braydon/projects/personal` (category - comprehensive fallback)
- `/Users/braydon/projects/experiments` (category - comprehensive fallback)
- `/Users/braydon/projects/work` (category - comprehensive fallback)
- `/Users/braydon/projects/experiments/mcp/obsidian_mcp` (MCP development)
- `/Users/braydon/projects/experiments/mcp/reminders_mcp` (MCP development)
- `/Users/braydon/projects/personal/home_next_up` (complex custom permissions)

## Implementation Plan

### Day 1: Deploy Standard Configurations

#### Step 1: Validate Standard Files (DONE)
✅ Created standard configuration files:
- `settings-standard-dev.json`
- `settings-minimal.json` 
- `settings-work-compliance.json`
- `mcp-standard.json`

#### Step 2: Deploy Configurations
```bash
# Run deployment script
./deploy-standard-configs.sh
```

**What it does**:
- Backs up existing files with timestamps
- Copies standard configs to mapped projects
- Adds MCP configurations where missing
- Preserves custom configurations

#### Step 3: Validate Deployment
```bash
# Run validation script
./validate-configs.sh
```

**What it checks**:
- JSON syntax validation
- MCP path verification
- Configuration completeness
- Summary statistics

### Day 2: Testing and Maintenance Setup

#### Step 4: Test Sample Projects
Test configurations in representative projects:
- Personal project: `home_meal_planner`
- Work project: `lfw-website` 
- Minimal project: `dbmcco.github.io`

#### Step 5: Setup Maintenance Tools
```bash
# Use maintenance tools for ongoing management
./maintenance-tools.sh audit        # Regular audits
./maintenance-tools.sh check-mcp    # MCP server health
./maintenance-tools.sh list-custom  # Track custom configs
```

## Implementation Tools

### 1. deploy-standard-configs.sh
- **Purpose**: Copy standard configs to appropriate projects
- **Safety**: Creates timestamped backups
- **Coverage**: Handles all mapped projects automatically

### 2. validate-configs.sh  
- **Purpose**: Validate JSON syntax and MCP paths
- **Checks**: File existence, JSON validity, MCP server availability
- **Output**: Summary statistics and error reporting

### 3. maintenance-tools.sh
- **Purpose**: Ongoing configuration management
- **Commands**: audit, sync, check-mcp, list-custom
- **Usage**: Regular maintenance and health checks

## What's NOT Changing

### MCP Servers
- **Stay in**: `/Users/braydon/projects/experiments/mcp/`
- **No movement**: No architectural changes to MCP locations
- **Configurations**: All point to existing experiment paths

### Custom Configurations
- **Root/Parent projects**: Keep comprehensive settings as fallbacks
- **MCP development projects**: Keep specialized permissions
- **Complex projects**: Keep custom settings if they serve a purpose

### Memory System  
- **No changes**: `@import` system unchanged
- **No templates**: No inheritance systems or complex architecture
- **No workspace changes**: Claude-workspace structure preserved

## Success Criteria

### Quantitative
- **Settings consistency**: Standard configs deployed to 15+ projects
- **MCP coverage**: All eligible projects have MCP configuration
- **File reduction**: Fewer unique configurations to maintain
- **Validation**: 100% of configs pass JSON validation

### Qualitative  
- **Maintainability**: Clear patterns for future projects
- **Consistency**: Similar projects have similar configurations
- **Simplicity**: No complex inheritance or template systems
- **Reliability**: All functionality preserved

## Rollback Plan

### If Issues Arise
1. **Restore backups**: All original files backed up with timestamps
2. **Stop deployment**: Scripts can be interrupted safely
3. **Validate restoration**: Use validation script to confirm rollback

### Backup Strategy
- **Automatic**: Scripts create timestamped backups before changes
- **Format**: `settings.local.json.backup.20250816_143022`
- **Location**: Same directory as original files

## Future Maintenance

### Adding New Projects
1. Determine project type (dev, minimal, compliance)
2. Copy appropriate standard configuration
3. Add MCP configuration if needed
4. Test and validate

### Updating Standard Configs
1. Modify standard files in `/Users/braydon/projects/`
2. Run `./maintenance-tools.sh sync` to update projects
3. Test and validate changes

### Regular Audits
- Run `./maintenance-tools.sh audit` monthly
- Check for configuration drift
- Update standard files as needed

## Why This Approach Works

### Simple and Direct
- **File copying**: Easy to understand and debug
- **No inheritance**: No complex template systems to maintain
- **Clear mapping**: Obvious which projects use which configs

### Low Risk
- **Backups**: All changes reversible
- **Incremental**: Can deploy to subset of projects first
- **Validation**: Tools check for issues before they cause problems

### Maintainable
- **Standard files**: Single source of truth for each config type
- **Tools**: Scripts handle routine tasks
- **Documentation**: Clear mapping and procedures

## Project Manager Role Standardization

### Overview

Based on the successful pattern from `/Users/braydon/projects/personal/taskmgr/`, standardize project management structure for complex projects requiring systematic coordination.

**Key Insight**: The taskmgr project demonstrates effective PM-only role with sub-agent delegation, task interview systems, and real-time status tracking. This pattern should be available as a standard option for appropriate projects.

### Project Manager Templates Created

#### 1. project-manager-claude.md
**Purpose**: Standard PM-only CLAUDE.md configuration
**Features**:
- Never codes directly - delegates all technical work to sub-agents
- Task interview system for requirement clarification
- Real-time task and status tracking integration
- Context preservation for Braydon strategic discussions

#### 2. tasks-template.md
**Purpose**: Structured task tracking and management
**Features**:
- Task interview framework integration
- Priority and energy level assignment
- Sub-agent work delegation patterns
- Quality gate integration

#### 3. project-status-template.md
**Purpose**: Strategic project overview and milestone tracking
**Features**:
- Executive summary for stakeholder communication
- Risk management and mitigation tracking
- Technical health and quality metrics
- Resource allocation and capacity planning

#### 4. project-manager-identity.md
**Purpose**: Consistent PM behavior memory
**Features**:
- PM-only operating instructions
- Sub-agent coordination patterns
- Task clarification frameworks
- Quality gate enforcement

### Project Manager Deployment Strategy

#### Eligible Projects (Complex Projects Requiring PM)
**Development Projects with Multiple Components:**
- `/Users/braydon/projects/personal/home_meal_planner` (multi-service architecture)
- `/Users/braydon/projects/personal/moneycommand` (complex financial data)
- `/Users/braydon/projects/work/lfw/lfw-draftforge` (LLM integration complexity)
- `/Users/braydon/projects/work/lfw/lfw-forgeworks` (multi-component platform)
- `/Users/braydon/projects/work/resilience/resilience_py` (healthcare compliance)

**Projects to Keep Current Setup:**
- `/Users/braydon/projects/personal/taskmgr` (reference implementation - already has PM structure)
- `/Users/braydon/projects/personal/home_next_up` (custom agent system)
- Simple projects (documentation sites, minimal tools)
- MCP development projects (specialized focus)

#### Deployment Approach
1. **Additive Implementation**: Add PM structure alongside existing configurations
2. **Preservation Strategy**: Keep existing CLAUDE.md files as CLAUDE-legacy.md backup
3. **Gradual Adoption**: Deploy to 1-2 projects first, validate, then expand
4. **Integration Option**: Projects can choose PM mode vs direct development mode

### PM Structure Integration Pattern

#### Directory Structure
```
{PROJECT_NAME}/
├── CLAUDE.md                     # PM configuration (from template)
├── CLAUDE-legacy.md              # Backup of original configuration
├── tasks.md                      # Real-time task tracking
├── project_status.md             # Strategic project overview
├── .claude/
│   └── memories/
│       └── project-manager-identity.md
└── [existing project files...]
```

#### Memory Import Pattern
```markdown
# In CLAUDE.md
@./.claude/memories/project-manager-identity.md
@./tasks.md
@./project_status.md
@../../../claude-workspace/memories/base/core-principles.md
```

### Implementation Tools

#### 1. deploy-pm-structure.sh
**Purpose**: Add PM structure to selected projects
**Features**:
- Creates .claude/memories/ directory structure
- Deploys customized template files
- Preserves existing CLAUDE.md as backup
- Initializes tasks.md and project_status.md with project-specific content

#### 2. validate-pm-deployment.sh
**Purpose**: Verify PM structure deployment
**Features**:
- Validates file existence and template customization
- Checks memory import syntax
- Confirms backup creation
- Tests basic PM functionality

#### 3. pm-maintenance-tools.sh
**Purpose**: Ongoing PM structure management
**Features**:
- Update templates across projects
- Validate PM role consistency
- Generate PM deployment reports
- Sync improvements to deployed projects

### Success Criteria

#### Quantitative Metrics
- **PM Structure Deployed**: 3-5 eligible projects receive PM standardization
- **Template Utilization**: tasks.md and project_status.md actively maintained
- **Quality Gate Compliance**: 100% pass rate on PM-managed projects
- **Task Clarification**: >90% of vague tasks successfully clarified using interview system

#### Qualitative Benefits
- **Consistent PM Behavior**: Standardized coordination approach across projects
- **Strategic Context Preservation**: Clear distinction between PM and technical work
- **Improved Task Management**: Systematic approach to requirement clarification
- **Enhanced Project Visibility**: Real-time status tracking for Braydon

### Integration with Existing Consistency Plan

#### Phase 1: Foundation (Existing Plan)
- Deploy standard settings and MCP configurations
- Establish consistent technical environments

#### Phase 2: PM Standardization (New Addition)
- Deploy PM structure to eligible complex projects
- Validate PM role effectiveness
- Refine templates based on real-world usage

#### Phase 3: Maintenance and Evolution
- Regular template updates
- PM structure adoption for new complex projects
- Continuous improvement based on project outcomes

This pragmatic approach achieves configuration consistency through simple file deployment rather than complex architectural changes. The focus is on practical results: consistent configurations across similar projects while preserving custom settings where they serve a purpose.

**NEW**: Project Manager standardization provides a systematic approach for complex projects requiring coordination while maintaining the direct development approach for simpler projects.