#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
SHARED_SKILL_DIR="$HOME/.agents/skills/herdr-delegation"
ROUTING_LINE='When the user asks for a subagent, delegation, or another coding agent, follow the `herdr-delegation` skill.'

mkdir -p "$HOME/.agents/skills" "$HOME/.codex/skills" "$HOME/.claude/skills"
if [ -d "$SHARED_SKILL_DIR" ] && [ ! -L "$SHARED_SKILL_DIR" ]; then
  if [ -f "$SHARED_SKILL_DIR/SKILL.md" ] && cmp -s "$ROOT/skills/herdr-delegation/SKILL.md" "$SHARED_SKILL_DIR/SKILL.md"; then
    rm "$SHARED_SKILL_DIR/SKILL.md"
    rmdir "$SHARED_SKILL_DIR"
  else
    printf 'Existing skill directory has local changes; move it before installing: %s\n' "$SHARED_SKILL_DIR" >&2
    exit 1
  fi
fi
ln -sfn "$ROOT/skills/herdr-delegation" "$SHARED_SKILL_DIR"
ln -sfn "../../.agents/skills/herdr-delegation" "$HOME/.codex/skills/herdr-delegation"
ln -sfn "../../.agents/skills/herdr-delegation" "$HOME/.claude/skills/herdr-delegation"

append_routing_line() {
  local target="$1"
  touch "$target"
  if ! grep -Fqx "$ROUTING_LINE" "$target"; then
    printf '\n%s\n' "$ROUTING_LINE" >> "$target"
  fi
}

append_routing_line "$HOME/.codex/AGENTS.md"
append_routing_line "$HOME/.claude/CLAUDE.md"

printf 'Installed shared Herdr delegation guidance for Codex and Claude.\n'
