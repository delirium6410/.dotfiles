{ config, pkgs, lib, ... }:
{
  options = {
    machine.placeholder.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.placeholder.enable {
  };

  # copy if i want to make settings dependent on other modules:
  # setting = lib.mkIf config.nixos.caddy.enable bool/"str"/int; 
  # if caddy.enable enables secrets.enable then u can if secrets.enable and continue 
  # the daisy chain of if clauses for stuff like office/gaming and so on
  # gaming, if set to true enables other settings that enable other settings
}