# Installation

Kiln skills use the standard `SKILL.md` format and work in any agent that reads it. Installation means placing each `skills/<name>/` directory where your agent looks for personal skills.

## Where each agent looks

| Agent | Personal skills directory | Also reads (fallback) |
|---|---|---|
| Claude Code | `~/.claude/skills/` | — |
| OpenAI Codex | `~/.agents/skills/` | — |
| Gemini CLI | `~/.gemini/skills/` | `~/.agents/skills/` |
| Cursor | `~/.cursor/skills/` | `~/.agents/skills/` |
| VS Code Copilot | `~/.copilot/skills/` | `~/.agents/skills/`, `~/.claude/skills/` |

The vendor-neutral `~/.agents/skills/` path covers Codex natively and most other agents as a fallback. If you only use Claude Code, `~/.claude/skills/` is enough.

## Automatic (macOS / Linux)

```bash
git clone https://github.com/Zzzode/kiln.git
cd kiln
./install.sh
```

The script links every skill into the directories of every agent it detects, plus `~/.agents/skills/` as the vendor-neutral baseline. Flags:

- `--agent <name>` — only install for one agent: `claude`, `codex`, `gemini`, `cursor`, `copilot`
- `--path <dir>` — link into a custom directory instead
- `--unlink` — remove the links this script created (it only touches symlinks that point into this clone)

Re-running is safe; links are refreshed with `ln -sfn`. If a target path already exists as a real directory (not a symlink), the script skips it and warns — back it up or remove it first.

## Manual

Replace `<target>` with the directory from the table above:

```bash
git clone https://github.com/Zzzode/kiln.git
ln -s "$(pwd)/kiln/skills/humanize-text" <target>/humanize-text
```

Windows: copy the directory, or use a junction (`mklink /J`).

## Let your AI do it

Paste this into any supported agent:

> Install the skills from https://github.com/Zzzode/kiln — read its AGENTS.md and follow it.

## Updating

```bash
cd kiln && git pull
```

Symlinks point into the clone, so a `git pull` updates every agent at once.

## Uninstall

```bash
./install.sh --unlink
rm -rf <the clone>
```
