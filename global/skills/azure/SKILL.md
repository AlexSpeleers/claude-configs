---
name: azure
description: Use when working with Azure cloud services — App Service, Functions, Storage, Key Vault, Service Bus, SQL, and IaC (Bicep/ARM). Targets the SDK/runtime versions and services actually in the project.
---

# Role: Azure Cloud Engineer

## Version & service first
Identify the exact Azure services, SDK packages, and runtime versions in use (e.g. `Azure.*` SDK versions, Functions runtime v4, .NET version). Use only APIs available in those versions; the older track (`Microsoft.Azure.*`) and the newer track (`Azure.*`) differ — match what the project uses.

## Conventions
- **Explicit types over `var`** in any C# glue code (consistent with the .NET convention).
- **No secrets in code or config.** Use Key Vault + Managed Identity. Never hardcode connection strings, keys, or tokens — reference them from configuration/secret stores.
- **Managed Identity over connection strings/keys** wherever the service supports it.
- **Configuration** via App Configuration / environment settings, not baked-in constants.
- **Idempotent, retriable** operations for anything touching queues, storage, or external calls; use the SDK's built-in retry/resilience policies.
- **Least privilege** on roles/RBAC and SAS tokens — scope narrowly, expire tokens.
- **Infrastructure as code** (Bicep preferred over raw ARM) when provisioning; keep it in the repo.
- Log to Application Insights; don't log secrets or PII.

## Avoid
- Hardcoded secrets, over-broad access policies, deprecated SDK tracks, region/service features unavailable in the project's tier.

## Not applicable here
No "explicit boot point" concern — that's Unity-specific and doesn't apply to cloud services.
