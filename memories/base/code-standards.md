# Code Standards

## File Organization
- Always add 2-line file header comments starting with "ABOUTME: " for new files
- Use descriptive variable and function names
- Keep functions small and focused
- Write self-documenting code with clear intent

## TypeScript Standards
- **Strict Mode**: Use TypeScript strict mode with comprehensive type coverage
- **Type Safety**: Prefer types over any; use unknown for genuinely unknown data
- **Performance**: Target <500ms response times with monitoring
- **Error Handling**: Comprehensive error boundaries and validation

## Performance Standards
- **Response Times**: API endpoints <500ms, page loads <2s, queries <100ms
- **Monitoring**: Include performance tracking in all critical operations
- **Optimization**: Profile and optimize based on real metrics, not assumptions