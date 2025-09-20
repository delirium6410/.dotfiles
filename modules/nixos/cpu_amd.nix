{ config, pkgs, lib, ... }:
{
  options = {
    system.cpu_amd.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.system.cpu_amd.enable {
    hardware.cpu.amd.updateMicrocode = true;
    environment.systemPackages = with pkgs; [ iucode-tool ];
  };
}