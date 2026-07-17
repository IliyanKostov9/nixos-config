{
  description = "Iliyan K's NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    devenv.url = "github:cachix/devenv";
    nur.url = "github:nix-community/NUR";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v1.1.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:nix-community/stylix/release-26.05";
    # alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    # nix-alien.url = "github:thiagokokada/nix-alien";
    # nixos-generators = {
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    flake-parts,
    nixpkgs,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux"];

      imports =
        [
          inputs.flake-parts.flakeModules.easyOverlay
          inputs.devenv.flakeModule
          ./flakes/system.nix
          ./flakes/user.nix
          ./tests
          # ./flakes/export-image.nix
        ]
        ++ (
          if !nixpkgs.lib.trivial.inPureEvalMode
          then [
            ./flakes/dev-shell.nix
          ]
          else nixpkgs.lib.trivial.warn "> Cannot activate devShells while in pure eval mode!" []
        );
    };
}
