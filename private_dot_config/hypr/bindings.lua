-- ==============================================================================
-- Hyprland Keybindings (Vicinae + Kitty / Foot + Noctalia Native IPC)
-- ==============================================================================

local mod = "SUPER"

-- 1. Термінал та Мультиплексор (Kitty основний, Foot як fallback)
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("terminal-cwd"))
hl.bind(mod .. " + ALT + Return", hl.dsp.exec_cmd("kitty -e zellij || foot -e zellij"))

-- 2. Файлові менеджери (TUI Superfile / Yazi та GUI Thunar)
hl.bind(mod .. " + E", hl.dsp.exec_cmd("kitty -e spf || foot -e yazi"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("thunar"))

-- 3. Лаунчер додатків та Буфер обміну (Vicinae)
hl.bind(mod .. " + Space", hl.dsp.exec_cmd("vicinae open"))
hl.bind(mod .. " + SHIFT + V", hl.dsp.exec_cmd("vicinae open --extension clipboard"))
-- Запасний виклик лаунчера Noctalia
hl.bind(mod .. " + ALT + Space", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))

-- 4. Керування вікнами
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())

-- 5. Системні панелі Noctalia (Session Menu, Control Center, Notifications)
hl.bind(mod .. " + M",         hl.dsp.exec_cmd("noctalia msg panel-toggle session-menu"))
hl.bind(mod .. " + N",         hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd("noctalia msg panel-toggle notification-history"))

-- 6. Швидкі системні перемикачі Noctalia (Caffeine, Night Light, Power)
hl.bind(mod .. " + C", hl.dsp.exec_cmd("noctalia msg caffeine-toggle"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("noctalia msg nightlight-toggle"))

-- 7. Групування вікон (Tabs / Groups)
hl.bind(mod .. " + W", hl.dsp.group.toggle())
hl.bind("ALT + TAB", hl.dsp.group.next())
hl.bind(mod .. " + SHIFT + W", hl.dsp.group.lock())

-- 8. Scratchpad (Спеціальний робочий стіл)
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- 9. Фокус вікон (Стрілки)
hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- 10. Перемикання робочих столів 1-10
for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Перемикання робочих столів колесом миші
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- 11. Перетягування та зміна розміру вікон мишею
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- 12. Гучність та OSD (Нативно через Noctalia)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up 5"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("noctalia msg volume-mute"),   { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("noctalia msg mic-mute"),      { locked = true })

-- 13. Підсвічування дисплея та OSD (Нативно через Noctalia)
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("noctalia msg brightness-up current 5"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("noctalia msg brightness-down current 5"), { locked = true, repeating = true })

-- 14. Керування медіаплеєром (Нативно через Noctalia MPRIS)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("noctalia msg media next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia msg media play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("noctalia msg media play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("noctalia msg media previous"),   { locked = true })

-- 15. Скріншоти (Вбудований інструмент Noctalia)
hl.bind("Print",         hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd("noctalia msg screenshot-annotate"))
