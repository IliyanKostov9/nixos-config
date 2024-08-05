{
  description = "Iliyan K's Home manager and NixOS config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    # sops-nix.url = "github:Mic92/sops-nix";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "flake:nixos-hardware";
    nix-alien.url = "github:thiagokokada/nix-alien";
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs:
    let
      system = "x86_64-linux";
      stateVersion = "24.05";

      pkgs = import nixpkgs {
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
          extraSpecialArgs = { inherit self system stateVersion user nix-colors; };
          modules = [
            ./home
          ] ++ [ nix-index-database.hmModules.nix-index ];
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
