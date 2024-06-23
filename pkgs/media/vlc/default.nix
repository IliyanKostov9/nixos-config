{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ vlc ];
}
