{ pkgs
, config
, ...
}:

{
  gtk.gtk4.extraConfig = {
    gtk-application-prefer-dark-theme = 1;
    gtk-theme-name = "Adwaita-dark";
  };
}
