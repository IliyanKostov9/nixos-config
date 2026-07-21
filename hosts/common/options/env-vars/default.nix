{host_attr, ...}: {
  environment.variables =
    {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    }
    // host_attr.variables;
}
