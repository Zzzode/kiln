#!/usr/bin/env bash
# Symlink every skill in skills/ into ~/.claude/skills/.
# Idempotent: re-running refreshes all links. Set CLAUDE_SKILLS_DIR to override the target.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$REPO_DIR/skills"
TARGET_DIR="${CLAUDE_SKILLS_DIR:-$HOME/.claude/skills}"

mkdir -p "$TARGET_DIR"

count=0
for skill_dir in "$SKILLS_DIR"/*/; do
  [ -d "$skill_dir" ] || continue
  name="$(basename "$skill_dir")"
  ln -sfn "$skill_dir" "$TARGET_DIR/$name"
  echo "linked  $name"
  count=$((count + 1))
done

echo "done — $count skill(s) linked into $TARGET_DIR"
