{ config, pkgs, lib, ... }:
{
  options = {
    machine.nix-ld.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        openssl
        curl
        glib
      ];
    };
  };
}