-- ==============================================================================
-- Hyprland Environment Variables (Dynamic GPU & Display Detection)
-- ==============================================================================

local home = os.getenv("HOME") or "/home/nicourrrn"
local current_path = os.getenv("PATH") or "/usr/local/bin:/usr/bin"

-- Шляхи пошуку бінарників
hl.env("PATH", home .. "/arch-custom-os/bin:" .. home .. "/.local/bin:" .. current_path)

-- Курсори та дефолтні додатки
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("EDITOR", "zeditor")
hl.env("TERMINAL", "foot")
-- Lua не розкриває $VAR у рядках: беремо шлях явно
hl.env("SSH_AUTH_SOCK", (os.getenv("XDG_RUNTIME_DIR") or "/run/user/1000") .. "/ssh-agent.socket")

-- Wayland & XDG стандарти для тулкітів
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- ------------------------------------------------------------------------------
-- Відеокарта. Гібрид AMD + NVIDIA налаштовано в ~/.config/uwsm/env-hyprland: uwsm передає
-- ті змінні всім програмам (hl.env сюди не доходить до запущених через uwsm-app).
-- Тут — лише випадок десктопа, де NVIDIA єдина відеокарта.
-- ------------------------------------------------------------------------------
local function check_cmd(cmd)
  local handle = io.popen(cmd .. " 2>/dev/null")
  if not handle then return false end
  local result = handle:read("*a")
  handle:close()
  return (result and #result > 0)
end

local nvidia_mod = io.open("/sys/module/nvidia_drm")
if nvidia_mod then nvidia_mod:close() end
local igpu = check_cmd("lspci | grep -iE '(vga|display).*(amd|ati|intel)'")

if nvidia_mod and not igpu then
  hl.env("LIBVA_DRIVER_NAME", "nvidia")
  hl.env("GBM_BACKEND", "nvidia-drm")
  hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
  hl.env("NVD_BACKEND", "direct")
  hl.config({ cursor = { no_hardware_cursors = true } }) -- без артефактів курсора на NVIDIA
end
