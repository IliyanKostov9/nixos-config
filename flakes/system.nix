{
  perSystem =
    { config
    , pkgs
    , system
    , lib
    , ...
    }:
    let
      packages = {
        nix-index = config.packages.nix-index-database.nixosModules.nix-index;
      };

      config = import ../config.nix {
        inherit (inputs) nixos-hardware;
      };
    in
    {
      flake.nixosConfigurations = builtins.mapAttrs
        (host: host_attr:
          inputs.nixpkgs.lib.nixosSystem {
            inherit (config) system;
            modules = host_attr.modules ++ [ config.packages.nix-index-database.nixosModules.nix-index ];
            specialArgs = { inherit system stateVersion host_attr users; };
          }
        )
        config.hosts;
    };
}
