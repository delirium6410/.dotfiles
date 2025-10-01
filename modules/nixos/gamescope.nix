{ config, pkgs, lib, ... }:
{
  options = {
    machine.gamescope.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.gamescope.enable {
    programs.gamescope = {
      enable = true;
      args = [
        "--force-grab-cursor"
        "-f"
      ];
    };
  };
}