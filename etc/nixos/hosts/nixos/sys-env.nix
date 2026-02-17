{ pkgs, flake-packages, ... }:
let
  system-packages = import ./system-packages.nix { inherit pkgs; };
in
{
  system.stateVersion = "25.05";
  environment.systemPackages = system-packages;
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
  nixpkgs.overlays = [ flake-packages.polymc.overlay ];
}
