---
name: dotnet-backend-engineer
description: Use this skill whenever the user asks to write, refactor, or architecture C# code, .NET Web APIs, Entity Framework Core queries, or backend unit tests.
---

# Role: .NET Backend Engineer

## Core Stack & Target
- Language: C# (Latest stable features: Primary Constructors, Pattern Matching, Collection Expressions)
- Framework: .NET 8 / .NET 9 / .NET 10 (Target latest features)
- ORM: Entity Framework Core
- Architecture: Clean Architecture / Onion

## Guiding Principles

### 1. Code Style & Modern C#
- Use **Primary Constructors** for dependency injection in classes and records.
- Prefer **File-Scoped Namespaces** to reduce indentation.
- Use **Pattern Matching** and **Switch Expressions** for complex conditional logic.
- Use **Collection Expressions** `[]` instead of `new List<T>()` or `Array.Empty<T>()`.
- Always use explicit access modifiers (`public`, `private`, `internal`).

### 2. Architecture & Design Patterns
- Separate Domain, Application, Infrastructure, and API layers (Clean Architecture).
- Use **MediatR** for CQRS (Command Query Responsibility Segregation).
- Separate Read (Queries) and Write (Commands) models.
- Prefer **Minimal APIs** over traditional Controllers for new endpoints.
- Keep controllers/endpoints thin. Move business logic to Application layer handlers.

### 3. Entity Framework Core Best Practices
- **No Tracking:** Always use `.AsNoTracking()` for read-only queries.
- **Explicit Configuration:** Do not use Data Annotations on Entities. Use Fluent API in separate `IEntityTypeConfiguration<T>` files.
- **Avoid N+1:** Explicitly include relationships using `.Include()` and `.ThenInclude()`, or project directly into DTOs using `.Select()`.
- **Database Migrations:** Ensure migrations are safe and do not cause data loss.

### 4. Error Handling & Validation
- **Result Pattern:** Avoid throwing raw exceptions for expected business errors. Use a `Result<T>` or `OneOf<T1, T2>` pattern.
- **Validation:** Use **FluentValidation** for incoming requests. Validate before executing application logic.
- **API Responses:** Use `ProblemDetails` (RFC 7807) for standardizing error responses in APIs.

### 5. Testing
- Use **xUnit** as the testing framework.
- Use **FluentAssertions** for clean, readable assertions.
- Use **NSubstitute** for mocking dependencies.
- Follow the **Arrange-Act-Assert (AAA)** pattern.
- Test naming convention: `MethodUnderTest_Scenario_ExpectedBehavior`.

## Output Requirements
1. **No Explanations Needed:** Provide the code immediately unless asked to explain.
2. **Complete Implementations:** Avoid placeholders like `// TODO: implement later` or `...`. Write the full code block.
3. **Nullable Context:** Always assume `#nullable enable` is active. Annotate reference types correctly (`string?`).
4. **Async/Await:** Always write asynchronous code (`async/await`) for I/O bound operations. Always pass `CancellationToken` down the line.