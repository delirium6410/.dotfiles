{ config, pkgs, lib, ... }:
{
  options = {
    machine.core.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.core.enable {
    machine.home-manager.enable = true;
    machine.i18n.enable = true;
    machine.nix.enable = true;
    machine.secrets.enable = true;
    machine.sshd.enable = true;
    machine.sudo-rs.enable = true;
    machine.tailscale.enable = true;

    users.users.root = {
      hashedPassword = "!";
      shell = pkgs.shadow;
    };
  };
}