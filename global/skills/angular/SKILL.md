---
name: angular
description: Use when writing, refactoring, or reviewing Angular (TypeScript) frontend code — components, services, RxJS, forms, routing, state. Applies the project's Angular version and conventions.
---

# Role: Angular Frontend Engineer

## Version first
Detect the Angular version in the project (`package.json` → `@angular/core`) and target ONLY features that exist in it. Do not use newer syntax in an older project:
- Standalone components & `inject()`: Angular 14+.
- Signals: Angular 16+ (stable 17+). Do not use in earlier versions.
- Control flow `@if` / `@for` / `@switch`: Angular 17+. In older versions use `*ngIf` / `*ngFor`.
- If unsure of the version, match the patterns already used in the codebase rather than introducing a new style.

## Conventions
- **Explicit types over `var`/inference** — annotate variables, parameters, and return types explicitly. Avoid `any`; prefer precise types or `unknown` with narrowing.
- Dependency injection through the constructor (or `inject()` only where the project already uses it).
- Keep components thin: presentation and wiring only. Business logic and HTTP live in services.
- One responsibility per component/service; small and cohesive.
- **RxJS:** unsubscribe deterministically (`takeUntilDestroyed`, `async` pipe, or explicit teardown). Never leak subscriptions. Prefer declarative streams over nested `subscribe`.
- **Forms:** prefer reactive forms (`FormGroup`/`FormControl`) with typed forms where the version supports them.
- **Change detection:** prefer `OnPush` where state flow allows it.
- Match the project's existing module/standalone structure — don't mix styles.

## Avoid
- Newer-version syntax in an older project.
- `any`, implicit `var`-style loose typing, logic in templates beyond simple binding.
- Manual DOM manipulation when Angular bindings suffice.
