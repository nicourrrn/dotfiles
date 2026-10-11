-- ==============================================================================
-- Hyprland Master Configuration (Modular Lua Architecture)
-- Profile: arch-custom-os (Noctalia + Vicinae + Kitty)
-- ==============================================================================

-- Додаємо теку конфігурації Hyprland до шляхів пошуку модулів Lua
local config_dir = (os.getenv("HOME") or "") .. "/.config/hypr/"
package.path = config_dir .. "?.lua;" .. config_dir .. "?/init.lua;" .. package.path

-- Load modular components
require("env")
require("monitors")
require("input")
require("looknfeel")
require("bindings")
require("rules")
require("autostart")
