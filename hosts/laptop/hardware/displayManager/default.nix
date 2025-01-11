{ host_attr, ... }:

{
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = host_attr.auto-login-user;
}
