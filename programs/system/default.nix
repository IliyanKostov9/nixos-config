{ pkgs
, config
, ...
}:
{
  imports = [ ./build-tools ./container ./deps ./editor ./langs ./scm ];
}
