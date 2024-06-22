{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ gpick ];
}
