{ config, lib, ... }: 
{
  # users.allowNoPasswordLogin = true;
  users.users.admin = {
    isNormalUser = true;
    home = "/home/admin";
    initialHashedPassword = "$6$r0yqsPZIvinA.V27$5PRURPAT/relNymk63H9DOond9EIEZxxAkLOswe1P4zL5koLN/95Dd0kULldQK7qP17h.LAh9YDBHNc1A1IGk0";
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "input" ];
    #openssh.authorizedKeys.keys = lib.mkIf config.machine.sshd.enable [
    #  "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKEgAIwksnC1KnAzLbc54a2QdoiGad5Rx/h4yPkB6l9"
    #];
  };

  home-manager.users.admin = lib.mkIf config.machine.home-manager.enable (import ./home.nix);
}