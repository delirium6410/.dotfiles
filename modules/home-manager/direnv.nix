{ config, lib, ... }: 
{
  options = {
    machine.direnv.enable = lib.mkEnableOption "";
  };

  config = lib.mkIf config.machine.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
