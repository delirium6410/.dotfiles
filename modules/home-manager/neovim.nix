{ config, lib, pkgs, ... }: 
{
  options = {
    machine.neovim.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.neovim.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    
    xdg.desktopEntries.nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "ghostty -e nvim %F";
      terminal = false;
      categories = [ "Utility" "TextEditor" ];
      mimeType = [
        "text/plain"
        "text/x-bash"
        "application/json"
        "text/css" 
        "text/html" 
        "text/x-tex"
        "application/x-shellscript"
        "text/x-nix"
      ];
    };
    
    home.sessionVariables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };
}
