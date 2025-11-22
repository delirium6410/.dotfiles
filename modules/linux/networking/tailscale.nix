{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.networking.tailscale;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.networking.tailscale = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
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