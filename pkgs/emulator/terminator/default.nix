{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ terminator ];
}
