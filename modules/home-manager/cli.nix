{ config, pkgs, lib, ... }:
{
  options = {
    machine.cli.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.cli.enable {
    programs.bat.enable = true;
    programs.navi.enable = true;
    programs.ripgrep.enable = true;

    programs.ghostty = {
      enable = true; 
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
    };

    programs.eza = {
      enable = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableTransience = true;
      settings = {
        nix_shell.heuristic = true;
        shlvl.disabled = false;
      };
    };
    
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
    };

    home.shellAliases = {
      cat = "bat";
      ls = "eza";
      tree = "eza --tree";
      rg = "rg -i"
    };
  };
}