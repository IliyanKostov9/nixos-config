{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ zsh ];
}
