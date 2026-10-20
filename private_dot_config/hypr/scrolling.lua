-- ==============================================================================
-- Hyprland Scrolling Layout (niri-style tape of columns): налаштування та хоткеї
-- Docs: https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
-- ==============================================================================

local bind = require("bindings").bind
local mod = "SUPER"

-- Браузери та «важкі» програми відкриваються на всю ширину, решта — половина екрана
local wide_apps = "(?i)^(zen(-browser)?|thorium.*|chromium.*|firefox|blender|godot|zed|dev\\.zed\\.Zed)$"

hl.config({
  general = { layout = "scrolling" },

  scrolling = {
    fullscreen_on_one_column = true,              -- одна колонка на столі — на весь екран; з другою повертаються звичайні ширини
    column_width             = 0.5,
    explicit_column_widths   = "0.333, 0.5, 0.667, 1.0", -- пресети для Super+R
    focus_fit_method         = 1,                 -- 0 = центрувати, 1 = мінімально доскролити
    follow_focus             = true,
    follow_min_visible       = 0.4,
    wrap_focus               = false,             -- без «перескоку» з кінця стрічки на початок
    wrap_swapcol             = false,
    direction                = "right",
  },

  gestures = {
    scrolling = {
      move_snap_to_grid = true,                   -- свайп «доклацує» до межі колонки
    },
  },
})

hl.window_rule({ name = "scrolling-wide-apps", match = { class = wide_apps }, scrolling_width = 1.0 })

-- ------------------------------------------------------------------------------
-- Анімації як у niri: стрічка їде по горизонталі, столи — по вертикалі.
-- Пружини критично згасаючі (dampening = 2·√(mass·stiffness)): швидко і без «відскоку».
-- ------------------------------------------------------------------------------
hl.curve("niriView",      { type = "spring", mass = 1, stiffness = 800,  dampening = 57 })
hl.curve("niriWorkspace", { type = "spring", mass = 1, stiffness = 1000, dampening = 64 })

-- Прокрутка стрічки, swapcol, consume/expel, зміна ширини колонки
hl.animation({ leaf = "windowsMove",   enabled = true, speed = 3.2, spring = "niriView" })
-- Відкриття: niri масштабує з центру з fade, без пружного «стрибка»
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 2.2, bezier = "easeOutExpo", style = "popin 80%" })

-- Столи стоять один над одним, тому зсув вертикальний (горизонталь зайнята стрічкою)
hl.animation({ leaf = "workspaces",    enabled = true, speed = 3.0, spring = "niriWorkspace", style = "slidevert" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 3.0, spring = "niriWorkspace", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.0, spring = "niriWorkspace", style = "slidevert" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 2.4, bezier = "easeOutExpo", style = "slidefadevert 20%" })

-- Жести: 3 пальці горизонтально гортають стрічку, вертикально — робочі столи
hl.gesture({ fingers = 3, direction = "horizontal", action = "scroll_move" })
hl.gesture({ fingers = 3, direction = "vertical",   action = "workspace" })

-- ------------------------------------------------------------------------------
-- Навігація (максимально близько до дефолтів niri)
-- ------------------------------------------------------------------------------
local directions = {
  h = "l", left = "l",
  l = "r", right = "r",
  j = "d", down = "d",
  k = "u", up = "u",
}
local names = { l = "left", r = "right", u = "up", d = "down" }

for key, d in pairs(directions) do
  -- H/L — сусідня колонка, J/K — вікно в межах колонки
  bind(mod .. " + " .. key, hl.dsp.layout("focus " .. d), "Scrolling: Focus " .. names[d], { repeating = true })

  if d == "l" or d == "r" then
    bind(mod .. " + SHIFT + " .. key, hl.dsp.layout("swapcol " .. d),
      "Scrolling: Move column " .. names[d], { repeating = true })
    bind(mod .. " + ALT + " .. key, hl.dsp.layout("colresize " .. (d == "l" and "-0.05" or "+0.05")),
      "Scrolling: " .. (d == "l" and "Narrow" or "Widen") .. " column", { repeating = true })
  else
    -- На краю колонки вікно переїжджає на сусідній стіл (niri: move-window-up-or-to-workspace-up)
    bind(mod .. " + SHIFT + " .. key, function()
      local w = hl.get_active_window()
      local l = w and not w.floating and w.layout
      local col = l and l.column
      if col and l.index_in_column == (d == "u" and 0 or #col.windows - 1) then
        hl.dispatch(hl.dsp.window.move({ workspace = d == "u" and "r-1" or "r+1" }))
      else
        hl.dispatch(hl.dsp.window.move({ direction = names[d] }))
      end
    end, "Scrolling: Move window " .. names[d] .. " (or to workspace " .. (d == "u" and "above" or "below") .. ")")
  end
end

-- Столи вгору/вниз як у niri (Mod+U/I, Mod+Page_Down/Up); r±1 відкриває і порожній стіл
local ws_keys = { U = "r+1", Next = "r+1", I = "r-1", Prior = "r-1" }
for key, ws in pairs(ws_keys) do
  local where = ws == "r+1" and "below" or "above"
  bind(mod .. " + " .. key,          hl.dsp.focus({ workspace = ws }),       "Workspace: Go " .. where, { repeating = true })
  bind(mod .. " + SHIFT + " .. key,  hl.dsp.window.move({ workspace = ws }), "Workspace: Move window " .. where)
  bind(mod .. " + CTRL + " .. key,   hl.dsp.window.move({ workspace = ws }), "Workspace: Move window " .. where)
end

-- Super+Shift+колесо — вікна по горизонталі (Super+колесо — робочі столи, див. bindings.lua)
bind(mod .. " + SHIFT + mouse_down", hl.dsp.layout("focus r"), "Scrolling: Next column (wheel)")
bind(mod .. " + SHIFT + mouse_up",   hl.dsp.layout("focus l"), "Scrolling: Previous column (wheel)")

-- ------------------------------------------------------------------------------
-- Колонки
-- ------------------------------------------------------------------------------
-- Вікно в сусідню колонку або в окрему (niri: consume-or-expel-window-left/right)
bind(mod .. " + bracketleft",  hl.dsp.layout("consume_or_expel prev"), "Scrolling: Consume/expel window left")
bind(mod .. " + bracketright", hl.dsp.layout("consume_or_expel next"), "Scrolling: Consume/expel window right")

-- Ширина: пресети (niri: switch-preset-column-width)
bind(mod .. " + R",         hl.dsp.layout("colresize +conf"), "Scrolling: Next width preset")
bind(mod .. " + SHIFT + R", hl.dsp.layout("colresize -conf"), "Scrolling: Previous width preset")

-- Колонка на всю ширину і назад (niri: maximize-column)
bind(mod .. " + CTRL + F", function()
  local window = hl.get_active_window()
  local column = window and not window.floating and window.layout and window.layout.column
  if not column then return end
  hl.dispatch(hl.dsp.layout("colresize " .. (column.width >= 0.99 and "0.5" or "1.0")))
end, "Scrolling: Maximize column")

-- Повністю показати активну колонку (niri: center-column)
bind(mod .. " + CTRL + C", hl.dsp.layout("fit_into_view"), "Scrolling: Fit column into view")
