#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
HERDR_CONFIG_DIR="$HOME/.config/herdr"
HERDR_CONFIG="$HERDR_CONFIG_DIR/config.toml"
REVIEWR_CONFIG_DIR="$HERDR_CONFIG_DIR/plugins/config/persiyanov.reviewr"
case "$(uname -s)" in
  Darwin)
    GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
    ;;
  Linux)
    GHOSTTY_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
    ;;
  *)
    printf 'Unsupported operating system: %s\n' "$(uname -s)" >&2
    exit 1
    ;;
esac
GHOSTTY_CONFIG="$GHOSTTY_DIR/config.ghostty"
GHOSTY_SHADER="$GHOSTTY_DIR/shaders/ghosty-glass.glsl"

backup_and_link() {
  local source="$1" target="$2"
  mkdir -p "$(dirname "$target")"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    local backup="${target}.before-configurations.$(date +%Y%m%d%H%M%S)"
    mv "$target" "$backup"
    printf 'Backed up %s to %s\n' "$target" "$backup"
  fi
  ln -sfn "$source" "$target"
  printf 'Linked %s -> %s\n' "$target" "$source"
}

backup_and_link "$ROOT/herdr/config.toml" "$HERDR_CONFIG"
backup_and_link "$ROOT/ghosty/config.ghostty" "$GHOSTTY_CONFIG"
backup_and_link "$ROOT/ghosty/shaders/ghosty-glass.glsl" "$GHOSTY_SHADER"
mkdir -p "$REVIEWR_CONFIG_DIR"
backup_and_link "$ROOT/herdr/plugins/reviewr/config.toml" "$REVIEWR_CONFIG_DIR/config.toml"

if ! herdr plugin list 2>/dev/null | grep -q 'persiyanov.reviewr'; then
  herdr plugin install persiyanov/herdr-reviewr --yes
fi

if command -v codex >/dev/null 2>&1; then
  herdr integration install codex
else
  printf 'Codex was not found on PATH; install it, then run: herdr integration install codex\n' >&2
fi

herdr server reload-config 2>/dev/null || true
printf '\nConfiguration installed. Restart Ghostty, then run: herdr\n'
