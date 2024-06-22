{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ vscodium ];
}
