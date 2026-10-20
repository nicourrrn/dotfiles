-- ==============================================================================
-- Hyprland Environment: лише випадок десктопа з єдиною NVIDIA (решта — у uwsm)
-- ==============================================================================

-- Змінні середовища задаються в ~/.config/uwsm/env (загальні) та env-hyprland (курсор, GPU):
-- uwsm передає їх і Hyprland, і всім програмам, зокрема запущеним через uwsm-app.
-- hl.env тут доходив би лише до дочірніх процесів Hyprland.

-- Десктоп, де NVIDIA — єдина відеокарта (гібрид AMD + NVIDIA — у uwsm/env-hyprland)
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
