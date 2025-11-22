{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.system.kernel;
  inherit (lib) mkEnableOption mkIf mkDefault;
in
{
  options.modules.system.kernel = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    boot = {
      kernelPackages = mkDefault pkgs.linuxPackages;
    };
  };
}