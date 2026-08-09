_: {
  services = {
    desktopManager.gnome.enable = true;
    xserver.desktopManager.wallpaper = {
      combineScreens = false;
      mode = "center";
    };
  };
}
