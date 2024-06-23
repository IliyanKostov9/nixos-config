{ pkgs
, config
, ...
}:
{
  home.packages = with pkgs; [ tmux ];
}
