{ config, pkgs, lib, ... }:
{
  options = {
    machine.cosmic.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.cosmic.enable {
    services.desktopManager.cosmic.enable = true; 
    services.displayManager.cosmic-greeter.enable = true;
  };
}
