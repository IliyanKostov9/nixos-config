{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ neofetch ];
}
