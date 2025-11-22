{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.networking.tailscale;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.networking.proton = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      protonvpn-gui
    ];
    
    networking.firewall = {
      checkReversePath = "loose";   
    };
  };
}