{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.ripgrep;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.ripgrep = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.ripgrep = {
        enable = true;
        arguments = [
          "--glob=!.envrc"
          "--glob=!*.lock"
          "--glob=!generated.nix"
          "--glob=!generated.json"
          "--smart-case"
          "--hidden"
        ];
      };
    };
  };
}