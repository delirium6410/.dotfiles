{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.fd;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.fd = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.fd = {
        enable = true;
        hidden = true;
        ignores = [
          ".git/"
          "*.bak"
          ".nix-profile/"
          ".nix-defexpr/"
          ".cache/"
          ".mozilla/"
        ];
      };
    };
  };
}