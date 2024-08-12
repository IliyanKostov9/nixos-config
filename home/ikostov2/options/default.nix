{ pkgs
, config
, ...
}:

{
  imports = [
    ./git
    ./i3
    # ./mimeApps
    ./alacritty
    # ./terminator
    ./kitty
  ];
}
