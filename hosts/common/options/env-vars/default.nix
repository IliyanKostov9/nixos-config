{host_attr, ...}: {
  environment.variables =
    {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      ELECTRON_ENABLE_XSHAPE = 1;
    }
    // host_attr.variables;
}
