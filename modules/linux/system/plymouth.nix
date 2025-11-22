{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.plymouth;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.plymouth = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    boot = {
      plymouth.enable = true;
      kernelParams = [
        "quiet"
        "splash"
        "boot.shell_on_fail"
        "loglevel=3"
        "rd.systemd.show_status=false"
        "rd.udev.log_level=3"
        "udev.log_priority=3"
        "plymouth.ignore-serial-consoles"
        "vt.global_cursor_default=0"
        "nosgx"
      ];
      blacklistedKernelModules = [ 
        "8250" 
        "8250_pci"
      ];
    };
  };
}