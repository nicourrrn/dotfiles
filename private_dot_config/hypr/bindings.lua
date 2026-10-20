-- ==============================================================================
-- Hyprland Keybindings (спільні для всіх розкладок)
-- Philosophy: Vim home-row + macOS / Omarchy. Кожна дія — одне сполучення.
-- Бінди, специфічні для розкладки, живуть у scrolling.lua / dwindle.lua.
-- Перелік з описами: `hyprctl binds`
-- ==============================================================================

local mod = "SUPER"

local function bind(key, action, description, opts)
  local options = { description = description }
  for k, v in pairs(opts or {}) do options[k] = v end
  hl.bind(key, action, options)
end

local noctalia = function(cmd) return hl.dsp.exec_cmd("noctalia msg " .. cmd) end

-- ------------------------------------------------------------------------------
-- 1. Програми
-- ------------------------------------------------------------------------------
bind(mod .. " + Return",       hl.dsp.exec_cmd("terminal-cwd"),                 "Apps: Terminal in active window's directory")
bind(mod .. " + ALT + Return", hl.dsp.exec_cmd("zellij-pick"),    "Apps: Zellij session picker")
bind(mod .. " + E",            hl.dsp.exec_cmd("thunar"),                       "Apps: File manager")
bind(mod .. " + SHIFT + P",    hl.dsp.exec_cmd("keepassxc"),                    "Apps: KeePassXC")

-- Лаунчер і буфер обміну (Spotlight / Windows-style). Префікси в лаунчері: / — список
bind(mod .. " + Space",       noctalia("panel-toggle launcher"),        "Launcher: Noctalia")
bind(mod .. " + ALT + Space", noctalia("panel-toggle launcher /win"),   "Launcher: Open windows")
bind(mod .. " + V",           noctalia("panel-toggle clipboard"),       "Launcher: Clipboard history")

-- ------------------------------------------------------------------------------
-- 2. Стан вікна
-- ------------------------------------------------------------------------------
bind(mod .. " + Q",         hl.dsp.window.close(),                         "Window: Close")
bind(mod .. " + F",         hl.dsp.window.fullscreen({ action = "toggle" }), "Window: Fullscreen")
bind(mod .. " + T",         hl.dsp.window.float({ action = "toggle" }),    "Window: Toggle floating")
bind(mod .. " + SHIFT + T", hl.dsp.window.pin(),                           "Window: Pin floating window on all workspaces")

-- Перемикач вікон як Cmd+Tab: усі столи, порядок останнього використання.
-- Швидке Alt+Tab — попереднє вікно; тримаючи Alt, Tab / Shift+Tab ідуть далі по
-- знімку історії (інакше кожен фокус переставляв би її), відпускання Alt — вибір.
local switcher = { list = {}, index = 1 }

local function switcher_end()
  switcher.list = {}
  hl.dispatch(hl.dsp.submap("reset"))
end

local function switcher_step(step)
  if #switcher.list == 0 then
    for _, w in ipairs(hl.get_windows()) do
      if w.mapped and w.workspace and not w.workspace.special and w.focus_history_id >= 0 then
        switcher.list[#switcher.list + 1] = w
      end
    end
    if #switcher.list < 2 then switcher.list = {} return end
    table.sort(switcher.list, function(a, b) return a.focus_history_id < b.focus_history_id end)
    switcher.index = 1
    hl.dispatch(hl.dsp.submap("switcher"))
  end
  switcher.index = (switcher.index - 1 + step) % #switcher.list + 1
  hl.dispatch(hl.dsp.focus({ window = switcher.list[switcher.index] }))
end

bind("ALT + Tab",         function() switcher_step(1) end,  "Window: Switch to next recent")
bind("ALT + SHIFT + Tab", function() switcher_step(-1) end, "Window: Switch to previous recent")

hl.define_submap("switcher", function()
  bind("ALT + Tab",         function() switcher_step(1) end,  "Window: Switch to next recent", { repeating = true })
  bind("ALT + SHIFT + Tab", function() switcher_step(-1) end, "Window: Switch to previous recent", { repeating = true })
  bind("Escape",            switcher_end,                     "Window: Finish switching", { ignore_mods = true })
  -- Alt натиснуто до входу в submap: відпускання ловимо з тими ж прапорцями, що й hyprstack
  for _, key in ipairs({ "Alt_L", "Alt_R" }) do
    bind("ALT + " .. key, switcher_end, "Window: Finish switching",
      { release = true, ignore_mods = true, non_consuming = true, submap_universal = true, transparent = true })
  end
end)

-- Миша: перетягування та ресайз
bind(mod .. " + mouse:272", hl.dsp.window.drag(),   "Window: Drag",   { mouse = true })
bind(mod .. " + mouse:273", hl.dsp.window.resize(), "Window: Resize", { mouse = true })

-- ------------------------------------------------------------------------------
-- 3. Групи (вкладки)
-- ------------------------------------------------------------------------------
bind(mod .. " + G",         hl.dsp.group.toggle(), "Group: Toggle")
bind(mod .. " + SHIFT + G", hl.dsp.group.lock(),   "Group: Lock")
bind(mod .. " + ALT + Tab",         hl.dsp.group.next(), "Group: Next tab", { repeating = true })
bind(mod .. " + ALT + SHIFT + Tab", hl.dsp.group.prev(), "Group: Previous tab", { repeating = true })

-- ------------------------------------------------------------------------------
-- 4. Робочі столи та Scratchpad
-- ------------------------------------------------------------------------------
for i = 1, 10 do
  local key = i % 10
  bind(mod .. " + " .. key,         hl.dsp.focus({ workspace = i }),       "Workspace: Go to " .. i)
  bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }), "Workspace: Move window to " .. i)
