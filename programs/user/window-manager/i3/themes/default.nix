{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    rose-pine-gtk-theme
    rose-pine-icon-theme
    xorg.libXcursor
  ];
}
