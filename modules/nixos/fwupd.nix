{ config, pkgs, lib, ... }:
{
  options = {
    machine.fwupd.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.fwupd.enable {
    services.fwupd.enable = true;
  };
}