{ config, lib, pkgs, ... }: 
{
  options = {
    machine.ssh.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.ssh.enable {
    programs.ssh = {
      enable = true;
      #enableDefaultConfig = false; # ????????
      extraOptionOverrides = {
        CanonicalizeHostname = "yes";
        # CanonicalDomains = ""; # ssh server and appends CanonicalDomain automatically
      };
      #matchBlocks."*.${config.machine.domain}" = {
      #  controlMaster = "auto";
      #  controlPath = "\${XDG_RUNTIME_DIR}/ssh/control/%C";
      #  controlPersist = "10m";
      #  forwardAgent = true;
      #};
    };

    systemd.user.tmpfiles.rules = [
      #Type  Path            Mode  User  Group  Age  Argument
      "d     %t/ssh          0700  -     -      -    -"
      "d     %t/ssh/control  0700  -     -      -    -"
    ];
  };
}
