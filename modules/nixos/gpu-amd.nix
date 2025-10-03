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
        rocmPackages.clr.icd
      ];
    };

    environment.variables = {
      AMD_VULKAN_ICD = "RADV";
      LIBVA_DRIVER_NAME = "radeonsi";
      VDPAU_DRIVER = "radeonsi";
    };

    #environment.systemPackages = [ pkgs.lact ];
    #systemd.packages = [ pkgs.lact ];
    #systemd.services.lactd.wantedBy = [ "multi-user.target" ];

    #boot.kernelParams = [
    #  "amdgpu.ppfeaturemask=0x4000"
    #];

    # move to monitoring/debugging stack
    #environment.systemPackages = with pkgs; [
    #  nvtop
    #  radeontop   
    #  libva-utils
    #  vdpauinfo
    #  vulkan-tools      
    #];

    # Uncomment if you experience random system hangs
    # boot.kernelPatches = [
    #   {
    #     name = "amdgpu-stability-patch";
    #     patch = pkgs.fetchpatch {
    #       name = "amdgpu-stability-patch";
    #       url = "https://github.com/torvalds/linux/compare/ffd294d346d185b70e28b1a28abe367bbfe53c04...SeryogaBrigada:linux:4c55a12d64d769f925ef049dd6a92166f7841453.diff";
    #       hash = "sha256-q/gWUPmKHFBHp7V15BW4ixfUn1kaeJhgDs0okeOGG9c=";
    #     };
    #   }
    # ];
  };
}