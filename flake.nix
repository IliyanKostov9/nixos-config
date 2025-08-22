{
  description = "Iliyan K's NixOS config";

  inputs = {
    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    devenv.url = "github:cachix/devenv";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    sops-nix.url = "github:Mic92/sops-nix";
    stylix.url = "github:nix-community/stylix/release-25.05";
    # nixgl = {
    #   url = "github:guibou/nixGL";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # nix-alien.url = "github:thiagokokada/nix-alien";
    # nixos-generators = {
    #   url = "github:nix-community/nixos-generators";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };

  outputs = {
    flake-parts,
    devenv,
    nixpkgs,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports =
        [
          inputs.flake-parts.flakeModules.easyOverlay
          inputs.devenv.flakeModule
          ./flakes/system.nix
          ./flakes/user.nix
          # ./flakes/export-image.nix
          ./tests
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
