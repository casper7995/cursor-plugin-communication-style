# Communication Style (Cursor plugin)

**Repository:** [github.com/casper7995/cursor-plugin-communication-style](https://github.com/casper7995/cursor-plugin-communication-style)

On-demand **skill** and **subagent** that incrementally mine **`*.jsonl`** under **every** `~/.cursor/projects/*/agent-transcripts/` and merge stable preferences into **user-level** rules so they apply in **every project**. **No stop hook.**

## Why this exists

Assistant output varies by model and by task: plans can be too vague or too heavy, and day-to-day replies may not match how *you* like to read (structure, density, headings, how risks and verification show up). Generic defaults help, but they are not *your* defaults.

This plugin closes part of that gap by turning **patterns from your real Cursor chats** into **always-on rules**—separate **base** standards you edit by hand and **learned** bullets the skill merges in when you refresh. You stay in control; nothing runs on a stop-hook cadence, so you refresh when it makes sense.

**Personalization:** Preferences are inferred from what you actually say and correct across sessions (explicit instructions and repeated feedback carry more weight than one-off rants). That makes the assistant’s writing and planning **steadier for you** without pretending every model is identical.

**Privacy:** Mining reads **local** Cursor transcript files on your machine under `~/.cursor/projects/.../agent-transcripts/`. Updates go to **`~/.cursor/rules/`** and a small **`~/.cursor/communication-style-index.json`** index. Do not commit secrets into chats; the skill is instructed to skip sensitive content.

## Install (Marketplace)

If you installed this from the Cursor Marketplace, the components load automatically. **Note:** Since the plugin loads the skill globally, do **not** also copy the skill manually into `~/.cursor/skills/` or you may see duplicate entries.

The plugin declares **`rules`**, **`skills`**, and **`agents`** in `plugin.json` (same pattern as other Cursor plugins). That registers **Communication (global)** in **Cursor Settings → Rules, Skills, Subagents** so it is visible alongside file-based rules under **`~/.cursor/rules/`**.

**Why Settings can look “empty”:** The **User → Rules** list is not the same as on-disk **`~/.cursor/rules/*.mdc`**. Cloud “User rules” you create with **+ New User Rule** live separately. Your **real** baseline and learned bullets should still live in **`~/.cursor/rules/`**; this plugin adds one **always-on** rule file (`rules/communication-user-global.mdc`) that points the Agent at those paths and shows up under the plugin’s rules.

## Manual User-level Install (Local)

If you are pulling from this repo manually and want to install the components into your local `~/.cursor` tree instead of using a plugin link:

| Artifact | Target Path |
|----------|------|
| Base rule (you edit) | `~/.cursor/rules/communication-base.mdc` (copy from **`templates/communication-base.mdc`**) |
| Learned rule (skill updates) | `~/.cursor/rules/communication-learned.mdc` (copy from **`templates/communication-learned.mdc`**, then run **`/communication-style`**) |
| Transcript index | `~/.cursor/communication-style-index.json` |
| Skill | Bundled with this plugin (also copy to `~/.cursor/skills/communication-style/` **only** if you are not loading the plugin) |
| Subagent | `~/.cursor/agents/communication-style-refresh.md` |

The index is global: transcript paths are absolute, so one file tracks all workspaces.

**Single source for the skill:** Use **either** the plugin (recommended) **or** a copy under `~/.cursor/skills/communication-style/` — **not both**, or **`/communication-style`** may appear twice.

**One-shot manual install (no plugin):**

```bash
PLUGIN="/path/to/cursor-plugin-communication-style"
mkdir -p ~/.cursor/rules ~/.cursor/skills ~/.cursor/agents
cp -f "$PLUGIN/templates/"*.mdc ~/.cursor/rules/
cp -R "$PLUGIN/skills/communication-style" ~/.cursor/skills/
cp -f "$PLUGIN/agents/communication-style-refresh.md" ~/.cursor/agents/
```

Then **Developer: Reload Window** and run **`/communication-style`** once to seed **`communication-learned.mdc`** from transcripts.

## Usage

Invoke **`/communication-style`** in Agent chat (if your build lists it), run the **communication-style-refresh** subagent, or ask the agent to follow the **communication-style** skill. Mining reads transcripts from **all** Cursor project folders under `~/.cursor/projects/`; **writes** always go to `~/.cursor/rules/` and `~/.cursor/communication-style-index.json`.

## Cursor Settings → User → Rules (optional)

- **Plugin rules:** With **`"rules": "./rules/"`** in `plugin.json`, **`communication-user-global.mdc`** should appear under this plugin in **Rules** (after **Developer: Reload Window**).
- **Disk rules:** **`~/.cursor/rules/communication-base.mdc`** and **`communication-learned.mdc`** may still apply to Agent even when the **User** rules panel looks empty.
- **Cloud user rules:** You can still add **New User Rule** with a one-line pointer if you want something only in the cloud list.

## Legacy project files

If you previously used `.cursor/rules/communication-*.mdc` or `.cursor/communication-style-index.json` in a repo, remove them to avoid conflicting duplicates, or migrate learned bullets by hand into `~/.cursor/rules/communication-learned.mdc`.
