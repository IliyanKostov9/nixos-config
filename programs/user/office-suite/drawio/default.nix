{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ drawio ];
}
