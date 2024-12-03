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
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home.users.helmi = import ./hosts/home-manager/home.nix;
            }
          ];
        };

        nixosConfigurations.sp = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/sp7/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.helmi = import ./hosts/home-manager/home.nix;
            }
          ];
        };

        homeConfigurations.home = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./hosts/home-manager/home.nix
          ];
        };
    };
}
