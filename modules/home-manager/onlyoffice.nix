{ config, pkgs, lib, ... }:
{
  options = {
    machine.onlyoffice.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.onlyoffice.enable {
      programs.onlyoffice = {
        enable = true;
        settings = lib.mkMerge [
          (lib.mkIf (config.stylix.polarity == "dark") {
            UITheme = "theme-contrast-dark";
          })
          (lib.mkIf (config.stylix.polarity == "light") {
            UITheme = "theme-contrast-light";
          })
        ];
     };
  };
}
