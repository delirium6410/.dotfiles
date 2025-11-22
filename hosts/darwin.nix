{ inputs, ... }:
{
  flake.darwinConfigurations =
    let
      commonModules = [
        (inputs.import-tree ../modules/darwin)
        (inputs.import-tree ../modules/common)
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-backup";
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];

      mkDarwinSystem =
        {
          system,
          hostPath,
          extraModules ? [ ],
        }:
        inputs.nix-darwin.lib.darwinSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = commonModules ++ extraModules ++ [ hostPath ];
        };
    in
    {
      # Example mac System  
      # "" = mkDarwinSystem {
      #   system = "aarch64-darwin";
      #   hostPath = ./mac;
      # };
    };
}
