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

`.credentials.json`, `.env*`, `settings.local.json` files are ignored on purpose.
`global/settings.json` contains absolute paths under `C:/Users/Alex`; adjust them on
another machine.

`settings.json` - doesn't litter into context window, it's just a config.
Кожна сесія — файл `.jsonl` у `~/.claude/projects/`, де кожне повідомлення це один JSON в одному рядку.
використання агентів - збільшує сумарну витрату токенів, але основне контекстне вікно розростається сильно повільніше.
`/btw` 
`/rewind` or `2 x ESC` in cli - mainly to revert last changes to previous message, but there is also an option to 
revert and preserve context (exp. not to repeate the same mistake/scenario)
`npx claude-safe .`