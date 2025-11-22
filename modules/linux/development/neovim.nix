{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.development.neovim;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.development.neovim = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = {
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

      xdg.mimeApps.defaultApplications = {
        "text/plain" = "nvim.desktop";
        "text/x-c" = "nvim.desktop";
        "text/x-c++" = "nvim.desktop";
        "text/x-python" = "nvim.desktop";
        "text/x-shellscript" = "nvim.desktop";
        "text/x-makefile" = "nvim.desktop";
        "text/x-markdown" = "nvim.desktop";
        "text/markdown" = "nvim.desktop";
        "text/x-tex" = "nvim.desktop";
        "text/x-log" = "nvim.desktop";
        "application/x-yaml" = "nvim.desktop";
        "application/json" = "nvim.desktop";
        "application/toml" = "nvim.desktop";
      };
    };
  };
}