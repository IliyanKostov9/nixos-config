{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ obs-studio ];
}
