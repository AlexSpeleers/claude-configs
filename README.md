# Claude configs

Version-controlled Claude Code configuration, split into global and per-project parts.
This repo is a plain store: nothing is synced automatically, files are copied by hand.

## Layout

```
global/                 -> mirrors ~/.claude
  CLAUDE.md             global instructions
  settings.json         global settings and permission rules
  statusline.ps1        status line script referenced by settings.json
  rules/                global rules
  agents/               custom agents
  skills/               custom skills
projects/
  _template/            starting point for a new project
    CLAUDE.md           -> <project root>/CLAUDE.md
    .claude/
      settings.json     -> <project root>/.claude/settings.json
      rules/            -> <project root>/.claude/rules/
```

## Global vs project

- **Global** holds what applies everywhere: coding style, workflow, the secret-file
  and destructive-command deny rules, the baseline allow rules.
- **Project** holds only what differs: stack, commands, project-specific rules and
  extra permission rules. Project settings are merged on top of the global ones;
  a deny rule at either level always wins.

## Adding a project

1. Copy `projects/_template` to `projects/<project-name>`.
2. Fill in `CLAUDE.md`, the rules and `settings.json`.
3. Copy the contents into the project's root folder.

## Not tracked

`.credentials.json`, `.env*` and `settings.local.json` files are ignored on purpose.
`global/settings.json` contains absolute paths under `C:/Users/Alex`; adjust them on
another machine.
