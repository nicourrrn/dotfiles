{ pkgs, flake-packages, ... }:
with pkgs; [
  cava
  easyeffects
  gimp
  libreoffice-qt6-fresh
  loupe
  obs-studio
  obsidian
  spotify
  spotifyd
  vlc

  flake-packages.thorium.packages.${stdenv.hostPlatform.system}.thorium-avx2
  flake-packages.zen-browser.packages.${stdenv.hostPlatform.system}.default
]
