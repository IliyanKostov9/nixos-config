{ nixpkgs, alacritty-theme, nixpkgs_unstable, nixgl, nixos-hardware }:

rec {
  system = "x86_64-linux";
  stateVersion = "24.05";

  pkgs = import nixpkgs {
    inherit system;
    overlays = [
      nixgl.overlay
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
