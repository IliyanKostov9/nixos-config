{host_attr, ...}: {
  environment.variables =
    {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      # NOTE: For wayland only
      # NIXOS_OZONE_WL = "1";
      # XDG_CURRENT_DESKTOP = "wlroots";
      # QT_QPA_PLATFORM = "wayland";

      WLR_NO_HARDWARE_CURSORS = 1;
      WLR_RENDERER_ALLOW_SOFTWARE = 1;
      WLR_BACKEND = "drm";
    }
    // host_attr.variables;
}
