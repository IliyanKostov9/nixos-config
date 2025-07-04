{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.security.firejail;
in {
  options.modules.security.firejail = {
    enable = mkOption {
      type = bool;
      default = false;
      description = mkDoc ''
        Enable firejail
      '';
    };
  };

  # NOTE: Add shady apps to even more sandbox env
  config = mkIf cfg.enable {
    programs = {
      chromium = {
        enable = true;
        homepageLocation = "https://duckduckgo.com";
        defaultSearchProviderSearchURL = "https://duckduckgo.com/?t=h_&q={searchTerms}";
        defaultSearchProviderSuggestURL = "https://duckduckgo.com/?t=h_&q={searchTerms}";
        extensions = [
          # Dark reader
          "eimadpbcbfnmbkopoojfekhnkhdbieeh"
          # Ublock origin
          "ddkjiahejlhfcafbddmgiahcphecmpfh"
          # Privacy Badger
          "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"
          # User agent switcher
          "bhchdcejhohfmigjafbampogmaanbfkg"
          # I don't care about cookies
          "fihnjjcciajhdojfnbdddfaoknhalnja"
          # Canvas blocker
          # "nomnklagbgmgghhjidfhnoelnjfndfpd"
        ];
      };

      firejail = {
        enable = true;
        wrappedBinaries = {
          grayjay = {
            executable = "${pkgs.grayjay}/bin/Grayjay";
            extraArgs = [
              "--noprofile"
              "--env=GTK_THEME=Adwaita:dark"
              "--dbus-user.talk=org.freedesktop.Notifications"
              "--dbus-user.talk=org.freedesktop.ScreenSaver"
              "--dbus-user.talk=org.freedesktop.portal.Desktop"
              "--env=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"
            ];
          };
          viber = {
            executable = "${pkgs.viber}/bin/viber";
            desktop = "${pkgs.viber}/share/applications/viber.desktop";
            extraArgs = [
              "--noprofile"
              "--env=GTK_THEME=Adwaita:dark"
              "--dbus-user.talk=org.freedesktop.Notifications"
              "--dbus-user.talk=org.freedesktop.ScreenSaver"
              "--dbus-user.talk=org.freedesktop.portal.Desktop"
              "--env=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"
              "--nonewprivs"
              "--noblacklist=/dev/video0"
              "--noblacklist=/dev/video1"
              "--private-dev"
              "--private-cache"
            ];
          };

          whatsapp = {
            executable = "${pkgs.whatsie}/bin/whatsie";
            desktop = "${pkgs.whatsie}/share/applications/whatsie.desktop";
            extraArgs = [
              "--noprofile"
              "--env=GTK_THEME=Adwaita:dark"
              "--dbus-user.talk=org.freedesktop.Notifications"
              "--dbus-user.talk=org.freedesktop.ScreenSaver"
              "--dbus-user.talk=org.freedesktop.portal.Desktop"
              "--env=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"
            ];
          };

          signal = {
            executable = "${pkgs.signal-desktop}/bin/signal-desktop --enable-features=UseOzonePlatform";
            profile = "${pkgs.firejail}/etc/firejail/signal-desktop.profile";
            extraArgs = ["--env=GTK_THEME=Adwaita:dark"];
          };

          chromium = {
            # NOTE: Ungoogled chromium doesn't use the plugins
            executable = "${pkgs.chromium}/bin/chromium";
            profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
            extraArgs = [
              "--env=GTK_THEME=Adwaita:dark"
              "--dbus-user.talk=org.freedesktop.Notifications"
              "--dbus-user.talk=org.freedesktop.ScreenSaver"
              "--dbus-user.talk=org.freedesktop.portal.Desktop"
              "--env=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"
            ];
          };

          librewolf = {
            executable = "${pkgs.librewolf}/bin/librewolf";
            desktop = "${pkgs.librewolf}/share/applications/librewolf.desktop";
          };
        };
      };
    };
  };
}
