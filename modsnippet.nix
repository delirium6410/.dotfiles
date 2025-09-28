{ config, pkgs, lib, ... }:
{
  options = {
    machine.placeholder.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.placeholder.enable {
  };
}