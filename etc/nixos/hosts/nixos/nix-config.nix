{ ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
    android_sdk.accept_license = true;
  };

  nix.settings  = {
    trusted-users = [ "root" "nicourrrn" ];
    auto-optimise-store = true;
    experimental-features = [
        "nix-command"
        "flakes"
      ];
    substituters = [
      "https://cache.nixos.org"
      "https://devenv.cachix.org"
      "https://nix-community.cachix.org"
      "https://cuda-maintainers.cachix.org"
    ];
    trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];

  };
  nix.gc = {
   automatic = true;
   dates = "weekly";
   options = "--delete-older-than 7d";
  };

}
