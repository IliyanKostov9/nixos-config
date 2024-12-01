{ pkgs, ... }:
{
  programs = {
    zsh.enable = true;
    gnupg.agent.enable = true;
    virt-manager.enable = true;
    dconf.enable = true;
    adb.enable = true;
    firefox.enable = true;
    # NOTE: Add shady apps to even more sandbox env
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
      };
    };

    # gpaste.enable = true;
    neovim = {
      enable = true;
      defaultEditor = true;
      # BUG: Set to false, because it downloads a nvim pkg copy, and doesn't use the user 'unstable' version
      vimAlias = false;
    };
  };
}
