{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ dialect ];
}
