{ pkgs
, config
, ...
}:
{
  imports = [
    ./alacritty
    # ./terminator
    ./tmux
  ];
}
