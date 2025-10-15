{ config, pkgs, lib, ... }:
{
  options = {
    machine.networkmanager.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.networkmanager.enable {
    networking.networkmanager.enable = true;
    networking.firewall = {
      enable = true;
      checkReversePath = "loose";   
    };
    services.resolved.enable = true;
    systemd.services.NetworkManager-wait-online.enable = false;
    systemd.network.wait-online.enable = false;
  };
}