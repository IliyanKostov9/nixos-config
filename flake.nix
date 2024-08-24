{
  description = "Iliyan K's Home manager and NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "flake:nixos-hardware";
    nix-alien.url = "github:thiagokokada/nix-alien";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-artwork = {
      url = "github:NixOS/nixos-artwork";
      flake = false;
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl = {
      url = "github:guibou/nixGL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    # nur.url = "github:wiedzmin/NUR";
    # sops-nix.url = "github:Mic92/sops-nix";
    # qnr.url = "github:divnix/quick-nix-registry";
    # devshell.url = "github:numtide/devshell";
    # devshell.inputs.nixpkgs.follows = "nixpkgs";
    # nil.url = "github:oxalica/nil";
    # nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay";
    # nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };


  outputs = { flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } ({ self, lib, ... }: {
      systems = [ "x86_64-linux" "aarch64-linux" ];
      #  nixpkgs.lib.systems.flakeExposed
      imports = [
        # self.flakeModules.default
        # inputs.devshell.flakeModule
        ./flakes/system.nix
        # ./flakes/user.nix

      ];
      perSystem = { config, self', inputs', pkgs, lib, system, nixpkgs, nixpkgs_unstable, nixgl, ... }:
        {
          # _module.args.pkgs = import inputs.nixpkgs {
          #   inherit system;
          #   overlays = [ (import inputs.rust-overlay) ];
          # };
          #
          # packages = {
          #   rust-toolchain-stable = pkgs.rust-bin.stable.latest.minimal.override {
          #     extensions = [
          #       "rust-src"
          #       "clippy"
          #       "rust-analyzer"
          #     ];
          #   };
          # system = "x86_64-linux";
          # system = config.nixpkgs.hostPlatform.system;
          # stateVersion = "24.05";
          #
          # pkgs = import nixpkgs {
          #   inherit system;
          #   overlays = [ (nixgl.overlay) ];
          #   config = { allowUnfree = true; };
          # };
          # pkgs_unstable = import nixpkgs_unstable {
          #   inherit system;
          # };
          #
          # lib = pkgs.lib;

          devShells.default = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [ terraform wget bat nixpkgs-fmt ];
          };

          devShells.another_env = pkgs.mkShell {
            nativeBuildInputs = with pkgs; [ curl ];
          };
        };
    });
}
