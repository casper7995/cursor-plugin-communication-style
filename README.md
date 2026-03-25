# Communication Style (Cursor plugin)

**Repository:** [github.com/casper7995/cursor-plugin-communication-style](https://github.com/casper7995/cursor-plugin-communication-style)

On-demand **skill** and **subagent** that incrementally mine `~/.cursor/projects/<workspace-slug>/agent-transcripts/*.jsonl` and merge stable preferences into **user-level** rules so they apply in **every project**. **No stop hook.**

## Install (Marketplace)

If you installed this from the Cursor Marketplace, the components load automatically. **Note:** Since the plugin loads the skill globally, do **not** also copy the skill manually into `~/.cursor/skills/` or you may see duplicate entries.

## Manual User-level Install (Local)

If you are pulling from this repo manually and want to install the components into your local `~/.cursor` tree instead of using a plugin link:

| Artifact | Target Path |
|----------|------|
| Base rule (you edit) | `~/.cursor/rules/communication-base.mdc` |
| Learned rule (skill updates) | `~/.cursor/rules/communication-learned.mdc` |
| Transcript index | `~/.cursor/communication-style-index.json` |
| Skill | `~/.cursor/skills/communication-style/SKILL.md` |
| Subagent | `~/.cursor/agents/communication-style-refresh.md` |

The index is global: transcript paths are absolute, so one file tracks all workspaces.

**One-shot manual install:**

```bash
PLUGIN="/path/to/cursor-plugin-communication-style"
mkdir -p ~/.cursor/rules ~/.cursor/skills ~/.cursor/agents
cp -f "$PLUGIN/rules/"*.mdc ~/.cursor/rules/
cp -R "$PLUGIN/skills/communication-style" ~/.cursor/skills/
cp -f "$PLUGIN/agents/communication-style-refresh.md" ~/.cursor/agents/
```

Then **Developer: Reload Window**.

## Usage

Invoke **`/communication-style`** in Agent chat (if your build lists it), run the **communication-style-refresh** subagent, or ask the agent to follow the **communication-style** skill. Mining uses the **current workspace** only to find transcripts; **writes** always go to `~/.cursor/rules/` and `~/.cursor/communication-style-index.json`.

## Legacy project files

If you previously used `.cursor/rules/communication-*.mdc` or `.cursor/communication-style-index.json` in a repo, remove them to avoid conflicting duplicates, or migrate learned bullets by hand into `~/.cursor/rules/communication-learned.mdc`.
