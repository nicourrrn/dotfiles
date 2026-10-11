-- ==============================================================================
-- Hyprland Autostart Configuration
-- ==============================================================================

hl.on("hyprland.start", function()
  -- Оболонка, статус-бар та вбудований Polkit-агент Noctalia
  hl.exec_cmd("noctalia")

  -- Менеджер паролів та SSH-агент
  hl.exec_cmd("keepassxc --minimized")

  -- Буфер обміну Wayland
  hl.exec_cmd("wl-paste --watch cliphist store")
end)
