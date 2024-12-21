{ pkgs, lib, config, ... }:
with lib;
with lib.types;
let cfg = config.modules.security.firejail;
in
{
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
      # INFO: Chromium policies
      chromium = {
        enable = true;
        homepageLocation = "https://duckduckgo.com";
        defaultSearchProviderSearchURL = "https://duckduckgo.com/?t=h_&q={searchTerms}";
        extensions = [
          # Dark reader
          "eimadpbcbfnmbkopoojfekhnkhdbieeh"
          # Ublock origin
          "cjpalhdlnbpafiamejdnhcphjbkeiagm"
          # Privacy Badger
          "pkehgijcmpdhfbdbbnkijodmdjhbjlgp"
          # User agent switcher
          "bhchdcejhohfmigjafbampogmaanbfkg"
          # Canvas blocker
          "nomnklagbgmgghhjidfhnoelnjfndfpd"
        ];
      };

      firejail = {
        enable = true;
        wrappedBinaries = {
          # NOTE: commented because home manager is managing librewolf
          # librewolf = {
          #   executable = "${pkgs.librewolf}/bin/librewolf";
          #   # profile = "${pkgs.firejail}/etc/firejail/librewolf.profile";
          #   desktop = "${pkgs.librewolf}/share/applications/librewolf.desktop";
          #   extraArgs = [
          #     "--ignore=private-dev"
          #     "--env=GTK_THEME=Adwaita:dark"
          #     "--dbus-user.talk=org.freedesktop.Notifications"
          #   ];
          # };

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
            ];
          };

          chromium = {
            executable = "${pkgs.chromium}/bin/chromium";
            profile = "${pkgs.firejail}/etc/firejail/chromium.profile";
          };
        };
      };
    };
  };
}
