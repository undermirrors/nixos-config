{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    flashvim.url = "github:flashonfire/nixvim-config";
  };

  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    {
      nixosConfigurations = {
        oui = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = inputs;
          modules = [
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs; };
              home-manager.users.tristantrad = ./home.nix;
            }
          ];
        };
      };

      devShells."x86_64-linux".default =
        let
          pkgs = nixpkgs.legacyPackages."x86_64-linux";
        in
        pkgs.mkShellNoCC {
          packages = with pkgs; [
            just
            nix-tree
          ];
        };

      formatter.x86_64-linux = nixpkgs.legacyPackages."x86_64-linux".nixfmt-tree;
    };
}
