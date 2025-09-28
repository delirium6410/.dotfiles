{ config, pkgs, lib, ... }:
{
  options = {
    machine.tailscale.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.tailscale.enable {
    services.tailscale = {
      enable = true;
      useRoutingFeatures = "client";
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}