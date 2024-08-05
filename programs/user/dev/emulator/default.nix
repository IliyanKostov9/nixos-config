{ pkgs
, config
, ...
}:
{
  imports = [
    ./terminator
    ./kitty
    ./tmux
  ];
}
