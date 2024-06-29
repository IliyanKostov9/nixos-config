{ pkgs
, config
, ...
}:
{
  imports = [
    ./build-tools
    ./container
    ./deps
    ./desktop-control-center
    ./editor
    ./langs
    ./scm
  ];
}
