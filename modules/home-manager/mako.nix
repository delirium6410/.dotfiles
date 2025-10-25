{ config, lib, pkgs, ... }:
{
  options = {
    machine.mako.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.mako.enable {
    stylix.targets.mako.enable = false;
    services.mako = 
    let
      makoOpacity = lib.toHexString (builtins.ceil (config.stylix.opacity.popups * 255));
    in
    {
      enable = true;
      settings = {
        anchor = "top-right";
        icons = true;
        border-radius = 0;
        default-timeout = 5000;
        border-color = lib.mkForce "${config.lib.stylix.colors.base03-hex}";
        "urgency=low" = {
          background-color = "${config.lib.stylix.colors.base00-hex}${makoOpacity}";
          border-color = config.lib.stylix.colors.base02-hex;
          text-color = config.lib.stylix.colors.base05-hex;
        };          
        "urgency=normal" = {
          background-color = "${config.lib.stylix.colors.base00-hex}${makoOpacity}";
          border-color = config.lib.stylix.colors.base03-hex;
          text-color = config.lib.stylix.colors.base05-hex;
        };          
        "urgency=critical" = {
          background-color = "${config.lib.stylix.colors.base00-hex}${makoOpacity}";
          border-color = config.lib.stylix.colors.base08-hex;
          text-color = config.lib.stylix.colors.base08-hex;
          default-timeout = 0;
        };
      };
    };
  };
}