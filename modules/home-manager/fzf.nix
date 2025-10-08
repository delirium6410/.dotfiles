{ config, pkgs, lib, ... }:
{
  options = {
    machine.fzf.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.fzf.enable {
    programs.fzf = {
      enable = true;
      enableBashIntegration = true;
    };
  };
}