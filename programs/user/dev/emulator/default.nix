{ pkgs
, config
, ...
}:
{
  imports = [
    ./terminator
    ./alacritty
    ./tmux
  ];
}
