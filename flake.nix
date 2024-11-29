{
  description = "Iliyan K's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    sops-nix.url = "github:Mic92/sops-nix";
    # nix-alien.url = "github:thiagokokada/nix-alien";
    # nur.url = "github:wiedzmin/NUR";
  };

  outputs = { flake-parts, ... }@inputs:

    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        # ./flakes/dev-shell.nix
        ./flakes/system.nix
        ./flakes/user.nix
        ./flakes/export-image.nix
      ];
    };
}
