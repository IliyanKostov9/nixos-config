{ pkgs, ... }:

{
  services = {
    # Enable for using I3
    displayManager.sddm.enable = true;
    libinput.enable = true;
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      # Enable for using GNOME
      # displayManager.gdm.enable = true;
      # Another display manager for i3
      displayManager.lightdm.enable = false;
      desktopManager = {
        xterm.enable = false;
        gnome.enable = true;
      };
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          rofi
        ];
      };

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

  };
}
