{ config, pkgs, lib, ... }:
{
  options = {
    machine.zsh.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.zsh.enable {
    programs.zsh.enable = true;
    environment.shells = with pkgs; [ zsh ];
    environment.pathsToLink = [ "/share/zsh" ];
  };
}
