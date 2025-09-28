{ config, lib, pkgs, ... }: 
{
  options = {
    machine.discord.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.discord.enable {
    programs.vesktop = {
      enable = true;
      # add plugins
      settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        useQuickCss = true;
        disableMinSize = true;
      };
    };
  };
}
