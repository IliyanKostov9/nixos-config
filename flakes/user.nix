{
  perSystem =
    { config
    , pkgs
    , system
    , lib
    , ...
    }:
    let
      config = import ../config.nix {
        inherit (inputs) nixos-hardware;
      };
    in
    {
      flake.homeConfigurations = builtins.mapAttrs
        (user: _user-attr: home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit (config) self system stateVersion user pkgs_unstable; };
          modules = [
            ./home
          ] ++ [
            nix-index-database.hmModules.nix-index
          ];
        })
        config.users;
    };
}
