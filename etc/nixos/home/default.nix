{ inputs, lib, pkgs, flake-packages, ... }:
let
  home-manager = inputs.home-manager;
  system = "x86_64-linux";
  username = "nicourrrn";
  user-packages = import ./packages {
    inherit pkgs;
    inherit flake-packages;
    inherit lib;
  };
in
{
  imports = [
    home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.users.${username} = {
        home.username = username;
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "25.05";
        home.packages = user-packages;
        imports = [ ./config ];
      };
      home-manager.extraSpecialArgs = {
        flake-packages = inputs;
        inherit system;
      };
    }
  ];
}
