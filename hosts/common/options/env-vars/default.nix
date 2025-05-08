{host_attr, ...}: {
  environment.variables =
    {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # NOTE: Wayland for chromium
      # NIXOS_OZONE_WL = "1";
    }
    // host_attr.variables;
}
