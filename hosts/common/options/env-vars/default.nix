{host_attr, ...}: {
  environment.variables =
    {
      NIXOS_OZONE_HL = "1";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    }
    // host_attr.variables;
}
