{ host_attr, ... }:

{
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = host_attr.auto-login-user;
}
