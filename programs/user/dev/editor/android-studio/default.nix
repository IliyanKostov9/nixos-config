{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ android-studio ];
}
