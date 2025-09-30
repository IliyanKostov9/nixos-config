{
  pkgs,
  pkgs-unstable,
  lib,
  config,
  ...
}:
with lib;
with lib.types; let
  cfg = config.modules.security.firejail;
  search-engine = "https://www.google.com"; # https://duckduckgo.com
  search-provider = "https://www.google.com/search?q={searchTerms}"; # https://duckduckgo.com/?t=h_&q={searchTerms}
  search-provider-suggest = "https://suggestqueries.google.com/complete/search?client=firefox&q={searchTerms}"; # https://duckduckgo.com/?t=h_&q={searchTerms}
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
        homepageLocation = search-engine;
        defaultSearchProviderSearchURL = search-provider;
        defaultSearchProviderSuggestURL = search-provider-suggest;
        extensions = [
          # Dark reader
          "eimadpbcbfnmbkopoojfekhnkhdbieeh"
          # Ublock origin
          "ddkjiahejlhfcafbddmgiahcphecmpfh"
          # Privacy Badger
          # "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"
          # User agent switcher
          "bhchdcejhohfmigjafbampogmaanbfkg"
          # I don't care about cookies
          "fihnjjcciajhdojfnbdddfaoknhalnja"
          # Canvas blocker
          # "nomnklagbgmgghhjidfhnoelnjfndfpd"
        ];
        extraOpts = {
          "ShowHomeButton" = true;
          "RestoreOnStartup" = 1;
          "DefaultBrowserTheme" = 1;
          "HttpsOnlyMode" = "FORCE_ENABLED";
          "AutofillCreditCardEnabled" = false;
          "AutofillCreditCardEnabledForPaymentsIntegration" = false;
          "AutofillProfileEnabled" = false;
          "AutofillAddressEnabled" = false;
          "BlockThirdPartyCookies" = true;
          "HighEfficiencyModeEnabled" = true;
          "MemorySaverModeSavings" = 1;
        };
      };

      firejail = {
        enable = true;
        wrappedBinaries = {
          viber = {
            executable = "${pkgs.viber-appimage}/bin/viber";
            extraArgs = [
              "--noprofile"
              "--env=GTK_THEME=Adwaita:dark"
              "--dbus-user.talk=org.freedesktop.Notifications"
              "--dbus-user.talk=org.freedesktop.ScreenSaver"
              "--dbus-user.talk=org.freedesktop.portal.Desktop"
              "--env=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"
              "--nonewprivs"
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

          chromium = {
            # NOTE: Ungoogled chromium doesn't use the plugins
            executable = "${pkgs.chromium}/bin/chromium";
            profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
            extraArgs = [
              "--env=GTK_THEME=Adwaita:dark"
              "--ignore=nogroups"
              "--env=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"
            ];
          };

          p7zip = {
            executable = "${pkgs.p7zip}/bin/7z";
            extraArgs = [
              "--noprofile"
            ];
          };

          drawio = {
            executable = "${pkgs.drawio}/bin/drawio";
            extraArgs = [
              "--noprofile"
            ];
          };

          keepass = {
            executable = "${pkgs.keepassxc}/bin/keepassxc";
            extraArgs = [
              "--noprofile"
            ];
          };

          normcap = {
            executable = "${pkgs.normcap}/bin/normcap";
            extraArgs = [
              "--noprofile"
            ];
          };

          nomacs = {
            executable = "${pkgs.nomacs}/bin/nomacs";
            desktop = "${pkgs.nomacs}/share/applications/org.nomacs.ImageLounge.desktop";
            extraArgs = [
              "--noprofile"
            ];
          };

          # librewolf = {
          #   executable = "${pkgs.librewolf}/bin/librewolf";
          #   desktop = "${pkgs.librewolf}/share/applications/librewolf.desktop";
          # };
          # signal = {
          #   executable = "${pkgs.signal-desktop}/bin/signal-desktop --enable-features=UseOzonePlatform";
          #   profile = "${pkgs.firejail}/etc/firejail/signal-desktop.profile";
          #   extraArgs = ["--env=GTK_THEME=Adwaita:dark"];
          # };
          # grayjay = {
          #   executable = "${pkgs-unstable.grayjay}/bin/Grayjay";
          #   extraArgs = [
          #     "--noprofile"
          #     "--env=GTK_THEME=Adwaita:dark"
          #     "--dbus-user.talk=org.freedesktop.Notifications"
          #     "--dbus-user.talk=org.freedesktop.ScreenSaver"
          #     "--dbus-user.talk=org.freedesktop.portal.Desktop"
          #     "--env=DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus"
          #   ];
          # };
          # master-pdf = {
          #   executable = "${pkgs.masterpdfeditor4}/bin/masterpdfeditor4";
          #   extraArgs = [
          #     "--noprofile"
          #   ];
          # };
        };
      };
    };
  };
}
