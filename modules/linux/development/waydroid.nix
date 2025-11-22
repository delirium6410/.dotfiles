{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.development.waydroid;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.development.waydroid = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    # https://wiki.nixos.org/wiki/Waydroid
    # sudo waydroid init (add "-s GAPPS -f" to have GApps support)
    virtualisation.waydroid.enable = true; 
    programs.adb.enable = true;
    
    users.users.${username}.extraGroups = [ "adbusers" ];
    boot.kernelModules = [ "binder_linux" "ashmem_linux" ];
  };
}