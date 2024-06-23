{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ htop ];
}
