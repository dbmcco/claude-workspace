# Multi-Claude Requirements Analysis Process

## Phase 1: Standards Review (Standards-Claude)

### CRITICAL INPUTS
- Business objectives and project context
- High-level feature descriptions or user needs
- @standards/prd-standards.md (for requirement structure)
- Existing system context and constraints

### MANDATORY EXECUTION STEPS
1. **APPLY** requirements documentation standards completely
2. **ANALYZE** business objectives for complete requirements scope
3. **IDENTIFY** functional domains for parallel analysis
4. **CREATE** comprehensive requirements framework
5. **PLAN** parallel requirements development strategy

### REQUIRED OUTPUTS
- Requirements document structure by functional domain
- Domain assignment plan with token-safe boundaries
- Requirements standards compliance framework
- Complete traceability matrix template

### REQUIRED REQUIREMENTS DOMAINS
1. **User Management & Authentication** - User accounts, roles, permissions
2. **Core Business Logic** - Primary functionality and business rules
3. **Data Management** - Data models, storage, and processing requirements
4. **Integration Requirements** - External systems and API specifications
5. **User Interface Requirements** - UI/UX specifications and interactions
6. **System Requirements** - Performance, security, and operational needs

### QUALITY GATES - ALL MUST BE MET
- [ ] ALL requirements standards understood and applied
- [ ] Functional domains clearly defined with NO overlap
- [ ] Domain boundaries support parallel development with token limits
- [ ] Complete traceability framework established

---

## Phase 2: Domain Analysis (Parallel Domain-Claudes)

### Input per Domain
- Requirements documentation standards
- Overall business objectives and project context
- Specific functional domain scope and boundaries
- Integration points with other domains
- Business rules and constraints for domain

### Process Steps
1. **Domain Deep-Dive**: Analyze specific functional domain in detail
2. **Stakeholder Mapping**: Identify users and stakeholders for domain
3. **Use Case Development**: Create detailed use cases and user stories
4. **Requirements Specification**: Define functional and non-functional requirements
5. **Acceptance Criteria**: Develop testable acceptance criteria for each requirement

### Output per Domain
- Comprehensive domain requirements specification
- Detailed use cases and user stories
- Functional and non-functional requirements with acceptance criteria
- Domain-specific business rules and constraints
- Integration requirements with other domains

### Quality Gates
- [ ] Domain requirements complete and well-specified
- [ ] Use cases cover all identified scenarios
- [ ] Requirements have clear, testable acceptance criteria
- [ ] Integration points clearly documented

---

## Phase 3: Challenge Review (Challenge-Claude)

### CRITICAL INPUTS
- Domain requirements specification (ABSOLUTELY NO ACCESS TO original business context)
- Requirements documentation standards
- Domain-specific quality checklists

**CRITICAL INSTRUCTION**: You MUST NOT have access to original business context. Fresh requirements review only.
**CRITICAL INSTRUCTION**: You MUST NOT have access to original business context. Unbiased validation required.
**CRITICAL INSTRUCTION**: You MUST NOT have access to original business context. Challenge all requirements ruthlessly.

### MANDATORY EXECUTION STEPS
1. **VALIDATE** requirements for completeness and clarity with fresh eyes
2. **IDENTIFY** missing requirements or edge cases ruthlessly
3. **VERIFY** internal consistency within domain
4. **CHALLENGE** requirements for technical and business feasibility
5. **SUGGEST** specific improvements and additional considerations

### Output Deliverables
- Enhanced requirements with identified gaps filled
- Feasibility analysis and risk assessment
- Requirements improvement recommendations
- Edge case and error condition requirements

### Quality Gates
- [ ] Requirements gaps identified and addressed
- [ ] Feasibility concerns raised and documented
- [ ] Edge cases and error conditions covered
- [ ] Requirements enhanced for clarity and completeness

---

## Phase 4: Integration & Standards Cleanup (Polish-Claude)

### Input Requirements
- All challenge-reviewed domain requirements
- Requirements documentation standards
- Business objectives and success criteria
- Integration and system-wide considerations

