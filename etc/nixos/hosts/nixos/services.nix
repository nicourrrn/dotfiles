{ pkgs, ... }:
{
  programs.direnv.enable = true;
  services.upower.enable = true;
  programs.dconf.enable = true;
  services.dbus = {
    enable = true;
    implementation = "broker";
    packages = with pkgs; [
      xfconf
      gnome2.GConf
    ];
  };
  services.mpd.enable = true;
  programs.thunar.enable = true;
  programs.xfconf.enable = true;
  # services.tumbler.enable = true;
  # services.fwupd.enable = true;
  # services.auto-cpufreq.enable = true;
  # services.gnome.core-shell.enable = true;
  # services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
}
