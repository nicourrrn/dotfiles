{ pkgs, flake-packages, ... }:
with pkgs; [
  vesktop
  gparted
  keepassxc
  protontricks
  qbittorrent-enhanced
  steam
  syncthing
  telegram-desktop
  zoom-us
  dms-shell
  mailspring
  # flake-packages.quickshell.packages.${stdenv.hostPlatform.system}.default
]
