{ ... }: 
{
  machine.core.enable = true;

  home = {
    username = "admin";
    homeDirectory = "/home/admin";
    keyboard.variant = "de";

    stateVersion = "25.05";
  };

  nixpkgs.config = {
    allowUnfree = false;
    allowUnfreePredicate = _: false;
  };
}