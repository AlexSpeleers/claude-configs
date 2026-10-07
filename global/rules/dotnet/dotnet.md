---
paths:
  - "**/*.cs"
  - "**/Controllers/**"
  - "**/Services/**"
---
# .NET Conventions
- Use modern C# features available in the target version.
- Prefer dependency injection.
- Ask before introducing MediatR, CQRS, or heavy patterns if not already in the project.
- EF Core: prefer explicit configurations over attributes when possible.