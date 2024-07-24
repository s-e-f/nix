{
  description = "My NixOS root flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kanagawa = {
      type = "github";
      owner = "s-e-f";
      repo = "kanagawa.nvim";
      flake = false;
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      nixos-wsl,
      home-manager,
      kanagawa,
      flake-utils,
      ...
    }@inputs:
    {
      nixosConfigurations = {

        wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            nixos-wsl.nixosModules.default
            {
              wsl.enable = true;
              system.stateVersion = "24.05";
            }

            ./wsl/configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.sef = import ./wsl/home.nix;
                extraSpecialArgs = {
                  inherit inputs;
                };
              };
            }
          ];
        };

        nixos = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit inputs;
          };
          modules = [
            ./nixos/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                users.sef = import ./nixos/home.nix;
                extraSpecialArgs = {
                  inherit inputs;
                };
              };
            }
          ];
        };

      };
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            vscode-langservers-extracted
            nil
            nixfmt-rfc-style
          ];
        };
      }
    );
}
