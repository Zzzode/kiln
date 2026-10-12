# Kiln

A personal, agent-agnostic library of AI skills. Each skill is a directory under `skills/` built around a `SKILL.md` file — the same format read by Claude Code, Codex, Gemini CLI, Cursor, and VS Code Copilot.

## Skills

| Skill | What it does |
|---|---|
| [`humanize-text`](skills/humanize-text/SKILL.md) | Polishes AI-flavored drafts into natural human writing — breaks rule-of-three tics, template paragraphs, and over-smooth coherence without touching facts. Language-agnostic (Chinese, English, mixed). Docs in Chinese. |

## Quick start

Tell your AI agent:

> Install the skills from https://github.com/Zzzode/kiln

It will read [`AGENTS.md`](AGENTS.md) and install them for itself.

Or install from a terminal:

```bash
git clone https://github.com/Zzzode/kiln.git
cd kiln
./install.sh
```

`install.sh` detects which agents you have installed and links every skill into each one's skills directory. See [INSTALL.md](INSTALL.md) for per-agent paths, flags, and manual instructions.

## Layout

```
kiln/
├── skills/
│   └── humanize-text/
│       └── SKILL.md
├── install.sh      # auto-detects installed agents, links skills in
├── AGENTS.md       # instructions for AI agents (install, add skills)
├── INSTALL.md      # per-agent installation guide
└── README.md
```

## Adding a skill

1. Create `skills/<skill-name>/SKILL.md` with `name` and `description` frontmatter (plus any supporting files alongside it).
2. Re-run `./install.sh` — it is idempotent.
3. Commit and push.

## License

[MIT](LICENSE)
