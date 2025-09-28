{ config, pkgs, lib, ... }:
{
  options = {
    machine.bitwarden.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.bitwarden.enable {
    home.packages = with pkgs; [ bitwarden ];
  };
}
