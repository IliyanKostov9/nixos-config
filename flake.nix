{
  description = "Home manager and NixOS system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "flake:nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;
      system = "x86_64-linux";
      # nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      # nix.settings.experimental-features = [ "nix-command" "flakes" ];
    in
    {
      homeConfigurations.ikostov2 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/ikostov2
        ];
      };

      nixosConfigurations.ikostov2 = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/personal/desktop
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-cpu-amd
          # nixos-hardware.nixosModules.common-gpu-nvidia
        ];
        inherit system;
      };
    };
}
