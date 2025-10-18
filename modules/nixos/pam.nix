{ config, lib, ... }: 
{
  options = {
    machine.pam.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.pam.enable {
    # set to false later
    security.pam.services.login.unixAuth = true;
    security.pam.services.sudo.unixAuth = true;

    security.pam.u2f = lib.mkIf config.machine.yubikey.enable {
      enable = true;
      settings = {
        origin = "pam://machine";
        appid = "pam://machine";
        authfile = lib.mkDefault (
          builtins.toFile "u2f_mappings" (
            lib.concatMapStringsSep "\n"
            (
              user:
                lib.concatStringsSep ":" [
                  user
                  ""
                ]
            )
            [
              "admin"
            ]
          )
        );
        cue = true;
        pinverification = 1;
      };
    };

    security.pam.services.sudo.rssh = true;
    security.pam.rssh = lib.mkIf config.machine.sshd.enable {
      enable = true;
      settings = {
        auth_key_file = "/etc/ssh/authorized_keys.d/$ruser";
        #cue = true;
      };
    };
  };
}
