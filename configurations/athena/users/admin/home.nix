{ ... }: 
{
  machine.core.enable = true;
  
  machine.bitwarden.enable = true;
  machine.brave.enable = true;
  machine.discord.enable = true;
  machine.firefox.enable = true;
  machine.gaming.enable = true;
  machine.onlyoffice.enable = true;
  machine.thunderbird.enable = true;
  machine.vscode.enable = true;
  machine.stylix.enable = true;

  home = {
    username = "admin";
    homeDirectory = "/home/admin";
    keyboard.variant = "de";

    stateVersion = "25.05";
  };
}
