# PAIA Agent System Workflow

**Note**: This workflow has been migrated to a skill. Use the `processing-paia-tags` skill for @paia instruction processing. This file remains as reference documentation.

## Contextual Agent Instruction Processing

### Problem Statement
@paia tags embedded in notes throughout the vault represent actionable agent instructions that require contextual understanding, cross-referencing, and intelligent execution.

### Solution Architecture
**Two-Stage Pipeline**: Intelligent analysis followed by contextual execution
- **@paia-analyzer**: Finds, analyzes context, follows cross-references, prepares comprehensive action briefs
- **@paia-updater**: Executes action briefs with full context awareness

### Integration Points

#### 1. **Vault-Wide @paia Discovery**
@paia-analyzer performs comprehensive search across entire vault:
- Finds all @paia tags with surrounding context
- Analyzes note purpose and instruction clarity
- Follows cross-references to gather complete context
- Prepares structured backend data for execution

#### 2. **Cross-Reference Intelligence**
When @paia instructions reference other areas:
- **Link Following**: Reads referenced files completely using MCP functions
- **Context Synthesis**: Understands meeting, project, planning, research contexts
- **Dependency Mapping**: Identifies information needed from other sources
- **Comprehensive Briefing**: Compiles all context into actionable brief

#### 3. **Structured Backend Communication**
@paia-analyzer writes structured data for @paia-updater:
```json
{
  "paia_instruction_id": "unique_id",
  "source_note": "path/to/note.md",
  "instruction_text": "exact @paia command",
  "local_context": "surrounding note context",
  "referenced_areas": [/* cross-referenced content */],
  "action_type": "research|create|update|analyze|coordinate",
  "actionable_brief": "comprehensive instruction for updater"
}
```

#### 4. **Intelligent Execution**
@paia-updater processes action briefs with:
- **Context-Aware Execution**: Uses pre-gathered context for intelligent action
- **Quality Safeguards**: Maintains formatting, cross-references, consistency
- **Completion Tracking**: Marks @paia instructions as completed with timestamps
- **Integration**: Updates related tracking systems and master lists

### Agent Capabilities

#### @paia-analyzer Specializations
- **Contextual Intelligence**: Understands note purpose and surrounding context
- **Cross-Reference Resolution**: Follows links and gathers referenced information
- **Scope Assessment**: Determines action complexity and requirements
- **Priority Assessment**: Evaluates urgency based on source context

#### @paia-updater Specializations
- **Research Actions**: Information gathering and synthesis across vault
- **Content Creation**: New notes, templates, summaries, action plans
- **Update Actions**: Note modifications, status updates, cross-reference maintenance
- **Analysis Actions**: Pattern analysis, gap identification, optimization recommendations

### Execution Pipeline

#### Stage 1: Analysis
```bash
Task("@paia-analyzer find all @paia instructions across vault, analyze context, follow cross-references, and prepare comprehensive action briefs")
```

#### Stage 2: Execution
```bash
Task("@paia-updater execute all action briefs from analyzer with full context awareness and completion tracking")
```

### Quality Standards

#### Analysis Quality
- **Complete Context**: Gather ALL referenced context before briefing
- **Clear Instructions**: Transform vague @paia tags into specific actionable briefs
- **Dependency Clarity**: Identify what updater needs to complete actions
- **Priority Assessment**: Determine urgency based on source context

#### Execution Quality  
- **Completeness**: Fully execute @paia instructions, no partial work
- **Context Consistency**: Ensure new/updated content fits existing context
- **Format Preservation**: Maintain note structures and formatting patterns
- **Cross-Reference Integrity**: Update related references when making changes

### Success Metrics
- **Discovery Rate**: 100% of @paia instructions found across vault
- **Context Completeness**: All cross-references analyzed and included in briefs
- **Execution Accuracy**: All briefs executed according to analyzed context
- **Integration Quality**: New/updated content seamlessly integrated with existing vault
- **Completion Tracking**: All @paia instructions marked complete with timestamps

### Error Handling

#### Analysis Stage
- **Broken References**: Report missing files/sections referenced by @paia
- **Unclear Instructions**: Flag ambiguous @paia commands for clarification
- **Access Issues**: Note areas that can't be accessed for context gathering

#### Execution Stage
- **Insufficient Context**: Request additional context if brief incomplete
- **Conflicting Instructions**: Flag contradictory @paia instructions
- **Resource Constraints**: Report when instructions require external resources

### Integration Benefits
- **Contextual Intelligence**: Instructions executed with full understanding of purpose and context
- **Cross-Vault Coordination**: @paia actions maintain consistency across related areas
- **Automated Completion**: Instructions tracked and marked complete automatically
- **Quality Assurance**: Execution maintains vault integrity and formatting standards

This sophisticated @paia system transforms embedded agent instructions into contextually intelligent actions that maintain vault consistency and achieve intended outcomes through comprehensive analysis and execution.