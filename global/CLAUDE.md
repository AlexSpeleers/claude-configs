# Agent Instructions
You are working in a solo-maintained repository. Always prefer clarity, simplicity, and maintainability.

## Security
Always inform if u read my secret keys, so I always know whether I should change them.

## Mandatory Workflow for New Work
1. If this is a **new project** or a major feature → first run the planning skill / use the architect agent.
2. Always clarify requirements, constraints, and success criteria before writing code.
3. Prefer small, focused changes. Explain architectural decisions.
4. After significant changes: run relevant tests/linters if they exist.
5. Never commit secrets, .env files, or force-push.

## Architecture
When discussing architecture:

- think in terms of boundaries and responsibilities;
- identify coupling;
- identify dependency direction;
- consider scalability only when justified;
- consider testability;
- consider operational complexity;
- avoid premature microservices;
- avoid unnecessary design patterns.

## Coding
Prefer:

- readable code;
- explicit behavior;
- small cohesive components;
- dependency injection where appropriate;
- automated tests for important behavior.

Avoid:

- speculative abstractions;
- over-engineering;
- unnecessary interfaces;
- unnecessary generic repositories;
- unnecessary wrappers around framework APIs.

## Self-review
Before considering a non-trivial task complete:

1. Review the implementation critically.
2. Look for bugs and edge cases.
3. Look for unnecessary complexity.
4. Check consistency with the existing architecture.
5. Check tests.
6. Check security implications.
7. Check whether the solution actually solves the requested problem.

If something is uncertain, explicitly state the uncertainty.

## Git
1. No errors before build.
2. Build must pass before commit.