{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.security.yubikey-touch-detector;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.security.yubikey-touch-detector = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = { config, pkgs, lib, ... }: {
      home = {
        file.yubikey-touch-detector-config = {
          text = ''
            GNUPGHOME=${config.programs.gpg.homedir}
            YUBIKEY_TOUCH_DETECTOR_LIBNOTIFY=true
          '';
          target = ".config/yubikey-touch-detector/service.conf";
        };
        packages = [
          pkgs.libnotify
          inputs.yubikey-touch-detector.homeModules.default
        ];
      };
      systemd.user.services = {
        yubikey-touch-detector = {
          Unit = {
            Description = "Detects when your YubiKey is waiting for a touch";
            Requires = "yubikey-touch-detector.socket";
          };
          Service = {
            ExecStart = lib.getExe' inputs.yubikey-touch-detector "yubikey-touch-detector";
            EnvironmentFile = "-%E/yubikey-touch-detector/service.conf";
          };
          Install = {
            Also = "yubikey-touch-detector.socket";
            WantedBy = [ "default.target" ];
          };
        };
      };
      systemd.user.sockets = {
        yubikey-touch-detector = {
          Unit = {
            Description = "Unix socket activation for YubiKey touch detector service";
          };
          Socket = {
            ListenStream = "%t/yubikey-touch-detector.socket";
            RemoveOnStop = "yes";
          };
          Install = {
            WantedBy = [ "sockets.target" ];
          };
        };
      };
    };
  };
}