{ config, pkgs, lib, ... }:
{
  options = {
    machine.vscode.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.vscode.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = false;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        userSettings = {};
      };
    };
  };
}