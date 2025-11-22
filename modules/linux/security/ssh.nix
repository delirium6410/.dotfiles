{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.security.ssh;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.security.ssh = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.ssh = {
        enable = true;
        extraOptionOverrides = {
          CanonicalizeHostname = "yes";
        };
      };

      systemd.user.tmpfiles.rules = [
        "d     %t/ssh          0700  -     -      -    -"
        "d     %t/ssh/control  0700  -     -      -    -"
      ];
    };
  };
}