### Process Steps
1. **Domain Integration**: Ensure all domains integrate properly
2. **Consistency Verification**: Verify consistency across all domains
3. **Standards Compliance**: Apply final standards compliance check
4. **Traceability Completion**: Complete requirements traceability matrix
5. **Documentation Polish**: Final formatting and presentation cleanup

### Output Deliverables
- Complete integrated requirements specification
- Requirements traceability matrix linking business objectives to requirements
- Cross-domain integration requirements
- Final requirements compliance report

### Quality Gates
- [ ] All domains properly integrated
- [ ] Cross-domain consistency verified
- [ ] Complete traceability established
- [ ] Final requirements ready for development planning

---

## Requirements-Specific Guidelines

### Requirement Quality Criteria
- **Specific**: Requirements clearly define what must be accomplished
- **Measurable**: Success criteria are quantifiable and testable
- **Achievable**: Requirements are technically and economically feasible
- **Relevant**: Each requirement supports business objectives
- **Time-bound**: Requirements include appropriate timing considerations

### Requirement Categories
- **Functional Requirements (FR)**: What the system must do
- **Non-Functional Requirements (NFR)**: Quality attributes and constraints
- **Business Rules (BR)**: Policies and regulations that govern behavior
- **Data Requirements (DR)**: Information structure and management needs
- **Interface Requirements (IR)**: User interface and system integration needs

### Documentation Standards
- **Unique Identification**: Each requirement has unique ID and title
- **Clear Description**: Unambiguous statement of what is required
- **Acceptance Criteria**: Testable conditions for requirement completion
- **Priority Level**: Business priority (High/Medium/Low)
- **Source Traceability**: Link to business objective or stakeholder need

---

## Context Management for Requirements

### Information Distribution
- **Standards-Claude**: Business objectives + requirements standards + project context
- **Domain-Claudes**: Standards + overall objectives + specific domain scope
- **Challenge-Claude**: Domain requirements + standards (no original business context)
- **Polish-Claude**: All domain requirements + standards + integration needs

### Domain Size Guidelines
- **User Management**: 3,000-4,000 tokens (authentication, authorization, profiles)
- **Core Business Logic**: 5,000-7,000 tokens (primary functionality)
- **Data Management**: 4,000-6,000 tokens (models, storage, processing)
- **Integration**: 3,000-5,000 tokens (APIs, external systems)
- **User Interface**: 4,000-6,000 tokens (UI/UX specifications)
- **System Requirements**: 3,000-4,000 tokens (performance, security)

---

## Quality Assurance Framework

### Requirements Review Criteria
- **Completeness**: All necessary requirements identified
- **Clarity**: Requirements are unambiguous and understandable
- **Consistency**: No conflicting or contradictory requirements
- **Testability**: All requirements have verifiable acceptance criteria
- **Traceability**: Clear links between business needs and requirements

### Validation Techniques
- **Stakeholder Review**: Requirements validated with business stakeholders
- **Technical Review**: Feasibility confirmed with technical team
- **Use Case Validation**: Requirements support all identified use cases
- **Acceptance Criteria Testing**: All criteria are measurable and testable

---

## Risk Management

### Common Requirements Risks
- **Scope Creep**: Uncontrolled expansion of requirements
- **Ambiguity**: Unclear or interpretable requirements
- **Missing Requirements**: Critical needs not identified
- **Conflicting Requirements**: Contradictory or competing needs
- **Unfeasible Requirements**: Technically or economically impossible

### Mitigation Strategies
- Challenge phase specifically reviews for scope and feasibility
- Standards enforcement ensures clarity and testability
- Cross-domain integration identifies conflicts and gaps
- Regular stakeholder validation throughout process

---

## Success Metrics

### Process Quality Indicators
- Domain analysis completed within token limits
- Challenge review identifies meaningful improvements
- Integration reveals and resolves cross-domain issues
- Final requirements support clear development planning

### Output Quality Measures
- Requirements completeness and coverage
- Clarity and testability of acceptance criteria
- Stakeholder satisfaction with requirement accuracy
- Development team confidence in implementation guidance