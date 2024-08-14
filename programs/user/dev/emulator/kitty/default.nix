{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ kitty ];
}
