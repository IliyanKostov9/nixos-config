{inputs}:
with inputs; rec {
  system = "x86_64-linux";
  stateVersion = "25.05";
  pkgs =
    import
    nixpkgs
    {
      inherit system;
      overlays = [
        # nixgl.overlay
        nur.overlays.default
        alacritty-theme.overlays.default
        (_self: super: {
          qtile-unwrapped = super.qtile-unwrapped.overrideAttrs (_: rec {
            postInstall = let
              qtileSession = ''
                [Desktop Entry]
                Name=Qtile Wayland
                Comment=Qtile on Wayland
                Exec=qtile start -b wayland
                Type=Application
              '';
            in ''
              mkdir -p $out/share/wayland-sessions
              echo "${qtileSession}" > $out/share/wayland-sessions/qtile.desktop
            '';
            passthru.providedSessions = ["qtile"];
          });
        })
      ];
      config = {allowUnfree = true;};
    };
  pkgs-unstable =
    import
    nixpkgs-unstable
    {
      inherit system;
      config = {allowUnfree = true;};
    };

  config_system =
    import
    ../config.nix
    {
      inherit nixos-hardware;
    };
  inherit (config_system) users;
}
