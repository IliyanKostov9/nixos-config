{
  pkgs,
  lib,
  ...
}: {
  console.keyMap = "dvorak";
  services = {
    libinput.enable = true;
    desktopManager.gnome.enable = true;
    # Enable for using I3
    displayManager = {
      # Enable for using GNOME
      gdm = {
        enable = false;
        wayland = true;
      };
      sddm = {
        wayland.enable = true;
        enable = true;
        theme = lib.mkDefault "catppuccin-macchiato";
        package = pkgs.kdePackages.sddm;
      };
    };
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      # Disable screen turning off after 10 mins
      deviceSection = ''
        Option "BlankTime" "0"
        Option "StandbyTime" "0"
        Option "SuspendTime" "0"
        Option "OffTime" "0"
        Option "DPMS" "false"
      '';
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
