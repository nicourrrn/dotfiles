-- ==============================================================================
-- Hyprland Input Configuration
-- ==============================================================================

hl.config({
  input = {
    -- Розкладка клавіатури: US та UA, перемикання через Caps Lock
    kb_layout = "us,ua",
    kb_options = "grp:caps_toggle",

    -- Чутливість миші (-1.0 до 1.0, 0 - стандарт). -0.3 для точного контролю
    sensitivity = -0.3,

    -- Лінійний профіль курсора без стрибків акселерації
    accel_profile = "flat",

    follow_mouse = 1,
    repeat_rate = 40,
    repeat_delay = 250,
    numlock_by_default = true,

    touchpad = {
      -- Природна прокрутка
      natural_scroll = true,

      -- Правий клік двома пальцями
      clickfinger_behavior = true,

      -- Комфортна швидкість прокрутки
      scroll_factor = 0.5,

      -- Перетягування тапом
      tap_and_drag = true,
    },
  },
})

-- Жест 3 пальцями для перемикання робочих столів
hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

-- Специфічне калібрування для тачпада ноутбука
hl.device({
  name = "elan0515:00-04f3:3142-touchpad",
  natural_scroll = true,
  sensitivity = -0.3,
})
