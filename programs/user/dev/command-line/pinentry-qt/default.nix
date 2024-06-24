{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ pinentry-qt ];
}
