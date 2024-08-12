{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    rose-pine-icon-theme
    kanagawa-gtk-theme
    xorg.libXcursor
  ];
}
