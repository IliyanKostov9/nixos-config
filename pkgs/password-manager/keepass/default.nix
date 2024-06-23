{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ keepass ];
}
