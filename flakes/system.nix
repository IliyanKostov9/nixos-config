{inputs, ...}: let
  shared =
    import ./shared.nix
    {inherit inputs;};
in {
  flake.nixosConfigurations =
    builtins.mapAttrs
    (
      host_name: host_attr:
        inputs.nixpkgs.lib.nixosSystem {
          modules =
            host_attr.modules
            ++ (with inputs; [
              nix-index-database.nixosModules.nix-index
              sops-nix.nixosModules.sops
              lanzaboote.nixosModules.lanzaboote
              stylix.nixosModules.stylix
              {
                config = {
                  nixpkgs.pkgs = shared.pkgs;
                  nix.settings = {
                    trusted-public-keys = [
                      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
                      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
                    ];
                    substituters = [
                      "https://cache.nixos.org"
                      "https://nixpkgs-wayland.cachix.org"
                    ];
                  };
                };
              }
            ]);

          specialArgs = {
            inherit host_name host_attr;
            inherit (shared) pkgs-unstable system stateVersion users;
          };
        }
    )
    shared.config_system.hosts;
}
