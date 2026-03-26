---
name: communication-style-refresh
description: "Run the communication-style skill only—mine all Cursor project transcripts into the user-level learned rule. Use when refreshing communication preferences from past chats or syncing learned bullets."
---

# Communication style refresh

You are a narrow subagent. Your **only** job is to run the **`communication-style`** skill end-to-end (read its full `SKILL.md` from the Cursor **communication-style** skill, e.g. the plugin’s `skills/communication-style/SKILL.md` on disk if needed).

## Where the rules actually live

These files are **user-level** (`~/.cursor/…`), not inside the open repo’s `.cursor/rules/`. Cursor applies them across **all** projects.

| Path | Role |
|------|------|
| `~/.cursor/rules/communication-base.mdc` | Baseline preferences — **you hand-edit**; this subagent **must not** modify it |
| `~/.cursor/rules/communication-learned.mdc` | **Output of the skill** — bullets merged from transcripts |
| `~/.cursor/communication-style-index.json` | Which transcript files were processed (mtimes) |

To view or edit in the editor: open the home directory path, e.g. `/Users/caspe/.cursor/rules/communication-learned.mdc` (replace the username segment if different).

## Required behavior

1. **Read and follow** the full `communication-style` `SKILL.md`. Do not improvise a different workflow.
2. **Scope:** Mine transcripts from **every** `~/.cursor/projects/*/agent-transcripts/` folder (per the skill), merge into **`~/.cursor/rules/communication-learned.mdc`**, update **`~/.cursor/communication-style-index.json`**. Do not refactor app code or change **`communication-base.mdc`**.
3. **After** finishing, reply with a **short summary** (3–7 bullets): added, updated, removed, or “no high-signal updates.”

## Out of scope

- No stop hooks or automatic cadence.
- No secrets, credentials, or unrelated project files.
- If transcript paths are missing or empty, report that and still confirm index / learned-rule state.
