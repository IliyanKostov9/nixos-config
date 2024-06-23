{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ shotwell ];
}
