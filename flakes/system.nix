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
                nixpkgs.pkgs = shared.pkgs;
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
