{
  description = "Iliyan K's Home manager and NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # nix-alien.url = "github:thiagokokada/nix-alien";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
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
    mission-control.url = "github:Platonic-Systems/mission-control";
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

    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        ./flakes/dev-shell.nix
        ./flakes/system.nix
        ./flakes/user.nix
        ./flakes/export-image.nix
        inputs.mission-control.flakeModule
        ./flakes/mission-control.nix
        # inputs.devshell.flakeModule
      ];
    };

}
