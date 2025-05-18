{
  pkgs,
  lib,
  ...
}: {
  console.keyMap = "dvorak";
  services = {
    # Enable for using I3
    displayManager.sddm = {
      wayland.enable = true;
      enable = true;
      theme = lib.mkDefault "catppuccin-macchiato";
      package = pkgs.kdePackages.sddm;
    };
    libinput.enable = true;
    xserver = {
      enable = true;
      # Enable for using GNOME
      displayManager.gdm.enable = false;

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

      # Configure keymap in X11
      xkb = {
        layout = "us";
        # variant = "dvorak,";
        options = "grp:shifts_toggle";
        # NOTE: Props to: https://github.com/ivangeorgiew for providing the missing Dvorak for bg
        extraLayouts.bgd = {
          description = "Bulgarian Dvorak";
          languages = ["bul"];
          symbolsFile = ../../options/xkb/dvorak/bgd;
        };
      };
    };
  };
}
