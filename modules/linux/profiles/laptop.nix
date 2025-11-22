{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.profiles.laptop;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.profiles.laptop = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    modules = {
      profiles.desktop.enable = true;
      
      # Laptop
      system.laptop.enable = true;
      system.ppd.enable = true;
    };
  };
}