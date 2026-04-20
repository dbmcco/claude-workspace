# Core Development Principles

1. **Test-Driven Development**: Always write tests before implementation code
2. **Modular Architecture**: Prefer small, focused modules over monolithic code  
3. **Performance-First**: Target <500ms response times with monitoring and optimization
4. **Quality Gates**: Ensure all tests pass and linting is clean before proceeding
5. **Type Safety**: Use TypeScript strict mode throughout with comprehensive type coverage
6. **LLM-Driven Development**: Center workflow around LLM capabilities and limitations
7. **Multi-Agent Coordination**: Enable parallel Claude agent deployment for complex tasks
8. **Granular Rules**: Keep rules/prompts very small and specialized (ticket-sized)
9. **Context Focus**: LLM should only interact with files related to current task scope
10. **No Mocks**: Avoid mocks in tests; use real implementations or fixtures
11. **Clean Code**: Prioritize simple, clean, maintainable solutions