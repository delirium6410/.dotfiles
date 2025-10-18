{ config, lib, pkgs, ... }:
{
  options.machine.stylix = {
    enable = lib.mkEnableOption "";
  };
  
  config = lib.mkIf config.machine.stylix.enable {
    stylix.targets = {
      firefox = {
        enable = true;
        profileNames = [ "default" ];
        colorTheme.enable = true;
      };
      #qt = {
      #  enable = true;
      #  platform = "qtct"; # get rid of "kde6 unsupported" message
      #};
    };
  };
}
