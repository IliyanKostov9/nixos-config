{host_attr, ...}: {
  services = {
    displayManager.autoLogin = {
      enable = true;
      user = host_attr.auto-login-user;
    };
  };
}
