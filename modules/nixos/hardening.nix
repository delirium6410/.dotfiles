{ config, pkgs, lib, ... }:
{
  options = {
    machine.hardening.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.hardening.enable {
    # https://docs.arbitrary.ch/security/
    # https://docs.redhat.com/de/documentation/red_hat_enterprise_linux/8/html/security_hardening/index
    boot.kernelParams = [
      "slab_nomerge"
      "init_on_alloc=1" 
      "init_on_free=1"
    ];
  };
}