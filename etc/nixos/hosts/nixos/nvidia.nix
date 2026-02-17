{ lib, config, ... }:
{
  services.xserver.videoDrivers = [
    "nvidia"
    "amdgpu"
  ];

  services.xserver.enable = true;
  services.xserver = {
    layout = "gb";
    xkbVariant = "extd";
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  hardware.nvidia-container-toolkit.enable = true;
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    dynamicBoost.enable = lib.mkForce true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.production;
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      nvidiaBusId = "PCI:1:0:0";
      amdgpuBusId = "PCI:5:0:0";
    };
  };
}
