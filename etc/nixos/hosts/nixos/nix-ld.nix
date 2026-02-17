{ pkgs, ... }:
{
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    xorg.libXext
    xorg.libXrender
    xorg.libXtst
    xorg.libXi
    libGL
  ];
}
