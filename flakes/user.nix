{
  self,
  inputs,
  ...
}: let
  shared =
    import ./shared.nix
    {
      inherit inputs;
    };
in {
  flake.homeConfigurations =
    builtins.mapAttrs
    (user: _user-attr:
      inputs.home-manager.lib.homeManagerConfiguration {
        inherit (shared) pkgs;
        extraSpecialArgs = {
          inherit user;
          inherit (shared) stateVersion pkgs-unstable;
        };
        modules =
          [
            ../home
          ]
          ++ (with inputs; [
            nix-index-database.homeModules.nix-index
            sops-nix.homeManagerModules.sops
          ]);
      })
    shared.users;
}
