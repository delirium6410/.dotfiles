{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.development.git;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.development.git = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
      programs.git = {
        enable = true;
        userEmail = "delirium";
        userName = "delirium6410";
        extraConfig = {
          init = {
            defaultBranch = "main";
          };
        };
      };
      
      home.shellAliases = {
        ga = "git add";
        gcc = "git commit";
        gca = "git commit --amend";
        gcm = "git commit -m";
        gd = "git diff";
        gds = "git diff --staged";
        gp = "git push";
        gr = "git restore";
        grh = "git reset HEAD";
        gs = "git status";
      };
    };
  };
}