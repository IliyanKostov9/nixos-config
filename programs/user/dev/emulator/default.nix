{ pkgs
, config
, ...
}:
{
  imports = [ ./terminator ./tmux ];
}
