{inputs}:
with inputs; rec {
  system = "x86_64-linux";
  stateVersion = "25.11";
  pkgs =
    import
    nixpkgs
    {
      inherit system;
      overlays = [
        (
          # NOTE: Thanks to https://github.com/Fractal-Tess/nixos/blob/83fc507c503ccb3bb34933c3e1ade454a777cb47/overlays/viber.nix#L4
          _self: super: {
            viber-appimage = super.stdenv.mkDerivation {
              pname = "viber-appimage";
              version = "latest";
              src = super.fetchurl {
                url = "https://download.cdn.viber.com/desktop/Linux/viber.AppImage";
                sha256 = "sha256-jwsePK1l/WI+stDNpAD1t2Obr1BwpNDP0nzkIDfGGoA="; # Verified hash
              };
              buildInputs = [super.appimage-run super.makeWrapper];
              dontUnpack = true;

              installPhase = ''
                mkdir -p $out/bin
                cp $src $out/viber.AppImage
                makeWrapper ${super.appimage-run}/bin/appimage-run $out/bin/viber \
                  --add-flags "$out/viber.AppImage"
              '';

              meta = {
                description = "Viber official AppImage (wrapped for NixOS)";
                homepage = "https://www.viber.com/";
                license = super.lib.licenses.unfree;
                maintainers = with super.lib.maintainers; [];
                platforms = [system];
              };
            };
          }
        )
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
      config = {
        allowUnfree = true;
        permittedInsecurePackages = [
          "qtwebengine-5.15.19"
        ];
      };
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
