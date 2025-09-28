{ config, pkgs, lib, ... }:
{
  options = {
    machine.cpu-amd.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.cpu-amd.enable {
    hardware.cpu.amd.updateMicrocode = true;
    environment.systemPackages = with pkgs; [ iucode-tool ];
  };
}