#!/usr/bin/env bash
# Cursor Settings → Rules, Skills, Subagents (User) lists skills from ~/.claude/skills/
# when "Include third-party Plugins, Skills, and other configs" is ON — same paths as Claude Code.
# A plugin under ~/.cursor/plugins/local/ alone does not show there until installed via Cursor Marketplace.
#
# Run once, then Developer: Reload Window in Cursor.
set -euo pipefail
PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
mkdir -p "${HOME}/.claude/skills/communication-style" "${HOME}/.claude/agents" "${HOME}/.cursor/agents"
SKILL_SRC="${PLUGIN_ROOT}/skills/communication-style/SKILL.md"
AGENT_SRC="${HOME}/.cursor/agents/communication-style-refresh.md"
if [[ ! -f "${SKILL_SRC}" ]]; then
  echo "error: missing ${SKILL_SRC}" >&2
  exit 1
fi
if [[ ! -f "${AGENT_SRC}" ]]; then
  echo "error: missing ${AGENT_SRC} (copy from plugin agents/ first)" >&2
  exit 1
fi
ln -sf "${SKILL_SRC}" "${HOME}/.claude/skills/communication-style/SKILL.md"
ln -sf "${AGENT_SRC}" "${HOME}/.claude/agents/communication-style-refresh.md"
echo "Linked:"
echo "  ~/.claude/skills/communication-style/SKILL.md -> ${SKILL_SRC}"
echo "  ~/.claude/agents/communication-style-refresh.md -> ${AGENT_SRC}"
echo "Reload Cursor (Developer: Reload Window)."
