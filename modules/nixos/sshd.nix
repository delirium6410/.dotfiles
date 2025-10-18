{ config, lib, pkgs, ... }: 
{
  options = {
    machine.sshd.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.sshd.enable {
    services.openssh = {
      enable = true;
      openFirewall = false;
      # https://linux-audit.com/the-real-purpose-of-login-banners-on-linux/
      banner = ''
        You are accessing a private Information System (IS) that is provided for
        owner-authorized use only. By using this IS (which includes any device attached
        to this IS), you consent to the following conditions:

        -The IS owner routinely intercepts and monitors communications on this IS.

        -At any time, the IS owner may inspect and seize data stored on this IS.

        -Communications using, or data stored on, this IS are not private, are subject
        to routine monitoring, interception, and search, and may be disclosed or used
        for any owner-authorized purpose.

        -This IS includes security measures (e.g., authentication and access controls)
        to protect the IS owner's interests--not for your personal benefit or privacy.

      '';
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = false;
        PermitRootLogin = "no";
        #UseDns = true;
      };
    };

    specialisation.expose-ssh.configuration = {
      services.openssh = {
        openFirewall = lib.mkForce true;
        settings.PermitRootLogin = lib.mkForce "prohibit-password";
      };
      users.users.root = {
        shell = lib.mkForce pkgs.bash;
        openssh.authorizedKeys.keys = [
          "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBP1wVmtwowc1Yu6MMTTciKsy4bv4AIMcjQLmtwxQtLjHVWMHrNGgo3OPGn69dmYuJyyYzxoxUEAoPzLsWuha2w0="
        ];
      };
    };
  };
}
