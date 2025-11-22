{
  config,
  lib,
  ...
}:
let
  cfg = config.modules.productivity.onlyoffice;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.productivity.onlyoffice = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = { config, lib, ... }: {
      programs.onlyoffice = {
        enable = true;
        settings = lib.mkMerge [
          (lib.mkIf (config.stylix.polarity == "dark") {
            UITheme = "theme-contrast-dark";
          })
          (lib.mkIf (config.stylix.polarity == "light") {
            UITheme = "theme-contrast-light";
          })
        ];
      };

      xdg.mimeApps.defaultApplications = {
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "onlyoffice-desktopeditors.desktop"; # .docx
        "application/msword" = "onlyoffice-desktopeditors.desktop"; # .doc
        "application/rtf" = "onlyoffice-desktopeditors.desktop"; # .rtf
        "application/vnd.oasis.opendocument.text" = "onlyoffice-desktopeditors.desktop"; # .odt
        
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "onlyoffice-desktopeditors.desktop"; # .xlsx
        "application/vnd.ms-excel" = "onlyoffice-desktopeditors.desktop"; # .xls
        "application/vnd.oasis.opendocument.spreadsheet" = "onlyoffice-desktopeditors.desktop"; # .ods
        
        "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "onlyoffice-desktopeditors.desktop"; # .pptx
        "application/vnd.ms-powerpoint" = "onlyoffice-desktopeditors.desktop"; # .ppt
        "application/vnd.oasis.opendocument.presentation" = "onlyoffice-desktopeditors.desktop"; # .odp
      };
    };
  };
}