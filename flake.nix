{
  description = "Iliyan K's Home manager and NixOS config";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-artwork = {
      url = "github:NixOS/nixos-artwork";
      flake = false;
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs_unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-hardware.url = "flake:nixos-hardware";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nixgl.url = "github:guibou/nixGL";
    nixgl.inputs.nixpkgs.follows = "nixpkgs";
    # nur.url = "github:wiedzmin/NUR";
    # flake-parts.url = "github:hercules-ci/flake-parts";
    # sops-nix.url = "github:Mic92/sops-nix";
    # qnr.url = "github:divnix/quick-nix-registry";
    # devshell.url = "github:numtide/devshell";
    # devshell.inputs.nixpkgs.follows = "nixpkgs";
    # nil.url = "github:oxalica/nil";
    # nix-ros-overlay.url = "github:lopsided98/nix-ros-overlay";
  # nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs = { self, nixpkgs, nixpkgs_unstable, nixgl, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      stateVersion = "24.05";

      pkgs = import nixpkgs {
        inherit system;
        overlays = [ (nixgl.overlay) ];
        config = { allowUnfree = true; };
      };
      pkgs_unstable = import nixpkgs_unstable {
        inherit system;
      };

      lib = pkgs.lib;
      config = import ./config.nix {
        inherit nixos-hardware;
      };
      users = config.users;
    in
    with inputs; {
      # Enter that shell with nix develop --command zsh
      # devShells.x86_64-linux.default = (import ./shell.nix {inherit pkgs;});

      homeConfigurations = builtins.mapAttrs
        (user: _user-attr: home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit self system stateVersion user pkgs_unstable; };
          modules = [
            ./home
          ] ++ [
            nix-index-database.hmModules.nix-index
          ];
        })
        config.users;

      nixosConfigurations = builtins.mapAttrs
        (host: host_attr:
          nixpkgs.lib.nixosSystem {
            modules = host_attr.modules ++ [ nix-index-database.nixosModules.nix-index ];
            specialArgs = { inherit system stateVersion host_attr users; };
          }
        )
        config.hosts;
    };
}
