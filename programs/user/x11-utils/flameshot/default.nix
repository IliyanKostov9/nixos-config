{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ flameshot ];
}
