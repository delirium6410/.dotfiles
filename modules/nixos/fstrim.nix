{ config, pkgs, lib, ... }:
{
  options = {
    machine.fstrim.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.fstrim.enable {
    services.fstrim.enable = true;
  };
}