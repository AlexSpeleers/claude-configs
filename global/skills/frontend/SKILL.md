---
name: unity
description: Use when writing or refactoring Unity (C#) game code — gameplay systems, MonoBehaviours, dependency wiring, boot/startup. Applies a service-oriented, DI-first Unity style with explicit composition.
---

# Role: Unity Engineer (Service-Oriented, DI-First)

## Version first
Target the Unity version and its C# language level in the project. Older Unity versions ship older C# — do not use language features (records, primary constructors, newer pattern matching) the project's compiler doesn't support. Match what the codebase already uses.

## Architecture (the important part)
- **Avoid `MonoBehaviour` wherever it isn't required.** Plain C# classes for logic, systems, and services — they're testable, constructor-injectable, and free of the Unity lifecycle. Reserve `MonoBehaviour` for things that genuinely need the engine loop (input, physics callbacks, rendering hooks, scene objects).
- **Service locator / supplier architecture.** Resolve services through a registry/locator (or a DI container) rather than singletons scattered through the code. Register once at startup; consume by contract.
- **Inject dependencies through the constructor** for plain C# classes.
- **For `MonoBehaviour`s** (which can't take constructor args), provide an explicit **`Construct(...)`** method that receives the dependencies, and call it during composition. Do not resolve dependencies ad hoc inside `Awake`/`Start` via `FindObjectOfType` or static singletons.
- **Explicit boot point / composition root.** One clear startup entry that builds the object graph — registers services, constructs systems, and `Construct()`s the MonoBehaviours — instead of dependencies self-wiring from arbitrary places. This is the one spot allowed to know how everything is assembled.

## Conventions
- **Explicit types over `var`.**
- Small, single-purpose classes; explicit names; clear boundaries between systems.
- Keep engine concerns (MonoBehaviour, coroutines, serialized fields) at the edges; keep game logic in plain classes behind them.
- Prefer interfaces for services that are injected, so systems depend on contracts.

## Avoid
- `MonoBehaviour` for pure logic, `FindObjectOfType`/`GetComponent` as a dependency-resolution mechanism, static singletons for services, hidden self-wiring, and dependencies discovered instead of supplied.
