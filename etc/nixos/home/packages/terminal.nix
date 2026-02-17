{ pkgs, flake-packages, ...}:
with pkgs; [
  alacritty
  bat
  gemini-cli
  just
  neofetch
  neovim
  nvd
  termdown
  xxd
  zellij

  # flake-packages.nixified-ai.packages.${pkgs.system}.ollama-cuda
  flake-packages.tuios.packages.${stdenv.hostPlatform.system}.tuios
]
