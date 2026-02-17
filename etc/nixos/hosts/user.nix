{ pkgs, ... }:
{
  users.users.nicourrrn = {
    isNormalUser = true;
    description = "nicourrrn";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "games"
    ];
    shell = pkgs.fish;
  };
}
