{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false;
  };
  wayland.windowManager.hyprland.settings = {
    "$rosewater" = "rgb(f4dbd6)";
    "$rosewaterAlpha" = "#f4dbd6";

    "$flamingo" = "rgb(f0c6c6)";
    "$flamingoAlpha" = "#f0c6c6";

    "$pink" = "rgb(f5bde6)";
    "$pinkAlpha" = "#f5bde6";

    "$mauve" = "rgb(c6a0f6)";
    "$mauveAlpha" = "#c6a0f6";

    "$red" = "rgb(ed8796)";
    "$redAlpha" = "#ed8796";

    "$maroon" = "rgb(ee99a0)";
    "$maroonAlpha" = "#ee99a0";

    "$peach" = "rgb(f5a97f)";
    "$peachAlpha" = "#f5a97f";

    "$yellow" = "rgb(eed49f)";
    "$yellowAlpha" = "#eed49f";

    "$green" = "rgb(a6da95)";
    "$greenAlpha" = "#a6da95";

    "$teal" = "rgb(8bd5ca)";
    "$tealAlpha" = "#8bd5ca";

    "$sky" = "rgb(91d7e3)";
    "$skyAlpha" = "#91d7e3";

    "$sapphire" = "rgb(7dc4e4)";
    "$sapphireAlpha" = "#7dc4e4";

    "$blue" = "rgb(8aadf4)";
    "$blueAlpha" = "#8aadf4";

    "$lavender" = "rgb(b7bdf8)";
    "$lavenderAlpha" = "#b7bdf8";

    "$text" = "rgb(cad3f5)";
    "$textAlpha" = "#cad3f5";

    "$subtext1" = "rgb(b8c0e0)";
    "$subtext1Alpha" = "#b8c0e0";

    "$subtext0" = "rgb(a5adcb)";
    "$subtext0Alpha" = "#a5adcb";

    "$overlay2" = "rgb(939ab7)";
    "$overlay2Alpha" = "#939ab7";

    "$overlay1" = "rgb(8087a2)";
    "$overlay1Alpha" = "#8087a2";

    "$overlay0" = "rgb(6e738d)";
    "$overlay0Alpha" = "#6e738d";

    "$surface2" = "rgb(5b6078)";
    "$surface2Alpha" = "#5b6078";

    "$surface1" = "rgb(494d64)";
    "$surface1Alpha" = "#494d64";

    "$surface0" = "rgb(363a4f)";
    "$surface0Alpha" = "#363a4f";

    "$base" = "rgb(24273a)";
    "$baseAlpha" = "#24273a";

    "$mantle" = "rgb(1e2030)";
    "$mantleAlpha" = "#1e2030";

    "$crust" = "rgb(181926)";
    "$crustAlpha" = "#181926";

    "$mainMod" = "SUPER";
    general = {
      border_size = "2";
      # no_border_on_floating = "yes";

      gaps_in = "3";
      gaps_out = "6";

      layout = "dwindle";
      resize_on_border = "yes";
      extend_border_grab_area = "10";
      "col.active_border" = "$teal";
      "col.inactive_border" = "$surface1";
    };

    input = {
      kb_layout = "us,ua";
      kb_options = "grp:caps_toggle";

      sensitivity = "-1";
      accel_profile = "adaptive";
      follow_mouse = "1";

      touchpad = {
        natural_scroll = "yes";
        tap-and-drag = true;
        scroll_factor = 0.7;
      };
    };

    device = {
      name = "elan0515:00-04f3:3142-touchpad";
      natural_scroll = true;
      sensitivity = -0.3;
    };
    exec-once = [
      "alacritty"
      # "waybar"
      # "hyprpaper"
      # "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    ];
    monitor = [
      "eDP-1, highres@60.00Hz, 0x0, 1"
      "HDMI-A-1, preferred, auto, 1"
    ];
    bind = [
      ", Print, exec, fish -c screenshot_to_clipboard"
      "$mainMod, Return, exec, alacritty"
      "$mainMod, D, exec, rofi -show drun"
      "$mainMod, W, togglegroup"
      "$mainMod, $left, changegroupactive, b"
      "ALT, TAB, changegroupactive, f"
      "$mainMod, $right, changegroupactive, f"
      "$mainMod SHIFT, W, lockactivegroup, toggle"
      "$mainMod, T, exec, thunar"

      "$mainMod, 1, workspace, 1"
      "$mainMod, 2, workspace, 2"
      "$mainMod, 3, workspace, 3"
      "$mainMod, 4, workspace, 4"
      "$mainMod, 5, workspace, 5"
      "$mainMod, 6, workspace, 6"
      "$mainMod, 7, workspace, 7"
      "$mainMod, 8, workspace, 8"
      "$mainMod, 9, workspace, 9"
      "$mainMod, 0, workspace, 10"

      "$mainMod SHIFT, 1, movetoworkspace, 1"
      "$mainMod SHIFT, 2, movetoworkspace, 2"
      "$mainMod SHIFT, 3, movetoworkspace, 3"
      "$mainMod SHIFT, 4, movetoworkspace, 4"
      "$mainMod SHIFT, 5, movetoworkspace, 5"
      "$mainMod SHIFT, 6, movetoworkspace, 6"
      "$mainMod SHIFT, 7, movetoworkspace, 7"
      "$mainMod SHIFT, 8, movetoworkspace, 8"
      "$mainMod SHIFT, 9, movetoworkspace, 9"
      "$mainMod SHIFT, 0, movetoworkspace, 10"

      "$mainMod SHIFT, E, exit,"
      "$mainMod SHIFT, Q, killactive,"

      "$mainMod, P, pseudo"
      "$mainMod, S, togglesplit"
      "$mainMod, F, fullscreen"
      "$mainMod, V, togglefloating"
    ];
    bindm = [
      "$mainMod, mouse:272, movewindow"
      "$mainMod, mouse:273, resizewindow"
    ];
    bindel = [
      ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
      ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ", XF86AudioRaiseVolume, exec, volumectl up"
      ", XF86AudioLowerVolume, exec, volumectl down"
      ", XF86AudioMute, exec, volumectl toggle-mute"
      ", XF86AudioMicMute, exec, volumectl -m toggle-mute"
    ];
    env = [
      "HYPRCURSOR_THEME,Catppuccin-Macchiato-Teal"
      "HYPRCURSOR_SIZE,24"
      "XCURSOR_THEME,Catppuccin-Macchiato-Teal"
      "XCURSOR_SIZE,24"
    ];
    decoration = {
      rounding = 10;
      blur = {
        size = 8;
        passes = 2;
      };
      shadow = {
        enabled = true;
        range = 15;
        render_power = 3;
        offset = "0, 0";
        color = "$teal";
        color_inactive = "0xff$baseAlpha";
      };

      active_opacity = "0.9";
      inactive_opacity = "0.7";
      fullscreen_opacity = "1";
    };

    layerrule = "blur on";

    animations = {
      enabled = "yes";
      bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
      animation = [
        "windows, 1, 2, myBezier"
        "windowsOut, 1, 2, default, popin 80%"
        "border, 1, 3, default"
        "fade, 1, 2, default"
        "workspaces, 1, 1, default"
      ];
    };
    dwindle = {
      pseudotile = "yes"; # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
      preserve_split = "yes"; # you probably want this
      smart_split = true;
    };

    master = {
      new_status = "master";
    };

    gestures = {
      gesture = "3, horizontal, workspace";
    };
    misc = {
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      background_color = "0x24273a";
    };
    binds = {
      workspace_back_and_forth = true;
    };
  };
}
