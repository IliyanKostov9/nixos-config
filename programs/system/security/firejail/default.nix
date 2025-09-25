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
    # NOTE: Use up to date package for Viber
    services.flatpak.enable = false;
    # flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    # flatpak install flathub com.viber.Viber
    # flatpak override --user com.viber.Viber --device=all
    # flatpak run com.viber.Viber
    # flatpak run  com.github.tchx84.Flatseal

    programs = {
      chromium = {
        enable = true;
        # homepageLocation = "https://duckduckgo.com";
        # defaultSearchProviderSearchURL = "https://duckduckgo.com/?t=h_&q={searchTerms}";
        # defaultSearchProviderSuggestURL = "https://duckduckgo.com/?t=h_&q={searchTerms}";
        homepageLocation = "https://www.google.com";
        defaultSearchProviderSearchURL = "https://www.google.com/search?q={searchTerms}";
        defaultSearchProviderSuggestURL = "https://suggestqueries.google.com/complete/search?client=firefox&q={searchTerms}";
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

          # signal = {
          #   executable = "${pkgs.signal-desktop}/bin/signal-desktop --enable-features=UseOzonePlatform";
          #   profile = "${pkgs.firejail}/etc/firejail/signal-desktop.profile";
          #   extraArgs = ["--env=GTK_THEME=Adwaita:dark"];
          # };

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

          # librewolf = {
          #   executable = "${pkgs.librewolf}/bin/librewolf";
          #   desktop = "${pkgs.librewolf}/share/applications/librewolf.desktop";
          # };

          vlc = {
            executable = "${pkgs.vlc}/bin/vlc";
            extraArgs = [
              "--noprofile"
              "--env=GTK_THEME=Adwaita:dark"
              "--dbus-user.talk=org.freedesktop.Notifications"
              "--dbus-user.talk=org.freedesktop.ScreenSaver"
              "--dbus-user.talk=org.freedesktop.portal.Desktop"
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

          # master-pdf = {
          #   executable = "${pkgs.masterpdfeditor4}/bin/masterpdfeditor4";
          #   extraArgs = [
          #     "--noprofile"
          #   ];
          # };

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

          libreoffice = {
            executable = "${pkgs.libreoffice}/bin/libreoffice";
            desktop = "${pkgs.libreoffice}/share/applications/base.desktop";
            extraArgs = [
              "--noprofile"
            ];
          };

          okular = {
            executable = "${pkgs.kdePackages.okular}/bin/okular";
            desktop = "${pkgs.kdePackages.okular}/share/applications/org.kde.okular.desktop";
            extraArgs = [
              "--noprofile"
            ];
          };
        };
      };
    };
  };
}
