{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.communication.discord;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.communication.discord = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.vesktop = {
        enable = true;
        settings = {
          disableMinSize = true;
        };

        vencord.settings = {
          autoUpdate = false;
          autoUpdateNotification = false;
          notifyAboutUpdates = false;
          useQuickCss = true;
          plugins = {
            YoutubeAdblock.enabled = true;
            FakeNitro.enabled = true;
            ReadAllNotificationsButton.enabled = true;
            BetterFolders.enabled = true;
            ClearURLs.enabled = true;
            BiggerStreamPreview.enabled = true;
            FixImagesQuality.enabled = true;
            FixYoutubeEmbeds.enabled = true;
            WhoReacted.enabled = true;
          };
        };
      };
    };
  };
}