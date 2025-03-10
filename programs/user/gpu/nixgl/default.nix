{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.gpu.nixgl;
in {
  options.modules.gpu.nixgl = {enable = mkEnableOption "nixgl";};

  config = mkIf cfg.enable {
    home.packages = [
      # After that do `nixGLIntel obs or any other program`
      pkgs.nixgl.nixGLIntel
    ];
  };
}
# Use it in cases of these errors:
# libGL error: unable to load driver: i965_dri.so
# libGL error: driver pointer missing
# libGL error: failed to load driver: i965
# libGL error: unable to load driver: i965_dri.so
# libGL error: driver pointer missing
# libGL error: failed to load driver: i965
# libGL error: unable to load driver: swrast_dri.so
# libGL error: failed to load driver: swrast

