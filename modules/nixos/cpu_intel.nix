{ config, pkgs, lib, ... }:
{
  options = {
    system.cpu_intel.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.system.cpu_intel.enable {
    hardware.cpu.intel.updateMicrocode = true;
    environment.systemPackages = with pkgs; [ iucode-tool ];
  };
}