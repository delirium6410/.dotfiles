{
  description = "Minimal auto-discovery flake";

  outputs = inputs @ { self, nixpkgs, home-manager, ... }: 
  let
    inherit (self) outputs;
  in {
    # Auto-discover NixOS configurations from ./configurations/*
    nixosConfigurations = with nixpkgs.lib;
      pipe ./configurations [
        builtins.readDir
        (mapAttrs' (hostName: _:
          nameValuePair hostName (nixosSystem {
            specialArgs = { inherit inputs outputs; };
            modules = [
              ./configurations/${hostName}
            ] ++ attrValues self.nixosModules;
          })
        ))
      ];

    # Auto-discover Home Manager configurations from ./configurations/*/users/*/home.nix  
    homeConfigurations = with nixpkgs.lib;
      pipe ./configurations [
        builtins.readDir
        (mapAttrs' (hostName: _:
          nameValuePair hostName (
            pipe ./configurations/${hostName}/users [
              builtins.readDir
              attrNames
            ]
          )
        ))
        (concatMapAttrs (hostName: usernames:
          pipe usernames [
            (map (username: {
              name = "${username}@${hostName}";
              value = home-manager.lib.homeManagerConfiguration {
                pkgs = self.nixosConfigurations.${hostName}.pkgs;
                extraSpecialArgs = { inherit inputs outputs; };
                modules = [
                  ./configurations/${hostName}/users/${username}/home.nix
                ] ++ attrValues self.homeModules;
              };
            }))
            listToAttrs
          ]
        ))
      ];

    # Auto-discover modules + flake modules
    nixosModules = with nixpkgs.lib;
      mergeAttrsList [
        (pipe ./modules [
          builtins.readDir
          (mapAttrs' (module: _:
            nameValuePair (removeSuffix ".nix" module) (import ./modules/${module})
          ))
        ])
        
        {
          sops = sops-nix.nixosModules.sops;
          #lanzaboote = lanzaboote.nixosModules.lanzaboote;  
          #impermanence = impermanence.nixosModules.impermanence;
          home-manager = home-manager.nixosModules.home-manager;
        }
      ];

    homeModules = with nixpkgs.lib;
      pipe ./modules/home-manager [
        builtins.readDir  
        (mapAttrs' (module: _:
          nameValuePair (removeSuffix ".nix" module) (import ./modules/home-manager/${module})
        ))
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
    
    #lanzaboote = {
    #  url = "github:nix-community/lanzaboote/v0.4.2";
    #  inputs.nixpkgs.follows = "nixpkgs";
    #};
    
    #impermanence.url = "github:nix-community/impermanence";

    stylix.url = "github:danth/stylix/release-25.05";

  };
}