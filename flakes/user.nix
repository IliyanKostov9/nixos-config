{
  perSystem =
    { config
    , pkgs
    , system
    , lib
    , inputs
    , ...
    }:
    let
      config = import ../config.nix {
        inherit (inputs) nixos-hardware;
      };
    in
    {
      flake.homeConfigurations = builtins.mapAttrs
        (user: _user-attr: inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit (config) self system stateVersion user pkgs_unstable; };
          modules = [
            ./home
          ] ++ [
            inputs.nix-index-database.hmModules.nix-index
          ];
        })
        config.users;
    };
}
