{ config, pkgs, lib, ... }:
{
  options = {
    machine.brave.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.brave.enable {
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
}
