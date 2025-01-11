{ host_attr, ... }:
{
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  } // host_attr.variables;
}
