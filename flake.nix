{
  description = "Home manager and NixOS system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachSystem ["x86_64-linux"] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        lib = pkgs.lib;

        # Define the NixOS configuration
        nixosConfiguration = hostname: {
          nixosModulesPath = "${pkgs.path}/nixos/modules"; 
          modules = [
            ./hosts/personal/desktop/${hostname}
            ({
              modulesPath, ... }: {
                imports = [
                  (modulesPath + "/profiles/minimal.nix")
                ];
              })
          ];
        };

      in {
        homeConfigurations.ikostov2 = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
          ./users/ikostov2
          ];
        };

        nixosConfigurations.mySystem = lib.nixosSystem {
          inherit system pkgs;
          modules = [
            nixosConfiguration "desktop"
          ];
        };
      });
}
