{ host_attr, ... }:

{
  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = host_attr.auto-login-user;
  services.xserver.screenSection = ''
    Option "metamodes" "DP-2: 1920x1080_165 +0+0 {AllowGSYNCCompatible=On}"
  '';
}
