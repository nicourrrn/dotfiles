-- ==============================================================================
-- Hyprland Keybindings (Vicinae + Kitty / Foot + Noctalia)
-- ==============================================================================

local mod = "SUPER"

-- 1. Термінал та Мультиплексор (Kitty основний, Foot як fallback)
hl.bind(mod .. " + Return", hl.dsp.exec_cmd("terminal-cwd"))
hl.bind(mod .. " + ALT + Return", hl.dsp.exec_cmd("kitty -e zellij || foot -e zellij"))

-- 2. Файлові менеджери (TUI Superfile / Yazi та GUI Thunar)
hl.bind(mod .. " + E", hl.dsp.exec_cmd("kitty -e spf || foot -e yazi"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("thunar"))

-- 3. Лаунчер додатків та Буфер обміну (Vicinae як головний)
hl.bind(mod .. " + Space", hl.dsp.exec_cmd("vicinae open"))
hl.bind(mod .. " + SHIFT + V", hl.dsp.exec_cmd("vicinae open --extension clipboard"))
-- Запасний виклик меню Noctalia
hl.bind(mod .. " + ALT + Space", hl.dsp.exec_cmd("noctalia toggle-launcher || noctalia"))

-- 4. Керування вікнами
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())
hl.bind(mod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

-- 5. Групування вікон (Tabs / Groups)
hl.bind(mod .. " + W", hl.dsp.group.toggle())
hl.bind("ALT + TAB", hl.dsp.group.next())
hl.bind(mod .. " + SHIFT + W", hl.dsp.group.lock())

-- 6. Scratchpad (Спеціальний робочий стіл)
hl.bind(mod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- 7. Фокус вікон (Стрілки)
hl.bind(mod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- 8. Перемикання робочих столів 1-10
for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Перемикання робочих столів колесом миші
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- 9. Перетягування та зміна розміру вікон мишею
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- 10. Мультимедійні клавіші та гучність (WirePlumber / wpctl)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- Підсвічування дисплея
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Керування медіаплеєром (playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- 11. Скріншоти (Hyprshot)
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region -o ~/Pictures/Screenshots/"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m window -o ~/Pictures/Screenshots/"))

