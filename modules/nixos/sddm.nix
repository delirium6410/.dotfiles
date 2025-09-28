{ config, pkgs, lib, ... }:
{
  options = {
    machine = {
      sddm.enable = lib.mkEnableOption "";
      hidpi.enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf config.machine.sddm.enable {
    services.displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      enableHidpi = lib.mkIf config.machine.hidpi.enable true;
      theme = "elegant-sddm";
    };

    environment.systemPackages = with pkgs; [ elegant-sddm
 ];
  };
}
