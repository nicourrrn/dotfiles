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
hl.env("TERMINAL", "kitty")
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
-- Динамічне автовизначення відеокарти (GPU Detection)
-- ------------------------------------------------------------------------------
local function check_cmd(cmd)
  local handle = io.popen(cmd .. " 2>/dev/null")
  if not handle then return false end
  local result = handle:read("*a")
  handle:close()
  return (result and #result > 0)
end

local has_nvidia = check_cmd("lspci | grep -iE 'nvidia.*(vga|3d)'")

if has_nvidia then
  -- Дискретна графіка NVIDIA: бекенди та драйвери під Wayland
  hl.env("LIBVA_DRIVER_NAME", "nvidia")
  hl.env("GBM_BACKEND", "nvidia-drm")
  hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
  hl.env("NVD_BACKEND", "direct")

  -- Програмний курсор для запобігання артефактам/мерехтінню на драйверах NVIDIA
  hl.config({
    cursor = {
      no_hardware_cursors = true,
    },
  })
else
  -- Інтегрована графіка AMD або Intel (Mesa)
  local is_amd = check_cmd("lspci | grep -iE 'amd|ati.*(vga|3d)'")
  if is_amd then
    hl.env("LIBVA_DRIVER_NAME", "radeonsi")
    hl.env("VDPAU_DRIVER", "radeonsi")
  else
    hl.env("LIBVA_DRIVER_NAME", "iHD")
  end
end
