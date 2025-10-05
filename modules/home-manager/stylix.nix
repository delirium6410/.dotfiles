{ config, lib, pkgs, ... }:
{
  options.machine.stylix = {
    enable = lib.mkEnableOption "";
  };
  
  config = lib.mkIf config.machine.stylix.enable {
    stylix.targets.firefox.profileNames = [ "default" ];
  };
}
