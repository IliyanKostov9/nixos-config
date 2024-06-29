{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ whitesur-gtk-theme ];
}
