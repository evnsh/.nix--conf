{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, ... }:
    let
      mkSystem = { system, modules }: nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = { inherit self nixpkgs disko; };
      };
    in
    {
      nixosConfigurations = {
        latte = mkSystem {
          system = "aarch64-linux";
          modules = [
            ./machines/latte/configuration.nix
            ./modules/desktop.nix
            ./modules/development.nix
            ./modules/asahi.nix
          ];
        };

        fragile = mkSystem {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./machines/fragile/configuration.nix
            ./modules/nas.nix
          ];
        };
      };
    };
}