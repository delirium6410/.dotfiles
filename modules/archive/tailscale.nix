{ config, pkgs, lib, ... }:
{
  options = {
    machine.tailscale.enable = lib.mkEnableOption "";
  };

  # configure headscale someday aswell
  config = lib.mkIf config.machine.tailscale.enable {
    services.tailscale = {
      enable = true;
      authKeyFile = lib.mkIf config.machine.secrets.enable config.sops.secrets.tailscale_key.path;
    };
  sops.secrets.tailscale_key = lib.mkIf config.machine.secrets.enable {};
  networking.firewall.trustedInterfaces = ["tailscale0"];
  };
}
