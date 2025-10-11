{
  description = "Home";

  outputs = inputs @ { self, nixpkgs, home-manager, sops-nix, impermanence, deploy-rs, stylix, ... }:
  let
    inherit (self) outputs;

    forAllSystems = function:
      nixpkgs.lib.genAttrs ["x86_64-linux"] (system: function nixpkgs.legacyPackages.${system});
  in {
    nixosConfigurations = with nixpkgs.lib;
      pipe ./configurations [
        builtins.readDir
        (mapAttrs' (hostName: _:
          nameValuePair hostName (nixosSystem {
            specialArgs = {inherit inputs outputs;};
            modules = [./configurations/${hostName}] ++ attrsets.attrValues self.nixosModules;
          })))
      ];

    nixosModules = with nixpkgs.lib;
      mergeAttrsList [
        (pipe ./modules/nixos [
          builtins.readDir
          (mapAttrs' (nixosModule: _:
            nameValuePair (removeSuffix ".nix" nixosModule) (import ./modules/nixos/${nixosModule})))
        ])

        (pipe ./modules [
          builtins.readDir
          (filterAttrs (name: _: !(builtins.elem name ["nixos" "home-manager"])))
          (mapAttrs' (module: _:
            nameValuePair (removeSuffix ".nix" module) (import ./modules/${module})))
        ])

        {
          flake-sops-nix = sops-nix.nixosModules.sops;
          flake-home-manager = home-manager.nixosModules.home-manager;
          flake-impermanence = impermanence.nixosModules.impermanence;
          flake-stylix = stylix.nixosModules.stylix;
          home-manager-integration = {
            home-manager = {
              extraSpecialArgs = {inherit inputs outputs;};
              sharedModules = attrsets.attrValues self.homeModules;
            };
          };
        }
      ];

    homeConfigurations = with nixpkgs.lib;
      pipe ./configurations [
        builtins.readDir
        (mapAttrs' (hostName: _:
          nameValuePair hostName (
            pipe ./configurations/${hostName}/users [
              builtins.readDir
              builtins.attrNames
            ]
          )))
        (concatMapAttrs (hostName: usernames:
          pipe usernames [
            (map (username: {
              name = "${username}@${hostName}";
              value = home-manager.lib.homeManagerConfiguration {
                pkgs = self.nixosConfigurations.${hostName}.pkgs;
                extraSpecialArgs = {inherit inputs outputs;};
                modules = [
                  ./configurations/${hostName}/users/${username}/home.nix
                ] ++ attrsets.attrValues self.homeModules;
              };
            }))
            builtins.listToAttrs
          ]))
      ];

    homeModules = with nixpkgs.lib;
      mergeAttrsList [
        (pipe ./modules/home-manager [
          builtins.readDir
          (mapAttrs' (homeModule: _:
            nameValuePair (removeSuffix ".nix" homeModule) (import ./modules/home-manager/${homeModule})))
        ])

        (pipe ./modules [
          builtins.readDir
          (filterAttrs (name: _: !(builtins.elem name ["nixos" "home-manager"])))
          (mapAttrs' (module: _:
            nameValuePair (removeSuffix ".nix" module) (import ./modules/${module})))
        ])

        {
        }
      ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix/release-25.05";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  
    yubikey-touch-detector = {
      url = "github:maximbaz/yubikey-touch-detector";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    deploy-rs.url = "github:serokell/deploy-rs";

    nix-gaming.url = "github:fufexan/nix-gaming";
  };
}
