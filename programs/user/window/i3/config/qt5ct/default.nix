{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    libsForQt5.qt5.qtbase
  ];
}
