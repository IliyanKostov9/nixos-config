{
  description = "Iliyan K's Home manager and NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    nix-alien.url = "github:thiagokokada/nix-alien";
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
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nur.url = "github:wiedzmin/NUR";
    # sops-nix.url = "github:Mic92/sops-nix";
    # devshell.url = "github:numtide/devshell";
    # devshell.inputs.nixpkgs.follows = "nixpkgs";
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
        # inputs.devshell.flakeModule
      ];
    };

}
