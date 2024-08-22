{ pkgs, ... }:
{
  # Use it in cases of these errors:
  # libGL error: unable to load driver: i965_dri.so
  # libGL error: driver pointer missing
  # libGL error: failed to load driver: i965
  # libGL error: unable to load driver: i965_dri.so
  # libGL error: driver pointer missing
  # libGL error: failed to load driver: i965
  # libGL error: unable to load driver: swrast_dri.so
  # libGL error: failed to load driver: swrast

  home.packages = with pkgs; [
    # After that do `nixGLIntel obs or any other program`
    nixgl.nixGLIntel
  ];
}
