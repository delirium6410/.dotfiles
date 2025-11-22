{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.shell.cli;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.shell.cli = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules.unfreePackages = [ "claude-code" ];
    
    modules = {
      shell.bat.enable = true;
      shell.eza.enable = true;
      shell.fd.enable = true;
      shell.fzf.enable = true;
      shell.ghostty.enable = true;
      shell.navi.enable = true;
      shell.ripgrep.enable = true;
      shell.zoxide.enable = true;
    };
    
    home-manager.users.${username} = {
      home.packages = with pkgs; [ 
        claude-code
        tealdeer
      ];

      home.shellAliases = {
        dot = "cd .dotfiles";
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";
        
        np = "nix-shell -p";
        npu = "NIXPKGS_ALLOW_UNFREE=1 nix shell --impure -p";

        ns = "sudo nixos-rebuild switch --flake";
        nsb = "sudo nixos-rebuild boot --flake";
        nsc = "sudo nixos-rebuild build --flake";
        nst = "sudo nixos-rebuild test --flake";
        
        nup = "nix flake update";
        nfs = "nix flake show";
        nck = "nix flake check";
        fmt = "nix fmt";
        
        gc = "sudo nix-collect-garbage -d";
        gco = "sudo nix-collect-garbage --delete-older-than 7d";
        nop = "sudo nix-store --optimize";
        
        ngs = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
        nsr = "sudo nixos-rebuild switch --rollback";
      };
    };
  };
}