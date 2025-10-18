{ config, lib, pkgs, ... }:
{
  options = {
    machine.discord.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.discord.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        disableMinSize = true;
      };

      vencord.settings = {
        autoUpdate = false;
        autoUpdateNotification = false;
        notifyAboutUpdates = false;
        enableSplashScreen = false;
        useQuickCss = true;
        plugins = {
          YoutubeAdblock.enabled = true;
          FakeNitro.enabled = true;
          ReadAllNotificationsButton.enabled = true;
        };
      };
    };
  };
}