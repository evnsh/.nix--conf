{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }@inputs:
    let
      mkSystem = system: nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };
      };
    in
    {
      nixosConfigurations = {
        latte = mkSystem "aarch64-linux" {
          modules = [
            ./machines/latte/configuration.nix
            ./modules/desktop.nix
            ./modules/development.nix
            ./modules/asahi.nix
            ./shared
          ];
        };

        fragile = mkSystem "x86_64-linux" {
          modules = [
            ./machines/fragile/configuration.nix
            ./shared
            disko.nixosModules.disko
          ];
        };
      };
    };
}