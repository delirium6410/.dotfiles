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
        intel-media-driver
        intel-vaapi-driver
        intel-compute-runtime
        vpl-gpu-rt
      ];
      
      extraPackages32 = with pkgs; [
        intel-media-driver
        intel-vaapi-driver
      ];
    };

    environment.systemPackages = with pkgs; [
      libvdpau-va-gl
    ];
    
    environment.variables = {
      LIBVA_DRIVER_NAME = "iHD";      
      VDPAU_DRIVER = "va_gl";
    };

    boot.initrd.kernelModules = [ "i915" ];
    boot.kernelModules = [ "i915" ];
    boot.kernelParams = [
      "i915.enable_fbc=1"
      "i915.fastboot=1"
    ];
    boot.extraModprobeConfig = ''
      options i915 enable_guc=3
    '';
  };
}