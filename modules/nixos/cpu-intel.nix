{ config, pkgs, lib, ... }:
{
  options = {
    machine.cpu-intel.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.cpu-intel.enable {
    hardware.cpu.intel.updateMicrocode = true;
    environment.systemPackages = with pkgs; [ iucode-tool ];
  };
}