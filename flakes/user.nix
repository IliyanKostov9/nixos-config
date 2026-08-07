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
        # pkgs = shared.pkgs-2511;
        inherit (shared) pkgs;
        extraSpecialArgs = {
          inherit self user;
          inherit (shared) system stateVersion pkgs-2511 pkgs-unstable;
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
