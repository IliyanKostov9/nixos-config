{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ libsForQt5.qt5ct ];
}
