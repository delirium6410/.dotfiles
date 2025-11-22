{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.system.printing;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.system.printing = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    services.printing.enable = true;
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}