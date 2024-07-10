{ pkgs
, config
, ...
}:

{
  imports = [
    ./bluetooth
    ./i3
  ];
}
