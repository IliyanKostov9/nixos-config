{ config, lib, pkgs, ... }:

{
  services.xserver.desktopManager.wallpaper = {
    combineScreens = false;
    mode = "center";
  };

  services.displayManager.defaultSession = "none+i3";
  # I3 support
  environment.pathsToLink = [ "/libexec" ];
}

