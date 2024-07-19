{ config, lib, pkgs, ... }:

{
  # Enable for using I3
  services.displayManager.sddm.enable = true;
  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    # Enable for using GNOME
    # displayManager.gdm.enable = true;
    # Another display manager for i3
    displayManager.lightdm.enable = false;
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
