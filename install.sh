#!/usr/bin/env bash
# Link every skill in skills/ into the personal skills directories of
# installed AI agents. Idempotent. See INSTALL.md for the path table.
#
# Usage:
#   ./install.sh                 # auto-detect installed agents, link all skills
#   ./install.sh --agent claude  # only link for one agent (claude|codex|gemini|cursor|copilot)
#   ./install.sh --path DIR      # link into a custom directory
#   ./install.sh --unlink        # remove links previously created by this script
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$REPO_DIR/skills"

agent_dir() {
  case "$1" in
    claude)  echo "$HOME/.claude/skills" ;;
    codex)   echo "$HOME/.agents/skills" ;;
    gemini)  echo "$HOME/.gemini/skills" ;;
    cursor)  echo "$HOME/.cursor/skills" ;;
    copilot) echo "$HOME/.copilot/skills" ;;
    *) echo "unknown agent: $1" >&2; return 1 ;;
  esac
}

# An agent counts as installed if its config directory exists.
agent_installed() {
  case "$1" in
    claude)  [ -d "$HOME/.claude" ] ;;
    codex)   [ -d "$HOME/.codex" ] || [ -d "$HOME/.agents" ] ;;
    gemini)  [ -d "$HOME/.gemini" ] ;;
    cursor)  [ -d "$HOME/.cursor" ] ;;
    copilot) [ -d "$HOME/.copilot" ] || [ -d "$HOME/.config/github-copilot" ] ;;
    *) return 1 ;;
  esac
}

UNLINK=0
AGENT=""
CUSTOM_PATH=""
while [ $# -gt 0 ]; do
  case "$1" in
    --unlink) UNLINK=1; shift ;;
    --agent)  AGENT="${2:-}"; shift 2 ;;
    --path)   CUSTOM_PATH="${2:-}"; shift 2 ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done

# Resolve the list of target directories.
if [ -n "$CUSTOM_PATH" ]; then
  TARGETS=("$CUSTOM_PATH")
elif [ -n "$AGENT" ]; then
  TARGETS=("$(agent_dir "$AGENT")")
else
  TARGETS=()
  for a in claude codex gemini cursor copilot; do
    if agent_installed "$a"; then
      TARGETS+=("$(agent_dir "$a")")
    fi
  done
  # Vendor-neutral baseline: Codex native, fallback for most other agents.
  neutral="$HOME/.agents/skills"
  found=0
  for t in "${TARGETS[@]:-}"; do [ "$t" = "$neutral" ] && found=1; done
  [ "$found" -eq 0 ] && TARGETS+=("$neutral")
fi

if [ "$UNLINK" -eq 1 ]; then
  for target in "${TARGETS[@]}"; do
    [ -d "$target" ] || continue
    for link in "$target"/*; do
      [ -L "$link" ] || continue
      case "$(readlink "$link")" in
        "$SKILLS_DIR"/*) rm "$link"; echo "unlinked $link" ;;
      esac
    done
  done
  echo "done"
  exit 0
fi

for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  count=0
  for skill_dir in "$SKILLS_DIR"/*/; do
    [ -d "$skill_dir" ] || continue
    name="$(basename "$skill_dir")"
    dest="$target/$name"
    if [ -e "$dest" ] && [ ! -L "$dest" ]; then
      echo "warning: $dest exists and is not a symlink — skipping (back it up or remove it first)" >&2
      continue
    fi
    ln -sfn "$skill_dir" "$dest"
    count=$((count + 1))
  done
  echo "$target  ($count skill(s))"
done

echo "done"
