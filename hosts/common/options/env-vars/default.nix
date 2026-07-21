{host_attr, ...}: {
  environment.variables =
    {
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
    }
    // host_attr.variables;
}
