{ ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = [ "librewolf.desktop" ];
      "x-scheme-handler/https" = [ "librewolf.desktop" ];
      "text/html" = [ "librewolf.desktop" ];

      # Image viewer
      "image/png" = [ "gimp.desktop" ];
      "image/jpeg" = [ "gimp.desktop" ];
      "image/gif" = [ "gimp.desktop" ];

      "video/mp4" = [ "vlc.desktop" ];
      "video/x-matroska" = [ "vlc.desktop" ];
      "video/x-msvideo" = [ "vlc.desktop" ];

      "audio/mpeg" = [ "vlc.desktop" ];
      "audio/x-wav" = [ "vlc.desktop" ];
    };
  };
}
