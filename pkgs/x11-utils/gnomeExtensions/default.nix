{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    indicator-gtk3
    gnome.gnome-software
    gnomeExtensions.dock-from-dash
    gnomeExtensions.zen
    gnomeExtensions.search-light
    gnomeExtensions.window-title-is-back
    gnomeExtensions.user-themes
  ];
}
