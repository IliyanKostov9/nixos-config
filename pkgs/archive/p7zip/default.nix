{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ p7zip ];
}
