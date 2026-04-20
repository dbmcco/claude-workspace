# LightForge Project Context

## Project Type: Micro-Application Development Company
- **Focus**: Single-purpose, back-office business applications
- **Stack**: Modern web technologies optimized for performance and maintainability
- **Architecture**: Composable micro-applications with central integration layer
- **Key Patterns**: Fixed-scope development, reusable components, enterprise security

## GitHub-Native TDD Automation (FIXED - June 10, 2025)

### ✅ Working Configuration
- **GitHub Actions**: Located at repo root `.github/workflows/` (moved from subdirectory)
- **Repository Permissions**: `default_workflow_permissions: "write"` for PR creation
- **Claude Workflow**: Simplified 7-step process matching MoneyCommand's proven pattern
- **Quality Scripts**: `quality:check` and `quality:fix` available from repo root
- **MCP Integration**: Full GitHub tools including `mcp__github__create_pull_request`

### Automation Workflow
1. Create GitHub Issue using TDD template
2. Mention @claude in issue description
3. Claude automatically implements with TDD cycle
4. Quality gates enforced (ESLint 0 warnings, >90% coverage, TypeScript strict)
5. PR created with "Fixes #XXX" format

### Commands (from repo root)
```bash
npm run quality:check    # All quality gates
npm run quality:fix      # Auto-fix issues
npm run test            # Tests with coverage
npm run build           # Production build
```

## Development Standards
- **Single-Purpose Focus**: Each application solves exactly one business function
- **Fixed Pricing Model**: Development must be predictable and scope-controlled
- **Enterprise Security**: Business-critical applications require robust security
- **Performance First**: Applications must be fast and reliable for business operations
- **Composable Design**: Applications integrate through standardized patterns
- **TDD Automation**: GitHub-native workflow with Claude automation

## Business Constraints
- **Fixed Budget**: $25K development budget drives architectural decisions
- **Support Model**: 1 hour/week maintenance requires highly maintainable code
- **Rebuild Cycle**: $10K rebuilds every few years require clean, documented codebases
- **Client Integration**: Must work with existing business systems and workflows

## Quality Requirements
- **Business-Critical Reliability**: Zero tolerance for data loss or corruption
- **User Experience**: Simple, intuitive interfaces for non-technical users
- **Integration Readiness**: Clean APIs for data warehouse and dashboard integration
- **Documentation**: Comprehensive documentation for handoff and future rebuilds
- **Automated Quality**: TDD-driven development with >90% test coverage enforcement