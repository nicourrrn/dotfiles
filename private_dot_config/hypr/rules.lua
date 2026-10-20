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

-- 5. Менеджер паролів KeePassXC: поверх інших вікон, по центру з відступами по боках та 85% висоти (960x918)
hl.window_rule({
  name = "keepassxc-center-floating",
  match = {
    class = "^(org\\.keepassxc\\.KeePassXC|keepassxc)$",
  },
  float = true,
  size = "960 918",
  center = true,
  pin = true,
})

-- 6. Відео, браузери та Blender завжди непрозорі (inactive_opacity не стосується контенту)
hl.window_rule({
  name = "opaque-content-apps",
  match = { class = "(?i)^(mpv|zen(-browser)?|thorium.*|chromium.*|firefox|blender|org\\.telegram\\.desktop)$" },
  opacity = "1.0 override 1.0 override 1.0 override",
})

-- 7. Переглядач медіа та PiP Telegram — плаваючі (ідея з hyprstack)
hl.window_rule({
  name = "telegram-media-viewer",
  match = { class = "(?i)^(org\\.telegram\\.desktop|telegramdesktop)$", initial_title = "^(Media viewer|Медіапереглядач|Просмотр медиа)$" },
  float = true,
  center = true,
})
hl.window_rule({
  name = "telegram-pip",
  match = { class = "(?i)^(org\\.telegram\\.desktop|telegramdesktop)$", initial_title = "^(Picture-in-Picture|Picture in picture|Картинка в картинці)$" },
  float = true,
  pin = true,
  keep_aspect_ratio = true,
})

-- Розмиття під напівпрозорими панелями Noctalia (лаунчер, буфер, центр керування)
hl.layer_rule({
  name = "noctalia-panel-blur",
  match = { namespace = "^noctalia-panel$" },
  blur = true,
  ignore_alpha = 0.3,
})
