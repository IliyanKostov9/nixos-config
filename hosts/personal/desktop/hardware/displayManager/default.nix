{ host_attr, ... }:

{
  services = {
    displayManager.autoLogin = {
      enable = true;
      user = host_attr.auto-login-user;
    };
    xserver.screenSection = ''
      Option "metamodes" "DP-2: 1920x1080_165 +0+0 {AllowGSYNCCompatible=On}"
    '';
  };
}
