{ inputs, ... }:
{
  flake.nixosConfigurations =
    let
      commonModules = [
        (inputs.import-tree ../modules/linux)
        (inputs.import-tree ../modules/common)
        inputs.home-manager.nixosModules.home-manager
        inputs.disko.nixosModules.disko
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "hm-backup";
            extraSpecialArgs = { inherit inputs; };
          };
        }
      ];

      mkNixosSystem =
        {
          system,
          hostPath,
          extraModules ? [ ],
        }:
        inputs.nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = commonModules ++ extraModules ++ [ hostPath ];
        };
    in
    {
      # Desktop
      "Athena" = mkNixosSystem {
        system = "x86_64-linux";
        hostPath = ./athena;
      };
      
      # Laptop (P1)
      "Odysseus" = mkNixosSystem {
        system = "x86_64-linux";
        hostPath = ./odysseus;
      };

      # Laptop (T480)
      "Icarus" = mkNixosSystem {
        system = "x86_64-linux";
        hostPath = ./icarus;
      };
      
      # Testing Config
      "Test" = mkNixosSystem {
        system = "x86_64-linux";
        hostPath = ./test;
      };

    # Example diff System configs
      # WSL
      # "" = mkNixosSystem {
      #   system = "x86_64-linux";
      #   hostPath = ./;
      #   extraModules = [ inputs.nixos-wsl.nixosModules.default ];
      # };

      # Mac
      # "" = mkNixosSystem {
      #   system = "aarch64-linux";
      #   hostPath = ./;
      #   extraModules = [ inputs.nixos-apple-silicon.nixosModules.default ];
      # };
    };
}
