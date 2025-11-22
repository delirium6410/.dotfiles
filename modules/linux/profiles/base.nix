{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.profiles.base;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.profiles.base = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules = {
      # System
      system.firmware.enable = true;
      system.kernel.enable = true;
      system.locale.enable = true;
      system.networkmanager.enable = true;
      system.nix.enable = true;
      system.systemd-boot.enable = true;
      system.xdg.enable = true;
      
      # Shell
      shell.cli.enable = true;
      shell.zsh.enable = true;
    };
  };
}