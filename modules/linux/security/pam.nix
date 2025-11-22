{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.security.pam;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.modules.security.pam = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    security.pam.services.login.unixAuth = true;
    security.pam.services.sudo.unixAuth = true;

    security.pam.u2f = {
      enable = true;
      settings = {
        origin = "pam://machine";
        appid = "pam://machine";
        authfile = mkDefault (
          builtins.toFile "u2f_mappings" (
            lib.concatMapStringsSep "\n"
            (
              user:
                lib.concatStringsSep ":" [
                  user
                  ""
                ]
            )
            [
              username
            ]
          )
        );
        cue = true;
        pinverification = 1;
      };
    };

    security.pam.services.sudo.rssh = true;
    security.pam.rssh = {
      enable = true;
      settings = {
        auth_key_file = "/etc/ssh/authorized_keys.d/$ruser";
      };
    };
  };
}