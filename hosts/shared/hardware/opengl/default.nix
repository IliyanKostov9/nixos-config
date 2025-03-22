{
  pkgs,
  lib,
  ...
}: {
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs;
      [
        libGL
        libvdpau-va-gl
      ]
      ++ (
        if builtins.match "Intel" (builtins.getEnv "CPU") != null
        then
          lib.trivial.trace "> Deceted CPU Intel. Installing neccesary drivers..." [
            intel-media-driver
            intel-compute-runtime
          ]
        else []
      );
    # NOTE: For AMD GPU
    # hardware.graphics.extraPackages = [pkgs.amdvlk];
    # hardware.graphics.extraPackages32 = [pkgs.driversi686Linux.amdvlk];
  };
}
