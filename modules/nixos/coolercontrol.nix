{ config, lib, pkgs, ... }:
{
  options = {
    machine.coolercontrol.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.coolercontrol.enable {
    programs.coolercontrol.enable = true;
  };
}