{ pkgs, lib, ... }:

{
  services = {
    # Enable for using I3
    displayManager.sddm = {
      enable = true;
      theme = lib.mkDefault "catppuccin-macchiato";
      package = pkgs.kdePackages.sddm;
    };
    libinput.enable = true;
    # Enable the X11 windowing system.
    xserver = {
      enable = true;
      # Enable for using GNOME
      # displayManager.gdm.enable = true;

      # Another display manager for i3
      displayManager.lightdm.enable = false;

      # Disable screen turning off after 10 mins
      deviceSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
        Option "DPMS" "false"
      '';
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
        variant = "dvorak";
        # xkbOptions = "ctrl:nocaps";
        # NOTE: Props to: https://github.com/ivangeorgiew for providing the missing Dvorak for bg
        extraLayouts.bgd = {
          description = "Bulgarian";
          languages = [ "bul" ];
          symbolsFile = ../../options/xkb/dvorak/bg;
        };
      };
    };
  };
}
