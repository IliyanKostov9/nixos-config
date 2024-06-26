{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ wineWowPackages.waylandFull ];
}

