{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = true;
    # displayManager.defaultSession = "none+i3";
    windowManager.i3 = {
      enable = false;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
      ];
    };
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };

  };
  # I3 support
  environment.pathsToLink = [ "/libexec" ];

}
