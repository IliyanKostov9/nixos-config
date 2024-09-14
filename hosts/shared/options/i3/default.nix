{ ... }:

{
  services.xserver.desktopManager.wallpaper = {
    combineScreens = false;
    mode = "center";
  };

  services.displayManager.defaultSession = "none+i3";
  environment.pathsToLink = [ "/libexec" ];
}

