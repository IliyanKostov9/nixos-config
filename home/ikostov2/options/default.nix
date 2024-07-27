{ pkgs
, config
, ...
}:

{
  imports = [
    ./git
    ./i3
  ];
}
