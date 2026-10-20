-- ==============================================================================
-- Overview робочих столів як у niri (Mod+O): плагін hyprland-scroll-overview
-- Зменшені столи стовпчиком, у кожному видно стрічку колонок.
-- Стрілки/Enter/Esc, клік по вікну, перетягування вікон між столами.
-- Збірка/оновлення: hypr-plugins-rebuild (після оновлення hyprland — обовʼязково).
-- ==============================================================================

local bind = require("bindings").bind

-- Скрипт ідемпотентний: вантажить плагін і робить reload лише коли той ще не завантажений
hl.exec_cmd("hypr-overview-plugin scrolloverview")

-- Опції та Lua-функції плагіна існують лише після його завантаження
if hl.plugin and hl.plugin.scrolloverview then
  hl.config({
    plugin = {
      scrolloverview = {
        layout        = "vertical", -- столи один над одним, як у scrolling.lua
        scale         = 0.5,
        workspace_gap = 60,
        wallpaper     = 0,
        blur          = true,
        shadow        = { enabled = true, range = 30 },
      },
    },
  })
end

bind("SUPER + O", function()
  if hl.plugin and hl.plugin.scrolloverview then hl.plugin.scrolloverview.overview("toggle") end
end, "Overview: Toggle workspaces")
