-- ==============================================================================
-- Hyprland Environment Variables
-- ==============================================================================

local home = os.getenv("HOME") or "/home/nicourrrn"
local current_path = os.getenv("PATH") or "/usr/local/bin:/usr/bin"

hl.env("PATH", home .. "/arch-custom-os/bin:" .. home .. "/.local/bin:" .. current_path)
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("EDITOR", "zeditor")
hl.env("TERMINAL", "kitty")
hl.env("SSH_AUTH_SOCK", "$XDG_RUNTIME_DIR/ssh-agent.socket")
