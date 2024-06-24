{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ i3 ];
}
