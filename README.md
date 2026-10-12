# Kiln

Personal collection of [Claude Code](https://claude.com/claude-code) skills.

Each skill is a self-contained directory under `skills/<name>/`, built around a `SKILL.md` with `name` and `description` frontmatter.

## Skills

| Skill | What it does |
|---|---|
| [`humanize-text`](skills/humanize-text/SKILL.md) | Polishes AI-flavored drafts into natural human writing — breaks rule-of-three tics, template paragraphs, and over-smooth coherence without touching facts. Language-agnostic (Chinese, English, mixed). |

## Install

Clone the repo and symlink every skill into `~/.claude/skills/`:

```bash
git clone https://github.com/Zzzode/kiln.git
cd kiln
./install.sh
```

Or install a single skill manually:

```bash
ln -s "$(pwd)/skills/humanize-text" ~/.claude/skills/humanize-text
```

## Layout

```
kiln/
├── skills/
│   └── humanize-text/
│       └── SKILL.md
├── install.sh
└── README.md
```

## Adding a skill

1. Create `skills/<skill-name>/SKILL.md` with `name` and `description` frontmatter (add supporting files alongside it if the skill needs them).
2. Re-run `./install.sh` — it is idempotent and refreshes all links.
3. Commit and push.

## License

[MIT](LICENSE)
