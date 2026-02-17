{ lib, ... }:
let
  wallpaper = "wallpaper.jpg";
in
{
  # services.hyprpaper.enable = true;
  # home.file."Pictures/${wallpaper}" = {
  #   source = ../img/${wallpaper};
  #   recursive = true;
  # };
  # home.activation.createFolders = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   mkdir -p "$HOME/Projects"
  #   mkdir -p "$HOME/Pictures/Screenshots"
  # '';
  # services.hyprpaper.settings = {
  #   ipc = "on";
  #   preload = [
  #     "~/Pictures/${wallpaper}"
  #   ];
  #   wallpaper = [
  #     ",~/Pictures/${wallpaper}"
  #   ];
  # };
}
