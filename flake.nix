{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      solaar,
      nixpkgs-stable,
      ...
    }:
    let
      mkSystem =
        {
          hostName,
          username,
          extraModules ? [ ],
          isLaptop ? false,
        }:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs;
            inherit username;
          };
          modules = [
            # Adds pkgs.stable
            {
              nixpkgs.overlays = [
                (final: prev: {
                  stable = import nixpkgs-stable {
                    system = prev.system;
                  };
                })
              ];
            }

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                username = username;
                hostName = hostName;
              };
              home-manager.users.${username} = {
                imports = [
                  ./home
                  ./hosts/${hostName}/home
                ];
              };
            }

            ./hosts/common
            ./hosts/${hostName}
          ]
          ++ (if isLaptop then [ ./hosts/common-laptop ] else [ ])
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        home-pc = mkSystem {
          hostName = "home-pc";
          username = "ramikw";
          extraModules = [ solaar.nixosModules.default ];
        };

        acer-laptop = mkSystem {
          hostName = "acer-laptop";
          username = "ramikw";
          isLaptop = true;
          extraModules = [ ];
        };

      };
    };
}
