{ pkgs, flake-packages, ... }:
with pkgs; [
  yaak
  nodePackages.nodejs
  nix-output-monitor
  typescript
  bun
  uv
  python314FreeThreading
  rustc
  cargo
  go
  docker
  clang
  androidenv.androidPkgs.androidsdk
  jdk
  nixd # LSP servers
  flake-packages.nil-lsp.packages.${stdenv.hostPlatform.system}.nil
  httpie
  httpie-desktop
  flyctl
  wails
  ngrok
  fvm
  godot
  fyne
  # godot-export-templates-bin
  devenv
  flake-packages.fasm2.packages.${stdenv.hostPlatform.system}.default
  # flake-packages.zed-editor.packages.${stdenv.hostPlatform.system}.default
  zed-editor
  typst
  typst-live
]
