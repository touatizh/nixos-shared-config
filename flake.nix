{
  description = "NixOS Config with Flakes and Home Manager";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  # Flake outputs
  outputs = { self, nixpkgs, home-manager, ... }:
    let

      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

    in
    {
        nixosConfigurations.gigaos = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/gigaos/configuration.nix
            home-manager.nixosModules.home-manager
          ];
        };

        homeConfigurations.gigaosHome = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/gigaos/home-manager/home.nix
          ];
        };

        nixosConfigurations.sp7 = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/sp7/configuration.nix
            home-manager.nixosModules.home-manager
          ];
        };

        homeConfigurations.spHome = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/sp7/home-manager/home.nix
          ];
        };
    };
}
