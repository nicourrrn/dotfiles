{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings.features.cdi = true;
    };
  };
  users.extraGroups.docker.members = [ "nicourrrn" ];

  zramSwap.enable = true;
}
