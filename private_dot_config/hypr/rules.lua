-- ==============================================================================
-- Hyprland Window and Layer Rules
-- ==============================================================================

-- 1. Ігнорування примусових запитів на розгортання (maximize) від додатків
hl.window_rule({
  name = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
})

-- 2. Виправлення перетягування та дропу у додатках XWayland
hl.window_rule({
  name = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
})

-- 3. Позиціювання допоміжних вікон
hl.window_rule({
  name = "move-hyprland-run",
  match = { class = "hyprland-run" },
  move = "20 monitor_h-120",
  float = true,
})

-- 4. Плаваючі вікна для діалогів та налаштувань
hl.window_rule({
  name = "floating-dialogs",
  match = { class = "(pavucontrol|nm-connection-editor|blueman-manager)" },
  float = true,
})
