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

  outputs = { self, nixpkgs, nixos-hardware, ... }@inputs:
    let
      pkgs = import nixpkgs {
        inherit system;
      };
      lib = pkgs.lib;

      config = import ./config-flake.nix {
        inherit nixos-hardware pkgs nixpkgs;
      };

      system = "x86_64-linux";
      stateVersion = "24.05";
      default-user = "ikostov2";

    in
    with inputs; {

      homeConfigurations = builtins.mapAttrs
        (user: _user-attr: home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit self system stateVersion user; };
          modules = [
            ./home
          ];
        })
        config.users;

      nixosConfigurations = builtins.mapAttrs
        (host: host_attr:
          nixpkgs.lib.nixosSystem {
            modules = host_attr.modules;
            specialArgs = { inherit system stateVersion host_attr; };
          }
        )
        config.hosts;

      # nixosConfigurations = {
      #   "hosts-personal-desktop" = nixpkgs.lib.nixosSystem {
      #     modules = [
      #       ./hosts/personal/desktop
      #       nixos-hardware.nixosModules.common-pc
      #       nixos-hardware.nixosModules.common-cpu-amd
      #       # nixos-hardware.nixosModules.common-gpu-nvidia
      #     ];
      #     specialArgs = { inherit system stateVersion; };
      #   };
      #
      #   "hosts-work-laptop" = nixpkgs.lib.nixosSystem {
      #     modules = [
      #       ./hosts/work/laptop
      #       # nixos-hardware.nixosModules.lenovo-thinkpad-p53
      #     ];
      #     specialArgs = { inherit system stateVersion; };
      #   };
      #
      # };
    };
}
