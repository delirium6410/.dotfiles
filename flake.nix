{
  description = "Homelab";

  outputs = inputs @ { self, nixpkgs, home-manager, sops-nix, impermanence, deploy-rs, ... }: 
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
        # Local modules
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
        
        # Essential flake modules for homelab
        {
          flake-sops-nix = sops-nix.nixosModules.sops;
          flake-home-manager = home-manager.nixosModules.home-manager;
          flake-impermanence = impermanence.nixosModules.impermanence;
          
          home-manager-integration = {
            home-manager = {
              extraSpecialArgs = {inherit inputs outputs;};
              sharedModules = attrsets.attrValues self.homeModules;
            };
          };
        }
      ];

    # Optional but recommended: Home Manager configs
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
                modules = [./configurations/${hostName}/users/${username}/home.nix];
              };
            }))
            builtins.listToAttrs
          ]))
      ];

    homeModules = with nixpkgs.lib;
      pipe ./modules/home-manager [
        builtins.readDir
        (mapAttrs' (homeModule: _:
          nameValuePair (removeSuffix ".nix" homeModule) (import ./modules/home-manager/${homeModule})))
      ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    
    impermanence.url = "github:nix-community/impermanence";
    
    deploy-rs.url = "github:serokell/deploy-rs";
  };
}