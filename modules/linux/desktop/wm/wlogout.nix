{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.desktop.wlogout;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  options.modules.desktop.wlogout = {
    enable = mkEnableOption "";
  };

  config = mkIf cfg.enable {
    home-manager.users.${username} = { config, ... }: {
      programs.wlogout = {
        enable = true;
        layout = [
          {
            label = "lock";
            action = "hyprlock";
            text = "Lock";
            keybind = "l";
          }
          {
            label = "hibernate";
            action = "systemctl hibernate";
            text = "Hibernate";
            keybind = "h";
          }
          {
            label = "logout";
            action = "hyprctl dispatch exit";
            text = "Logout";
            keybind = "e";
          }
          {
            label = "shutdown";
            action = "systemctl poweroff";
            text = "Shutdown";
            keybind = "s";
          }
          {
            label = "suspend";
            action = "systemctl suspend";
            text = "Suspend";
            keybind = "u";
          }
          {
            label = "reboot";
            action = "systemctl reboot";
            text = "Reboot";
            keybind = "r";
          }
        ];

        style = ''
          * {
            background-image: none;
            box-shadow: none;
            text-shadow: none;
            transition: 20ms;
          }

          window {
            background-color: rgba(${config.lib.stylix.colors.base00-rgb-r}, ${config.lib.stylix.colors.base00-rgb-g}, ${config.lib.stylix.colors.base00-rgb-b}, 0.9);
          }

          button {
            color: #${config.lib.stylix.colors.base05-hex};
            background-color: #${config.lib.stylix.colors.base01-hex};
            border-style: solid;
            border-width: 2px;
            background-repeat: no-repeat;
            background-position: center;
            background-size: 25%;
            border-radius: 0px;
            margin: 5px;
            border-color: #${config.lib.stylix.colors.base03-hex};
          }

          button:hover {
            background-color: #${config.lib.stylix.colors.base02-hex};
            outline-style: none;
            border-color: #${config.lib.stylix.colors.base04-hex};
          }

          button:focus {
            background-color: #${config.lib.stylix.colors.base01-hex};
            color: #${config.lib.stylix.colors.base06-hex};
            outline-style: none;
            border-color: #${config.lib.stylix.colors.base04-hex};
          }

          button:active {
            background-color: #${config.lib.stylix.colors.base02-hex};
            outline-style: none;
            border-color: #${config.lib.stylix.colors.base04-hex};
          }

          #lock {
            background-image: image(url("icons/lock.png"));
          }
          #logout {
            background-image: image(url("icons/logout.png"));
          }
          #suspend {
            background-image: image(url("icons/suspend.png"));
          }
          #hibernate {
            background-image: image(url("icons/hibernate.png"));
          }
          #shutdown {
            background-image: image(url("icons/shutdown.png"));
          }
          #reboot {
            background-image: image(url("icons/reboot.png"));
          }
        '';
      };

      home.file.".config/wlogout/icons" = {
        source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/.config/wlogout/icons";
        recursive = true;
      };
    };
  };
}