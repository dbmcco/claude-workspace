# Multi-Claude PRD Development Process

## Phase 1: Standards Review (Standards-Claude)

### CRITICAL INPUTS
- Raw product requirements/ideas
- @standards/prd-standards.md
- Overall project context and business objectives

### MANDATORY EXECUTION STEPS
1. **LOAD AND INTERNALIZE** all PRD standards completely before proceeding
2. **ANALYZE** input requirements for scope, complexity, and section boundaries
3. **CREATE** standards-compliant PRD outline with ALL required sections from standards
4. **BREAK DOWN** PRD into exactly 6-8 logical sections for parallel development
5. **DEFINE** clear section interfaces and minimize cross-dependencies

### REQUIRED OUTPUTS
- Standards-compliant PRD structure outline
- Section assignment plan with token-safe boundaries (max 8,000 tokens each)
- Standards compliance verification checklist
- Cross-reference requirements map

### QUALITY GATES - ALL MUST BE MET
- [ ] ALL PRD standards loaded and internalized
- [ ] Section breakdown respects logical boundaries AND token limits
- [ ] Standards requirements mapped to specific sections
- [ ] Section interfaces defined with minimal dependencies

---

## Phase 2: Section Development (Parallel Section-Claudes)

### CRITICAL INPUTS
- PRD standards document
- Overall PRD scope and business context  
- Specific section definition and requirements
- Interface requirements with other sections

### MANDATORY EXECUTION STEPS
1. **DEVELOP** assigned section content following ALL standards requirements
2. **ENSURE** complete consistency with overall PRD scope and objectives
3. **INCLUDE** every required element specified in standards for this section
4. **CREATE** all necessary cross-references to other sections
5. **VERIFY** section meets all quality requirements before completion

### REQUIRED OUTPUTS
- Complete section content meeting ALL standards requirements
- Standards compliance verification notes
- Cross-reference requirements documented
- Section quality checklist completed

### QUALITY GATES - ALL MUST BE MET
- [ ] Section meets EVERY content requirement from standards
- [ ] Standards compliance verified and documented
- [ ] Cross-references properly implemented
- [ ] Section interfaces respected and documented

---

## Phase 3: Challenge Review (Challenge-Claude)

### CRITICAL INPUTS
- Developed section content (ABSOLUTELY NO ACCESS TO original requirements)
- PRD standards document
- Section quality checklist

**CRITICAL INSTRUCTION**: You MUST NOT have access to original requirements. This ensures fresh perspective.
**CRITICAL INSTRUCTION**: You MUST NOT have access to original requirements. Your job is unbiased review.
**CRITICAL INSTRUCTION**: You MUST NOT have access to original requirements. Fresh eyes only.

### MANDATORY EXECUTION STEPS
1. **REVIEW** section with completely fresh perspective and no prior context
2. **CHALLENGE** all assumptions and identify potential gaps ruthlessly
3. **SUGGEST** specific improvements and enhancements with clear rationale
4. **VERIFY** complete standards compliance against standards document
5. **IDENTIFY** missing critical elements or logical inconsistencies

### REQUIRED OUTPUTS
- Enhanced section content with specific improvements
- Gap analysis with actionable recommendations
- Quality improvement suggestions with clear rationale
- Updated standards compliance verification

### QUALITY GATES - ALL MUST BE MET
- [ ] Fresh perspective improvements incorporated
- [ ] ALL gaps and weaknesses identified and addressed
- [ ] Quality enhancements implemented with clear rationale
- [ ] Standards compliance maintained throughout review

---

## Phase 4: Standards Cleanup (Polish-Claude)

### CRITICAL INPUTS
- Challenge-reviewed content from ALL sections
- PRD standards document
- Quality improvement notes from challenge phase

### MANDATORY EXECUTION STEPS
1. **VERIFY** complete compliance with ALL PRD standards across entire document
2. **ENSURE** consistent formatting, terminology, and style throughout
3. **VALIDATE** all cross-references and dependencies work correctly
4. **PERFORM** final comprehensive quality and completeness review
5. **GENERATE** final integrated PRD document meeting all standards

### REQUIRED OUTPUTS
- Final standards-compliant PRD document
- Comprehensive quality assurance report
- Complete standards compliance verification
- Final document ready for stakeholder approval

### QUALITY GATES - ALL MUST BE MET
- [ ] COMPLETE standards compliance verified across ALL sections
- [ ] Consistent formatting and style applied throughout
- [ ] ALL cross-references validated and working
- [ ] Final quality review passed with full documentation
- [ ] Document ready for stakeholder review and approval

---

## EXECUTION RULES

### INFORMATION ISOLATION - STRICTLY ENFORCE
- **Standards-Claude**: Raw requirements + standards + process context
- **Section-Claudes**: Standards + overall scope + specific section ONLY
- **Challenge-Claude**: Section content + standards ONLY (NO original requirements)
- **Polish-Claude**: All reviewed content + standards + formatting requirements

### SECTION SIZE LIMITS - NEVER EXCEED
- **Maximum**: 8,000 tokens per section
- **Target**: 5,000-6,000 tokens per section
- **Minimum**: 2,000 tokens per section

### CROSS-REFERENCE REQUIREMENTS
- Define clear section interfaces during standards review
- Maintain section boundary respect throughout development
- Validate ALL cross-references during polish phase