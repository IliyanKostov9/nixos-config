{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ qFlipper ];
}
