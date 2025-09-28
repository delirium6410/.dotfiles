{ config, lib, ... }:
{
  options = {
    machine.avahi.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.avahi.enable {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };
}
