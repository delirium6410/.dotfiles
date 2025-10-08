{ config, lib, ... }: 
{
  options = {
    machine.git.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.git.enable {
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
      gc = "git commit";
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
}
