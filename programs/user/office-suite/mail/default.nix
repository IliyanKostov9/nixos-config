{ pkgs
, ...
}:
{
  home.packages = with pkgs; [ evolution ];
}
