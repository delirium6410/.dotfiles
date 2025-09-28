{ config, lib, ... }: 
{
  options = {
    machine.bash.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.bash.enable {
    programs.bash = { 
      enable = true;
      historyFile = "$HOME/.local/state/bash_history";
      shellAliases = {
        ".." = "cd ../";
        "nr" = "nixos-rebuild switch --flake";
        "hr" = "home-manager switch --flake";
        "ns" = "nix-shell -p";
      };
    };
  };
}
