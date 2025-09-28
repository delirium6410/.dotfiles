{ config, lib, ... }: 
{
  options = {
    machine.eza.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.eza.enable {
    programs.eza = {
      enable = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
      ];
    };
    home.shellAliases = {
      ls = "eza";
      tree = "eza --tree";
    };
  };
}