end

-- Super+Tab — наступний непорожній стіл (Omarchy), Super+` — попередній відвіданий
bind(mod .. " + Tab",         hl.dsp.focus({ workspace = "e+1" }), "Workspace: Next occupied", { repeating = true })
bind(mod .. " + SHIFT + Tab", hl.dsp.focus({ workspace = "e-1" }), "Workspace: Previous occupied", { repeating = true })
bind(mod .. " + grave", function() hl.dispatch("workspace", "previous") end, "Workspace: Back and forth")

bind(mod .. " + S",         hl.dsp.workspace.toggle_special("magic"),            "Scratchpad: Toggle")
bind(mod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }), "Scratchpad: Move window")

-- Колесо: Super — робочі столи (Super+Shift — вікна, див. файл розкладки)
bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), "Workspace: Next (wheel)")
bind(mod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }), "Workspace: Previous (wheel)")

-- ------------------------------------------------------------------------------
-- 5. Сесія та панелі Noctalia
-- ------------------------------------------------------------------------------
bind(mod .. " + Escape",     noctalia("panel-toggle session"), "Session: Menu (lock, logout, reboot…)")
bind(mod .. " + CTRL + Q",   noctalia("session lock"),              "Session: Lock (macOS Ctrl+Cmd+Q)")
bind(mod .. " + N",          noctalia("panel-toggle control-center"),       "Panel: Control center")
bind(mod .. " + SHIFT + N",  noctalia("notification-dnd-toggle"),           "Toggle: Do not disturb")
bind(mod .. " + C",          noctalia("caffeine-toggle"),   "Toggle: Caffeine (no idle)")
bind(mod .. " + X",          noctalia("nightlight-toggle"), "Toggle: Night light")

-- ------------------------------------------------------------------------------
-- 6. Медіа, гучність, яскравість (працюють і на екрані блокування)
-- ------------------------------------------------------------------------------
local locked_rep = { locked = true, repeating = true }
bind("XF86AudioRaiseVolume",  noctalia("volume-up 5"),   "Media: Volume up", locked_rep)
bind("XF86AudioLowerVolume",  noctalia("volume-down 5"), "Media: Volume down", locked_rep)
bind("XF86AudioMute",         noctalia("volume-mute"),   "Media: Mute", { locked = true })
bind("XF86AudioMicMute",      noctalia("mic-mute"),      "Media: Mute microphone", { locked = true })
bind("XF86MonBrightnessUp",   noctalia("brightness-up current 5"),   "Media: Brightness up", locked_rep)
bind("XF86MonBrightnessDown", noctalia("brightness-down current 5"), "Media: Brightness down", locked_rep)
bind("XF86AudioNext",  noctalia("media next"),       "Media: Next track", { locked = true })
bind("XF86AudioPrev",  noctalia("media previous"),   "Media: Previous track", { locked = true })
bind("XF86AudioPlay",  noctalia("media play-pause"), "Media: Play / pause", { locked = true })
bind("XF86AudioPause", noctalia("media play-pause"), "Media: Play / pause", { locked = true })

-- ------------------------------------------------------------------------------
-- 7. Скріншоти
-- ------------------------------------------------------------------------------
bind("Print",           noctalia("screenshot-region"),     "Screenshot: Region")
bind("SHIFT + Print",   noctalia("screenshot-fullscreen"), "Screenshot: Monitor")
bind(mod .. " + Print", noctalia("screenshot-annotate"),   "Screenshot: Annotate")

return { bind = bind }
