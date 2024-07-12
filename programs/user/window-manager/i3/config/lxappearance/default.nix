{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ lxappearance ];
}
