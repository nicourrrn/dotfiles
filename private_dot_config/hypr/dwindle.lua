-- ==============================================================================
-- Hyprland Dwindle Layout (класичний тайлінг): налаштування та хоткеї
-- ==============================================================================

local bind = require("bindings").bind
local mod = "SUPER"

hl.config({
  general = { layout = "dwindle" },
  dwindle = { preserve_split = true },
})

-- 3 пальці горизонтально — робочі столи
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

bind(mod .. " + B", hl.dsp.layout("togglesplit"), "Dwindle: Toggle split direction")
bind(mod .. " + P", hl.dsp.window.pseudo(),       "Dwindle: Pseudo-tile")

local directions = {
  h = { dir = "left",  arg = "l", rx = "-30 0" }, left  = { dir = "left",  arg = "l", rx = "-30 0" },
  l = { dir = "right", arg = "r", rx = "30 0"  }, right = { dir = "right", arg = "r", rx = "30 0"  },
  k = { dir = "up",    arg = "u", rx = "0 -30" }, up    = { dir = "up",    arg = "u", rx = "0 -30" },
  j = { dir = "down",  arg = "d", rx = "0 30"  }, down  = { dir = "down",  arg = "d", rx = "0 30"  },
}

for key, d in pairs(directions) do
  bind(mod .. " + " .. key,           hl.dsp.focus({ direction = d.dir }),                  "Window: Focus " .. d.dir)
  bind(mod .. " + SHIFT + " .. key,   function() hl.dispatch("movewindow", d.arg) end,     "Window: Move " .. d.dir)
  bind(mod .. " + ALT + " .. key,     function() hl.dispatch("resizeactive", d.rx) end,    "Window: Resize " .. d.dir, { repeating = true })
end

-- Super+Shift+колесо — перебір вікон на столі
bind(mod .. " + SHIFT + mouse_down", hl.dsp.window.cycle_next(),                "Window: Next (wheel)")
bind(mod .. " + SHIFT + mouse_up",   hl.dsp.window.cycle_next({ next = false }), "Window: Previous (wheel)")
