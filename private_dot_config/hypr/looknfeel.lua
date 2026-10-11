-- ==============================================================================
-- Hyprland Look & Feel Configuration (Omarchy-inspired Fast & Snappy Physics)
-- ==============================================================================

-- Підвантаження кольорів поточної теми (динамічно з theme.lua)
pcall(require, "theme")

hl.config({
  general = {
    gaps_in  = 4,
    gaps_out = 10,
    border_size = 2,

    -- Динамічні кольори з theme-set (або Gruvbox за замовчуванням)
    col = {
      active_border   = _G.HYPR_ACTIVE_BORDER or { colors = {"rgba(fe8019ee)", "rgba(fabd2fee)"}, angle = 45 },
      inactive_border = _G.HYPR_INACTIVE_BORDER or "rgba(3c3836aa)",
    },

    resize_on_border = true,
    layout = "dwindle",
  },

  decoration = {
    rounding = 8,
    rounding_power = 2,
    active_opacity = 1.0,
    inactive_opacity = 0.96,

    shadow = {
      enabled = true,
      range = 10,
      render_power = 3,
      color = 0x55000000,
    },

    blur = {
      enabled = true,
      size = 5,
      passes = 2,
      vibrancy = 0.2,
      new_optimizations = true,
    },
  },

  animations = {
    enabled = true,
  },

  misc = {
    disable_hyprland_logo = true,
    animate_manual_resizes = false, -- Миттєва зміна розміру вікон мишею без затримок
  },

  dwindle = {
    preserve_split = true,
  },
})

-- ------------------------------------------------------------------------------
-- Криві Bezier та Фізичні пружини (Fast & Crisp Physics)
-- ------------------------------------------------------------------------------
hl.curve("easeOutExpo",   { type = "bezier", points = { {0.16, 1},    {0.3, 1}     } })
hl.curve("easeOutQuint",  { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("snappy",        { type = "bezier", points = { {0.05, 0.9},  {0.1, 1.05}  } })
hl.curve("linear",        { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",  { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",         { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Швидка, чуйна фізична модель (висока пружність, швидке гасіння коливань)
hl.curve("fastSpring",    { type = "spring", mass = 0.8, stiffness = 380, dampening = 28 })

-- ------------------------------------------------------------------------------
-- Налаштування анімацій вікон, шарів, меню та воркспейсів
-- ------------------------------------------------------------------------------
-- Вікна: стрімке відкриття з легким акцентом (~220мс) та миттєве закриття (~140мс)
hl.animation({ leaf = "windows",       enabled = true, speed = 3.2, spring = "fastSpring" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 2.8, spring = "fastSpring", style = "popin 88%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.4, bezier = "linear",     style = "popin 88%" })

-- Рамки вікон: швидкий перехід фокусу
hl.animation({ leaf = "border",        enabled = true, speed = 4.0, bezier = "easeOutExpo" })

-- Згасання (Fade)
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.6, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.3, bezier = "linear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 2.2, bezier = "quick" })

-- Шари інтерфейсу (Vicinae launcher, Noctalia bar, OSD)
hl.animation({ leaf = "layers",        enabled = true, speed = 2.5, bezier = "easeOutExpo" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 2.2, bezier = "easeOutExpo", style = "popin 92%" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.4, bezier = "linear",      style = "fade" })

-- Перемикання робочих столів: швидке та чітке зміщення без зависання
hl.animation({ leaf = "workspaces",    enabled = true, speed = 2.4, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 2.0, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.0, bezier = "easeOutExpo", style = "slide" })
