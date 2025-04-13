{
  pkgs,
  lib,
}:
with lib; let
  # NOTE: UTC+2
  utc-offset = 2;
in {
  hour =
    if (!trivial.inPureEvalMode)
    then
      pkgs.lib.pipe builtins.currentTime [
        (time: builtins.div time 3600)
        (time: builtins.add (time - (builtins.div time 24 * 24)) utc-offset)
      ]
    else warn "> Cannot retrieve the current hour. Setting to 0..." 0;
}
