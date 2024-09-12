{ pkgs
, ...
}:
{
  imports = [
    ./macos
    # ./kitty
    ./alacritty
    # ./terminator
    ./tmux
  ];
}
