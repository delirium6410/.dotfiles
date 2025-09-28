{ config, lib, pkgs, ... }: 
{
  options = {
    machine.thunderbird.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.thunderbird.enable {
    programs.thunderbird = {
      enable = true;
      profiles = {};
      settings =  {
         "privacy.donottrackheader.enabled" = true; 
      };
    };
  };
}
