{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.systemd-boot;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.systemd-boot = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    boot = {
      loader = {
        efi.canTouchEfiVariables = true;
        timeout = 0;
        systemd-boot = {
          enable = true;
          editor = false;
          configurationLimit = 5;
          memtest86.enable = true;
        };
      };
      initrd = {
        systemd.enable = true;
        verbose = false;
      };
      consoleLogLevel = 0;
    };
    systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  };
}