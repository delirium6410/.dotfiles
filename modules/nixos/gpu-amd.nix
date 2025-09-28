{ config, pkgs, lib, ... }:
{
  options = {
    machine.gpu-amd.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gpu-amd.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
  };
}