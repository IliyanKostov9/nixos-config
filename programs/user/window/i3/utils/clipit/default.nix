{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ clipit ];
}
