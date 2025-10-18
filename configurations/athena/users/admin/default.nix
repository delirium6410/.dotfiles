{ config, lib, ... }: 
{
  users.users.admin = {
    isNormalUser = true;
    home = "/home/admin";
    initialHashedPassword = "$6$r0yqsPZIvinA.V27$5PRURPAT/relNymk63H9DOond9EIEZxxAkLOswe1P4zL5koLN/95Dd0kULldQK7qP17h.LAh9YDBHNc1A1IGk0";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "input" ];
    openssh.authorizedKeys.keys = lib.mkIf config.machine.sshd.enable [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBP1wVmtwowc1Yu6MMTTciKsy4bv4AIMcjQLmtwxQtLjHVWMHrNGgo3OPGn69dmYuJyyYzxoxUEAoPzLsWuha2w0="
    ];
  };

  home-manager.users.admin = lib.mkIf config.machine.home-manager.enable (import ./home.nix);
}