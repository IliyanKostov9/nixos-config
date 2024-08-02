{ lib, config, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = lib.optionalAttrs config.programs.librewolf.enable {
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
      "text/html" = [ "librewolf.desktop" ];
      "video/*" = [ "vlc.desktop" ];
      "image/*" = [ "shotwell-viewer.desktop" "gimp.desktop" ];
    };
  };
}
