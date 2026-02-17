{
  description = "Nicourrrn base flake configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    thorium = {
      url = "github:Rishabh5321/thorium_flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil-lsp = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    tuios = {
      url = "github:Gaurav-Gosain/tuios";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devenv.url = "github:cachix/devenv/v1.10";
    nixified-ai.url = "github:nixified-ai/flake";
    fasm2.url = "github:nicourrrn/fasm2-flake";
    zed-editor.url = "github:zed-industries/zed";
    polymc.url = "github:PolyMC/PolyMC";
  };

  outputs =
    { self, nixpkgs, devenv, ... }@inputs:
    let
      system = "x86_64-linux";
    in
    {
      # devShells.${system} = {
      #   python = devenv.lib.mkShell {
      #     modules = [
      #       ./home/enviroments/python.nix
      #     ];
      #   };
      # };
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; flake-packages = inputs;};
        modules = [
          ./home
          ./hosts/nixos
          ./hardware-configuration.nix
        ];
      };
    };
}
