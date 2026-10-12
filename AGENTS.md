# AGENTS.md

Instructions for AI agents working with this repository. Humans: see [README.md](README.md) and [INSTALL.md](INSTALL.md).

## What this repo is

A skill library. Every directory under `skills/` is one skill: a `SKILL.md` (YAML frontmatter `name` + `description`, then Markdown instructions) plus optional supporting files. Skills are agent-agnostic — the same files work in Claude Code, Codex, Gemini CLI, Cursor, and VS Code Copilot.

## If the user asks you to install these skills

1. **Detect the agent.** If you are not sure which agent you are running in, ask the user — or install into the vendor-neutral path `~/.agents/skills/`, which Codex reads natively and most other agents read as a fallback.
2. **Get the repo.** Clone it to a stable location (e.g. `~/kiln` or `~/.agents/skills-repos/kiln`), or use an existing clone. Symlinks must keep working, so do not clone into a temp directory.
3. **Link each skill.** For every directory `skills/<name>/`, create a symlink in the target agent's personal skills directory:

   | Agent | Target directory |
   |---|---|
   | Claude Code | `~/.claude/skills/` |
   | OpenAI Codex | `~/.agents/skills/` |
   | Gemini CLI | `~/.gemini/skills/` (falls back to `~/.agents/skills/`) |
   | Cursor | `~/.cursor/skills/` (falls back to `~/.agents/skills/`) |
   | VS Code Copilot | `~/.copilot/skills/` |

   macOS/Linux:

   ```bash
   mkdir -p <target>
   ln -sfn <clone>/skills/<name> <target>/<name>
   ```

   Windows: copy the directory or use `mklink /J`.

   Or run `./install.sh` from the clone — it auto-detects installed agents and links all skills into each one.

4. **Safety check.** If `<target>/<name>` already exists as a real directory (not a symlink), do not overwrite it — warn the user and skip.
5. **Verify.** `<target>/<name>/SKILL.md` resolves to a readable file. If the agent loads skills only at startup, tell the user to restart it.
6. **Report.** List each skill and the path it was linked to. Do not modify anything under `skills/` during installation.

## If the user asks you to add or update a skill

- New skill: create `skills/<name>/SKILL.md` with `name` and `description` frontmatter; keep supporting files alongside it. The directory name is the skill name (kebab-case).
- Update: edit in place, then commit and push.
- After adding or renaming a skill, re-run `./install.sh` (or re-create the symlink).

## Conventions

- One concept, one skill directory.
- `SKILL.md` frontmatter is the contract: `name` (kebab-case, matches the directory) and `description` (when to trigger it).
- Do not add agent-specific files inside `skills/`; agent integration lives at the repo root.
