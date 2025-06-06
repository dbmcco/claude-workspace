# Multi-Claude Architecture Development Process

## Phase 1: Standards Review (Standards-Claude)

### CRITICAL INPUTS
- Technical requirements and system constraints
- @standards/architecture-standards.md (when available)
- @standards/ux-standards.md (for UI architecture components)
- Business context and technical objectives

### MANDATORY EXECUTION STEPS
1. **LOAD AND INTERNALIZE** all architecture standards completely
2. **ANALYZE** technical requirements for architectural scope and complexity
3. **CREATE** standards-compliant architecture document outline
4. **IDENTIFY** major architectural components and clear boundaries
5. **ORGANIZE** architecture into exactly 6 logical sections for parallel development

### REQUIRED OUTPUTS
- Architecture document structure with component breakdown
- Section assignment plan with token-safe boundaries
- Architectural standards compliance checklist
- Component interface and dependency map

### REQUIRED ARCHITECTURE SECTIONS
1. **System Overview & Principles** - High-level architecture and design principles
2. **Component Architecture** - Major system components and their responsibilities
3. **Data Architecture** - Data models, storage, and flow patterns
4. **Integration Architecture** - External systems and API specifications
5. **Security Architecture** - Security patterns, authentication, and authorization
6. **Deployment Architecture** - Infrastructure, scaling, and operational considerations

### QUALITY GATES - ALL MUST BE MET
- [ ] ALL architecture standards loaded and internalized
- [ ] Component boundaries clearly defined with minimal coupling
- [ ] Section breakdown supports parallel development with token limits
- [ ] Architectural principles clearly established and documented

---

## Phase 2: Section Development (Parallel Section-Claudes)

### CRITICAL INPUTS
- Architecture standards and design principles
- Overall system context and technical requirements
- Specific architectural component scope and responsibilities
- Interface requirements with other components

### MANDATORY EXECUTION STEPS
1. **DESIGN** architectural component following ALL standards and principles
2. **DEFINE** clear interfaces with other system components
3. **SELECT** appropriate technologies within constraints with justification
4. **APPLY** established architectural patterns correctly
5. **DOCUMENT** all design decisions following standards

### REQUIRED OUTPUTS
- Detailed component architecture with clear interfaces
- Technology selection with complete rationale
- Architectural patterns and design decisions documented
- Component-specific quality and performance requirements

### QUALITY GATES - ALL MUST BE MET
- [ ] Component design follows ALL architectural principles
- [ ] Interfaces clearly defined and completely documented
- [ ] Technology choices fully justified and appropriate
- [ ] Architectural patterns correctly applied

---

## Phase 3: Challenge Review (Challenge-Claude)

### CRITICAL INPUTS
- Architectural component documentation (ABSOLUTELY NO ACCESS TO original requirements)
- Architecture standards and design principles
- Component quality checklists

**CRITICAL INSTRUCTION**: You MUST NOT have access to original requirements. Fresh architectural review only.
**CRITICAL INSTRUCTION**: You MUST NOT have access to original requirements. Unbiased design evaluation.
**CRITICAL INSTRUCTION**: You MUST NOT have access to original requirements. Challenge all assumptions.

### MANDATORY EXECUTION STEPS
1. **EVALUATE** architectural design for soundness and scalability ruthlessly
2. **VERIFY** architectural patterns are correctly applied
3. **ANALYZE** component interfaces for clarity and completeness
4. **CHALLENGE** technology choices and suggest specific alternatives
5. **IDENTIFY** potential architectural risks and issues

### REQUIRED OUTPUTS
- Enhanced architectural design with specific improvements
- Risk analysis with actionable mitigation recommendations
- Alternative technology considerations with rationale
- Interface and integration improvement suggestions

### QUALITY GATES - ALL MUST BE MET
- [ ] Architectural design validated for soundness and scalability
- [ ] ALL potential risks identified and addressed
- [ ] Interface designs improved for clarity
- [ ] Technology choices validated or enhanced with alternatives

---

## Phase 4: Standards Cleanup (Polish-Claude)

### Input Requirements
- All challenge-reviewed architectural components
- Architecture standards and documentation requirements
- System integration and deployment considerations
- Quality and performance requirements

### Process Steps
1. **Integration Verification**: Ensure all components integrate properly
2. **Standards Compliance**: Verify complete adherence to architecture standards
3. **Documentation Polish**: Clean up formatting, consistency, and completeness
4. **Decision Recording**: Document all architectural decisions and rationale
5. **Implementation Guidance**: Add implementation notes and development guidance

### Output Deliverables
- Complete integrated architecture document
- Architectural decision records (ADRs)
- Implementation guidance and development notes
- Architecture compliance verification report

### Quality Gates
- [ ] All components properly integrated
- [ ] Complete standards compliance verified
- [ ] Documentation clear and implementable
- [ ] Architectural decisions properly recorded

---

## Architecture-Specific Guidelines

### Component Boundary Principles
- **Single Responsibility**: Each component has one clear purpose
- **Loose Coupling**: Minimize dependencies between components
- **High Cohesion**: Related functionality grouped within components
- **Interface Clarity**: Clean, well-defined interfaces between components

### Technology Selection Criteria
- **Requirements Alignment**: Technology fits functional and non-functional requirements
- **Team Expertise**: Consider team knowledge and learning curve
- **Ecosystem Maturity**: Evaluate technology maturity and community support
- **Future Flexibility**: Consider evolution and migration paths

### Documentation Standards
- **Visual Diagrams**: Include system diagrams and component relationships
- **Decision Rationale**: Document why specific choices were made
- **Implementation Notes**: Provide guidance for development teams
- **Quality Attributes**: Specify performance, security, and reliability requirements

---

## Context Management for Architecture

### Information Flow
- **Standards-Claude**: Technical requirements + architecture standards + system context
- **Section-Claudes**: Standards + overall architecture + specific component scope
- **Challenge-Claude**: Component documentation + standards (no original requirements)
- **Polish-Claude**: All components + standards + integration requirements

### Section Size Guidelines
- **System Overview**: 3,000-4,000 tokens (high-level principles and patterns)
- **Component Architecture**: 4,000-6,000 tokens per major component
- **Data Architecture**: 4,000-5,000 tokens (models, storage, flow)
- **Integration Architecture**: 3,000-5,000 tokens (APIs, external systems)
- **Security Architecture**: 4,000-5,000 tokens (patterns, authentication)
- **Deployment Architecture**: 3,000-4,000 tokens (infrastructure, scaling)

---

## Quality Metrics and Success Criteria

### Architecture Quality Measures
- **Completeness**: All architectural concerns addressed
- **Consistency**: Consistent application of patterns and principles
- **Implementability**: Clear guidance for development teams
- **Scalability**: Architecture supports growth and change
- **Maintainability**: Design supports long-term maintenance

### Process Success Indicators
- Parallel development completed efficiently
- Challenge review identifies and resolves design issues
- Final architecture provides clear implementation roadmap
- Standards compliance achieved throughout document

---

## Risk Management

### Common Architecture Risks
- **Over-Engineering**: Excessive complexity for current requirements
- **Under-Engineering**: Insufficient consideration of future needs
- **Technology Lock-in**: Choices that limit future flexibility
- **Integration Complexity**: Overly complex component interactions

### Mitigation Strategies
- Challenge phase specifically reviews for over/under-engineering
- Technology choices evaluated for flexibility and alternatives
- Integration patterns kept as simple as possible
- Regular architecture review and evolution planned