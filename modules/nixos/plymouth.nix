{ config, lib, ... }: 
{
  options = {
    machine.plymouth.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.plymouth.enable {
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
        # plymouth and general removal of boot messages
        "plymouth.ignore-serial-consoles"
        "vt.global_cursor_default=0"
        # stalling boot for no reason
        "nosgx"
      ];
      blacklistedKernelModules = [ 
        # old serial port kernel modules, took 4sec off boot time :)
        "8250" 
        "8250_pci"
      ];
    };
  };
}
