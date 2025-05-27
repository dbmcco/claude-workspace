# Healthcare Analytics Project Context

## Project Type: Healthcare Analytics Dashboard
- **Focus**: Multi-tenant analytics with strict data segregation
- **Stack**: Mixed (Python/JavaScript, SQL, visualization frameworks)
- **Architecture**: Multi-tier, agent-based coordination
- **Key Patterns**: Business-first development, security by design

## Development Standards
- **Security Review**: Required for all changes involving PHI
- **HIPAA Compliance**: All data handling must meet healthcare standards
- **Performance Requirements**: Sub-3 second dashboard loading times
- **Data Segregation**: Strict client data isolation
- **Business Documentation**: Requirements and architecture docs must stay current

## Stakeholder Focus
- Healthcare CIOs/CTOs need strategic insights and ROI justification
- IT Directors require system utilization and resource allocation guidance
- Financial Analysts need cost metrics and budget planning data
- HIM Staff require detailed usage metrics and compliance information

## Business Priorities
1. **Value Demonstration**: Clear ROI and cost justification metrics
2. **User Experience**: Intuitive dashboards for non-technical users
3. **Data Security**: Strict client data segregation
4. **Performance**: Sub-3 second dashboard loading times
5. **Flexibility**: Support for multiple report formats and deployment options

## Communication Protocol
- Update PROJECT_STATUS.md after completing major tasks
- Document decisions in DECISIONS.md
- Track blockers in BLOCKERS.md
- Use clear commit messages following conventional format

## File Naming Conventions
- Business docs: `BUSINESS_*.md`
- Technical docs: `TECHNICAL_*.md`
- User docs: `USER_*.md`
- Architecture: `ARCHITECTURE_*.md`