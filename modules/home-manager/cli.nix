{ config, pkgs, lib, ... }:
{
  options = {
    machine.cli.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.cli.enable {
    machine.zsh.enable = true;
    machine.starship.enable = true;
    programs.bat.enable = true;

    programs.ghostty = {
      enable = true; 
      enableBashIntegration = true;
      enableZshIntegration = true;
      installBatSyntax = true;
      installVimSyntax = true;
      clearDefaultKeybinds = false;
    };

    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

    programs.navi = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
    };

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
        "node_modules"
      ];
    };

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

    programs.eza = {
      enable = true;
      git = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };

    home.shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      
      "nsp" = "nix-shell -p";
      "nrs" = "nixos-rebuild switch --flake";
      "nrb" = "nixos-rebuild switch --flake";

      cat = "bat";
      ls = "eza";
      tree = "eza --tree";
    };
  };
}