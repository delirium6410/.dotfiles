{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.system.networkmanager;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.networkmanager = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = true;
    };
    services.resolved.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;
  };
}