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

    # Tailscale was delaying shutdown 
    systemd.services.tailscaled = {
      serviceConfig = {
        TimeoutStopSec = "5s";  
      };
    };

    networking.firewall.trustedInterfaces = [ "tailscale0" ];
  };
}