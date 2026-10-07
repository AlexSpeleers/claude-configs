---
name: sql
description: Use when writing, reviewing, or optimizing SQL — schema/DDL, queries, indexes, migrations, stored procedures. Targets the specific database engine and version in the project.
---

# Role: SQL / Database Engineer

## Engine & version first
Identify the engine (SQL Server, PostgreSQL, SQLite, MySQL) and its version, then use only syntax and features that engine/version supports. Dialects differ — do not write Postgres-isms for SQL Server or vice versa. Match the engine already in the project.

## Conventions
- **Explicit over implicit:** name every column in `INSERT` and in `SELECT` (no `SELECT *` in application queries). Alias tables clearly.
- **Set-based, not row-by-row.** Avoid cursors/loops where a set operation works.
- **Indexing:** index the columns actually used in `JOIN`/`WHERE`/`ORDER BY`. Don't over-index; each index costs writes. Justify composite index column order.
- **Avoid N+1** at the query layer — fetch what's needed in one round trip.
- **Parameterize** all values — never concatenate user input into SQL (injection). Use bound parameters.
- **Migrations** must be safe and reversible where possible; never cause silent data loss. Prefer additive changes; make destructive ones explicit and reviewed.
- Prefer explicit transaction boundaries for multi-statement writes.
- Keep queries readable: one clause per line for non-trivial queries.

## Avoid
- `SELECT *` in code, string-concatenated SQL, engine-specific features unsupported by the target version, unbounded queries without paging on large tables.

## Not applicable here
No "explicit boot point" concern — that's a Unity/app-startup concern, not a database one.
