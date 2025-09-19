{ ... }: 
{
  networking.hostName = "homelab";

  homelab.core.enable = true;

  # optional, rustdesk, 
  homelab.expenseowl.enable = true;
  homelab.ezBookkeeping.enable = true;
  homelab.guacamole.enable = true;
  homelab.archivebox.enable = true;


  imports =
    [
      ./hardware-configuration.nix
    ]
    ++ map (moduleFile: ./users + ("/" + moduleFile)) (builtins.attrNames (builtins.readDir ./users));

  system.stateVersion = "25.05";
}