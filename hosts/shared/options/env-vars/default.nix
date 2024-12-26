{ host_name, pkgs, ... }:
{
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    DEVICE = host_name;
  };
}
