{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.browsers.brave;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.browsers.brave = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.chromium = {
        enable = true;
        package = pkgs.brave;
        extensions = [
          "igiofjhpmpihnifddepnpngfjhkfenbp" # AutoPagerize
          "nngceckbapebfimnlniiiahkandclblb" # Bitwarden
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
          "kbmfpngjjgdllneeigpgjifpgocmfgmb" # Reddit Enhancement Suite
          "gebbhagfogifgggkldgodflihgfeippi" # Return YouTube Dislike
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock for YouTube
          "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
        ];
      };
    };
  };
}