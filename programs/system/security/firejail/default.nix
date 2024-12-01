{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.security.firejail;
in
{
  options.modules.security.firejail = { enable = mkEnableOption "firejail"; };

  # NOTE: Add shady apps to even more sandbox env
  config = mkIf cfg.enable {
    firejail = {
      enable = true;
      wrappedBinaries = {
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
          desktop = "${pkgs.chromium}/share/applications/chromium.desktop";
          profile = "${pkgs.chromium}/etc/firejail/chromium.profile";
        };
      };
    };
  };
}
