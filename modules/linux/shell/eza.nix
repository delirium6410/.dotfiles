{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.shell.eza;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.eza = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.eza = {
        enable = true;
        git = true;
        extraOptions = [
          "--group-directories-first"
          "--header"
        ];
      };
      
      home.shellAliases = {
        ls = "eza";
        tree = "eza --tree";
      };
    };
  };
}