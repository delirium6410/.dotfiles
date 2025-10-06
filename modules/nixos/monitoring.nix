{ config, pkgs, lib, ... }:
{
  options = {
    machine.monitoring.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.monitoring.enable {
    environment.systemPackages = with pkgs; [
      btop
      iostat
      tcpdump
      iotop
      atop
      nethogs
      iftop
      vnstat
      nmon
      glances
    ];
  };
}