{ config, pkgs, lib, ... }:
{
  options = {
    machine.networkmanager.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.networkmanager.enable {
    networking.networkmanager.enable = true;
    # consider using iptables
    networking.firewall = {
      enable = true;
      checkReversePath = "loose";   
    };
    services.resolved.enable = true;
  };
}