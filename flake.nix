{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, ... }:
    {
      nixosConfigurations = {
        latte = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          modules = [
            ./machines/latte/configuration.nix
            ./modules/desktop.nix
            ./modules/development.nix
            ./modules/asahi.nix
            ./shared
          ];
        };

        fragile = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./machines/fragile/configuration.nix
            ./shared
            disko.nixosModules.disko
          ];
        };
      };
    };
}