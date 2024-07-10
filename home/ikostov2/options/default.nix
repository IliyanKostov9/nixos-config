{ pkgs
, config
, ...
}:

{
  imports = [
    ./startup-scripts
    ./i3
  ];
}
