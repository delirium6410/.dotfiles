{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.tools.soundux;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.tools.soundux = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.flatpak = {
      packages = [
        "io.github.Soundux"
      ];
    };

    home-manager.users.${username} = {
      home.shellAliases = {
        soundux = "flatpak run io.github.Soundux";
      };
    };
  };
}