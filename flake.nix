{
  description = "Iliyan K's NixOS config";

  inputs = {
    devenv-root = {
      url = "file+file:///dev/null";
      flake = false;
    };
    devenv.url = "github:cachix/devenv";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    nur.url = "github:nix-community/NUR";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
    sops-nix.url = "github:Mic92/sops-nix";
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

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = {
    flake-parts,
    devenv,
    devenv-root,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["x86_64-linux" "aarch64-linux"];

      imports = [
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.devenv.flakeModule
        # ./flakes/dev-shell.nix
        ./flakes/system.nix
        ./flakes/user.nix
        # ./flakes/export-image.nix
        ./tests
      ];

      perSystem = {
        config,
        self',
        inputs',
        pkgs,
        system,
        ...
      }: {
        devenv.shells.default = {
          name = "NixOS devenv";
          git-hooks.hooks = {
            # Common
            actionlint.enable = true;
            checkmake.enable = true;
          };
          devenv.root = let
            devenvRootFileContent = builtins.readFile inputs.devenv-root.outPath;
          in
            pkgs.lib.mkIf (devenvRootFileContent != "") devenvRootFileContent;
        };
      };
    };
}
