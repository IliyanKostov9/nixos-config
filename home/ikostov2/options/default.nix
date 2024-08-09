{ pkgs
, config
, ...
}:

{
  imports = [
    ./git
    ./i3
    # ./mimeApps
    ./terminator
  ];
}
