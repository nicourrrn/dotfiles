{ ... }:
{
  services.avahi.enable = true;
  networking.hostName = "nixos";
  networking.wireless.iwd = {
    enable = true;
    settings = {
      General = { EnableNetworkConfiguration = true; };
      Network = { EnableIPv6 = true; };
      Scan = { DisablePeriodicScan = false; };
    };
  };
}
