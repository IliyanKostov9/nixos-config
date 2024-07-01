{ config, lib, pkgs, ... }:

{
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Enable for using GNOME
    # displayManager.gdm.enable = true;
    # Enable for using I3
    # Fix: lightdm is required to work on work laptop
    displayManager.lightdm.enable = true;
    desktopManager.gnome.enable = true;
    desktopManager.xterm.enable = false;
    windowManager.i3 = {
      enable = true;
      package = pkgs.i3-gaps;
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
  services.libinput.enable = true;
}
