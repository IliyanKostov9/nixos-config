{
  description = "Home manager and NixOS system config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "flake:nixos-hardware";
    nix-alien.url = "github:thiagokokada/nix-alien";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }:
    let
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;
      system = "x86_64-linux";
    in
    {
      homeConfigurations.ikostov2 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit self system; };
        modules = [
          ./home/ikostov2
        ];
      };

      nixosConfigurations.ikostov2-personal-desktop = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/personal/desktop
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-cpu-amd
          # nixos-hardware.nixosModules.common-gpu-nvidia
        ];
        inherit system;
      };
      nixosConfigurations.ikostov2-work-laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/work/laptop
          # nixos-hardware.nixosModules.lenovo-thinkpad-p53
        ];
        inherit system;
      };
    };
}
