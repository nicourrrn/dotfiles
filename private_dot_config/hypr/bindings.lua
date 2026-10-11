-- ==============================================================================
-- Hyprland Keybindings (Vicinae + Kitty / Foot + Noctalia Native IPC)
-- Philosophy: Ergonomic Hybrid (Vim Home-Row + macOS / Raycast + i3 Tiling)
-- ==============================================================================

local mod = "SUPER"

-- ------------------------------------------------------------------------------
-- 1. Додатки та Емулятори термінала
-- ------------------------------------------------------------------------------
-- Розумний запуск термінала в CWD активного вікна (Kitty основний, Foot як fallback)
hl.bind(mod .. " + Return",       hl.dsp.exec_cmd("terminal-cwd"))
hl.bind(mod .. " + ALT + Return", hl.dsp.exec_cmd("kitty -e zellij || foot -e zellij"))

-- Файлові менеджери (TUI Superfile / Yazi та повноцінний GUI Thunar)
hl.bind(mod .. " + E",         hl.dsp.exec_cmd("kitty -e spf || foot -e yazi"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd("thunar"))

-- Лаунчер додатків та Буфер обміну (Vicinae Spotlight-style з підтримкою toggle)
hl.bind(mod .. " + Space",     hl.dsp.exec_cmd("vicinae toggle"))
hl.bind(mod .. " + SHIFT + V", hl.dsp.exec_cmd("vicinae toggle --extension clipboard || vicinae open --extension clipboard"))
-- Запасне відкриття лаунчера Noctalia
hl.bind(mod .. " + ALT + Space", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))

-- ------------------------------------------------------------------------------
-- 2. Життєвий цикл та стан вікна
-- ------------------------------------------------------------------------------
-- Закриття вікна (одноручне зручне Super+Q та сумісне Super+Shift+Q)
hl.bind(mod .. " + Q",         hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())

-- Режими відображення вікна
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + P", hl.dsp.window.pseudo())

-- Зміна орієнтації спліту Dwindle (горизонтальний / вертикальний поділ)
hl.bind(mod .. " + backslash", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + B",         hl.dsp.layout("togglesplit"))

-- ------------------------------------------------------------------------------
-- 3. Навігація, Переміщення та Зміна розмірів вікон (Vim HJKL + Стрілки)
-- ------------------------------------------------------------------------------
local directions = {
  h     = { dir = "left",  arg = "l", rx = "-30 0" },
  left  = { dir = "left",  arg = "l", rx = "-30 0" },
  l     = { dir = "right", arg = "r", rx = "30 0"  },
  right = { dir = "right", arg = "r", rx = "30 0"  },
  k     = { dir = "up",    arg = "u", rx = "0 -30" },
  up    = { dir = "up",    arg = "u", rx = "0 -30" },
  j     = { dir = "down",  arg = "d", rx = "0 30"  },
  down  = { dir = "down",  arg = "d", rx = "0 30"  },
}

for key, d in pairs(directions) do
  -- Фокус вікна (Vim-рухи без відриву рук від клавіатури)
  hl.bind(mod .. " + " .. key, hl.dsp.focus({ direction = d.dir }))

  -- Зсув / перестановка вікна в тайлі (Shift + HJKL / Стрілки)
  hl.bind(mod .. " + SHIFT + " .. key, function() hl.dispatch("movewindow", d.arg) end)

  -- Точна зміна розміру вікна з клавіатури (Alt + HJKL / Стрілки, крок 30px)
  hl.bind(mod .. " + ALT + " .. key, function() hl.dispatch("resizeactive", d.rx) end)
end

-- Перетягування та ресайз мишею
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ------------------------------------------------------------------------------
-- 4. Групування вікон та вкладки (Tabs / Groups)
-- ------------------------------------------------------------------------------
hl.bind(mod .. " + G",         hl.dsp.group.toggle())
hl.bind(mod .. " + W",         hl.dsp.group.toggle())
hl.bind("ALT + TAB",           hl.dsp.group.next())
hl.bind(mod .. " + TAB",       hl.dsp.group.next())
hl.bind(mod .. " + SHIFT + G", hl.dsp.group.lock())

-- ------------------------------------------------------------------------------
-- 5. Робочі столи (Workspaces) та Scratchpad
-- ------------------------------------------------------------------------------
-- Миттєве повернення на попередній робочий стіл (Back-and-forth через `~`)
hl.bind(mod .. " + grave", function() hl.dispatch("workspace", "previous") end)

-- Перемикання на столи 1-10 та перенесення вікон
for i = 1, 10 do
  local key = i % 10
  hl.bind(mod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Спеціальний робочий стіл (Scratchpad)
hl.bind(mod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Колесо миші для перемикання робочих столів
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- ------------------------------------------------------------------------------
-- 6. Панелі, Меню та Системні тригери Noctalia
-- ------------------------------------------------------------------------------
-- Системне меню сесії (Lock, Logout, Reboot, Shutdown)
hl.bind(mod .. " + M",         hl.dsp.exec_cmd("noctalia msg panel-toggle session-menu"))
-- Центр керування та швидких налаштувань
hl.bind(mod .. " + N",         hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
-- Історія сповіщень
hl.bind(mod .. " + SHIFT + N", hl.dsp.exec_cmd("noctalia msg panel-toggle notification-history"))

-- Швидкі тригери
hl.bind(mod .. " + C", hl.dsp.exec_cmd("noctalia msg caffeine-toggle"))
hl.bind(mod .. " + X", hl.dsp.exec_cmd("noctalia msg nightlight-toggle"))

-- ------------------------------------------------------------------------------
-- 7. Мультимедіа, Гучність та Яскравість (Noctalia OSD)
-- ------------------------------------------------------------------------------
-- Гучність та мікрофон
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up 5"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down 5"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("noctalia msg volume-mute"),   { locked = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("noctalia msg mic-mute"),      { locked = true })

-- Підсвічування дисплея
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("noctalia msg brightness-up current 5"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("noctalia msg brightness-down current 5"), { locked = true, repeating = true })

-- Керування медіаплеєром
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("noctalia msg media next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia msg media play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("noctalia msg media play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("noctalia msg media previous"),   { locked = true })

-- ------------------------------------------------------------------------------
-- 8. Скріншоти (Noctalia)
-- ------------------------------------------------------------------------------
hl.bind("Print",         hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("noctalia msg screenshot-fullscreen"))
hl.bind("SUPER + Print", hl.dsp.exec_cmd("noctalia msg screenshot-annotate"))
