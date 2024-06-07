{
  description = "My NixOS root flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nixos-wsl
    , home-manager
    , ...
    } @ args: {
      nixosConfigurations = {
        desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit args; };
          modules =
            [
              nixos-wsl.nixosModules.default
              {
                wsl.enable = true;
                system.stateVersion = "24.05";
              }

              ./wsl.nix

              ./dotnet-ascii-fix.nix

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.sef = import ./home.nix;
                  extraSpecialArgs = {
                    inherit args;
                    obsidian_vaults = "/mnt/c/Users/sef/Documents/obsidian-vaults";
                  };
                };
              }
            ];
        };
        laptop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit args; };
          modules =
            [
              nixos-wsl.nixosModules.default
              {
                wsl.enable = true;
                system.stateVersion = "24.05";
              }

              ./wsl.nix

              ./dotnet-ascii-fix.nix

              home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  users.sef = import ./home.nix;
                  extraSpecialArgs = {
                    inherit args;
                    obsidian_vaults = "/mnt/c/Users/SeverinFitriyadi/Documents/obsidian-vaults";
                  };
                };
              }
            ];
        };
      };
    };
}
