{ config, pkgs, lib, ... }:
{
  options = {
    machine.gpu-intel.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gpu-intel.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        intel-compute-runtime
        intel-media-driver
        intel-ocl
        vpl-gpu-rt
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ 
        intel-vaapi-driver 
      ];
    };
  };
}