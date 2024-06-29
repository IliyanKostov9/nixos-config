{ config, lib, pkgs, ... }:

{
  services.xserver.desktopManager.wallpaper = {
    combineScreens = false;
    mode = "center";
  };
  # I3 support
  environment.pathsToLink = [ "/libexec" ];
}

