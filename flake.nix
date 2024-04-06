{
  description = "My NixOS root flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	nixvim = {
		url = "github:nix-community/nixvim/nixos-23.11";
		inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = args @ {
    self,
    nixpkgs,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;

      config = {
        allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
		system = system;
        modules = [
		  ./configuration.nix
          args.nixos-wsl.nixosModules.wsl
		  args.nixvim.nixosModules.nixvim
        ];
      };
    };
  };
}
