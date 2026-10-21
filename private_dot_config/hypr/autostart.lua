-- ==============================================================================
-- Hyprland Autostart Configuration
-- ==============================================================================

hl.on("hyprland.start", function()
  -- Оболонка, статус-бар та вбудований Polkit-агент Noctalia
  hl.exec_cmd("uwsm app -- noctalia")

  -- Менеджер паролів та SSH-агент
  hl.exec_cmd("uwsm app -- keepassxc --minimized")
end)
