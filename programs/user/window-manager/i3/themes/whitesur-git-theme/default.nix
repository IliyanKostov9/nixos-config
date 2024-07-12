{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ whitesur-gtk-theme whitesur-icon-theme ];
}
