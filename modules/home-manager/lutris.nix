{ config, pkgs, lib, inputs, ... }:
{
  options = {
    machine.lutris.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.lutris.enable {
    home.packages = with pkgs; [ lutris ];
  };
}