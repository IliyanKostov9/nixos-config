{host_attr, ...}: {
  environment.variables =
    {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # NOTE: For wayland only
      # NIXOS_OZONE_WL = "1";
      # XDG_CURRENT_DESKTOP = "wlroots";
      # QT_QPA_PLATFORM = "wayland";
    }
    // host_attr.variables;
}
