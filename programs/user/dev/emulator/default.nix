{ pkgs
, config
, ...
}:
{
  imports = [
    ./kitty
    # ./alacritty
    # ./terminator
    ./tmux
  ];
}
