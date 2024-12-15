{ inputs }:

with inputs;
rec {
  system = "x86_64-linux";
  stateVersion = "24.11";
  pkgs =
    import
      nixpkgs
      {
        inherit system;
        overlays = [
          nixgl.overlay
          nur.overlays.default
          alacritty-theme.overlays.default
        ];
        config = { allowUnfree = true; };
      };
  pkgs_unstable = import
    nixpkgs_unstable
    {
      inherit system;
      config = { allowUnfree = true; };
    };

  config_system = import
    ../config.nix
    {
      inherit nixos-hardware;
    };
  inherit (config_system) users;
}
