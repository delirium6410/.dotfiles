{ config, lib, ... }: 
{
  users.users.admin = {
    isNormalUser = true;
    home = "/home/admin";
    extraGroups = ["wheel"];
    openssh.authorizedKeys.keys = lib.mkIf config.machine.sshd.enable [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAKEgAIwksnC1KnAzLbc54a2QdoiGad5Rx/h4yPkB6l9"
    ];
  };

  home-manager.users.admin = lib.mkIf config.machine.home-manager.enable (import ./home.nix);
}