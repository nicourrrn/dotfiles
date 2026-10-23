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
- Other agents (any machine on the LAN) are reachable through ai-hub: `ai-msg peers` lists them, `ai-msg send <profile|key|project:NAME> "text"` sends. Incoming messages arrive by themselves in Claude Code (during a turn at its end, and an idle session is woken by them); in agy use `ai-msg inbox` / `ai-msg watch`. Reply to the key shown in brackets. To ask the person, `ai-msg send me "text"` (shows in the hub and notifies).
- Memory is shared by all agents through ai-hub (MCP server `memory`: mem_save, mem_search, mem_context, mem_get, mem_update, mem_delete). Records belong to the hub project of your working directory; facts about the person and rules for all projects go to scope "global". Search works by meaning in any language. Save decisions with their why, bug causes, conventions and gotchas right away; fix an outdated record with mem_update instead of saving a near-duplicate. The person reviews duplicates and stale records on the hub's «Пам'ять» page.
- Hub scenarios (scheduled jobs, Dagu-format DAGs): `ai-hub jobs list | runs <name> | log <name> [run] [step] | run <name> [k=v…]` — read their output there instead of asking the person to paste it.
- Agents of a project (role manager uses this): `ai-hub agent list | new --role R [--task ID] | resume <key> [--compact] [--prompt …] | close <key>`.

## Environment
- Arch Linux, Hyprland (Lua config), Noctalia shell, foot + zellij. Login shell bash, interactive fish; scripts are bash.
- Dotfiles: chezmoi in symlink mode, source ~/.local/share/chezmoi — edit the source, not the ~/.config symlink target.
- System repo: ~/arch-custom-os (manifest.toml, sys-sync, setup scripts).
- sudo needs a password: never run it yourself; give the user the exact command to run.
- Git remote gitea (192.168.10.115) is a home server that is sometimes off — a failed push is not an error to fix; report it.
- Commit only when asked; don't push to GitHub unless asked.
