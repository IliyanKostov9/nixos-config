{ pkgs
, config
, ...
}:
{
  imports = [
    ./terminator
    ./tmux
    ./terminator
  ];
}
