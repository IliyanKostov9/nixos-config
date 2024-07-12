{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ nnn ];
}
