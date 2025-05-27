# Core Development Principles

1. **Test-Driven Development**: Always write tests before implementation code
2. **Modular Architecture**: Prefer small, focused modules over monolithic code  
3. **Quality Gates**: Ensure all tests pass and linting is clean before proceeding
4. **LLM-Driven Development**: Center workflow around LLM capabilities and limitations
5. **Granular Rules**: Keep rules/prompts very small and specialized (ticket-sized)
6. **Context Focus**: LLM should only interact with files related to current task scope
7. **No Mocks**: Avoid mocks in tests; use real implementations or fixtures
8. **Clean Code**: Prioritize simple, clean, maintainable solutions