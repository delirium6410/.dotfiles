{ config, pkgs, lib, inputs, ... }:
let
  secretspath = builtins.toString inputs.mysecrets; # mysecrets where defined??
in 
{
  options = {
    machine.secrets.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.secrets.enable {
    sops = {
      defaultSopsFile = "${secretspath}/secrets.yaml";
      validateSopsFiles = false;

      age = {
        sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
        keyFile = "/var/lib/sops-nix/key.txt";
        generateKey = true;
      };
    };
  };
}