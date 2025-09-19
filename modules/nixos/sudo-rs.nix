{ config, pkgs, lib, ... }:
{
  options = {
    machine.sudo-rs.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.sudo-rs.enable {
    security.sudo-rs.enable = true;
  };
}