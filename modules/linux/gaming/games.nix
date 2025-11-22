{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.modules.gaming.games;
  username = config.modules.users.primaryUser.username;
  inherit (lib) mkEnableOption mkIf;
in
{
  imports = [ inputs.aagl.nixosModules.default ];

  options.modules.gaming.games = {
    airshipper = mkEnableOption "";
    osu = mkEnableOption "";
    prismlauncher = mkEnableOption "";
    r2modman = mkEnableOption "";
    honkers-railway-launcher = mkEnableOption "";
  };

  config = lib.mkMerge [
    {
      home-manager.users.${username} = {
        home.packages = with pkgs; 
          (lib.optional cfg.airshipper airshipper) ++
          (lib.optional cfg.osu osu-lazer-bin) ++
          (lib.optional cfg.prismlauncher prismlauncher) ++
          (lib.optional cfg.r2modman r2modman);
      };
    }
    
    (lib.mkIf cfg.honkers-railway-launcher {
      programs.honkers-railway-launcher.enable = true;
    })
  ];
}