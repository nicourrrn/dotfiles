# Global rules for coding agents (Claude Code, Antigravity CLI)

Source of truth: ~/.config/ai/AGENTS.md (chezmoi). Claude imports it from ~/.claude/CLAUDE.md,
Antigravity reads it via the ~/.gemini/AGENTS.md symlink. Project rules live in each repo's AGENTS.md.

## Communication
- Reply in the user's language (usually Ukrainian). Code, commits, identifiers — English.
- Lead with the result. No preamble, no restating the request, no closing recap of what was just done.
- Don't repeat code or diffs already shown; reference `file:line`.
- Explain only non-obvious decisions, one line each. Expand when asked.
- Final report: what changed, what was verified (command → result), what's left or needs the user. Mark anything unverified.

## Work
- Smallest diff that solves the task. No unrequested refactors, files, or docs.
- Solution efficiency — stop at the first level that applies: skip (YAGNI) → reuse codebase → stdlib → native platform → installed dep → one line → minimum code. Never skip validation, security, error handling.
- Before multi-file changes: a 3–6 line plan. Ask only when a decision is ambiguous AND costly to reverse.
- Never claim done without running the relevant check (test, lint, build, or the actual command).
- Find the root cause before fixing; say how it was confirmed.
- Large feature in an existing codebase → OpenSpec change (proposal/design/tasks) before code.
- If the repo has backlog/ (Backlog.md): track work there via the `backlog` CLI — set In Progress when starting, Done when verified; link the OpenSpec change if any. The board is visible to the user on the ai-hub page.

## Environment
- Arch Linux, Hyprland (Lua config), Noctalia shell, foot + zellij. Login shell bash, interactive fish; scripts are bash.
- Dotfiles: chezmoi in symlink mode, source ~/.local/share/chezmoi — edit the source, not the ~/.config symlink target.
- System repo: ~/arch-custom-os (manifest.toml, sys-sync, setup scripts).
- sudo needs a password: never run it yourself; give the user the exact command to run.
- Git remote gitea (192.168.10.115) is a home server that is sometimes off — a failed push is not an error to fix; report it.
- Commit only when asked; don't push to GitHub unless asked.
