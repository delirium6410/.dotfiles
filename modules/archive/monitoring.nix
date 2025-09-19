{ config, pkgs, lib, ... }:
{
  options = {
    machine.monitoring.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.monitoring.enable {
    environment.systemPackages = with pkgs; [
      # hardware 
      htop
      s-tui
      atop
      iftop
      iotop
      csysdig
      nvtop
      perf
      wavemon
    ];
  };
}