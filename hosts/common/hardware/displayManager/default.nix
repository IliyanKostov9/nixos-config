{
  host_attr,
  pkgs,
  ...
}: let
in {
  services.displayManager = {
    gdm.enable = false;
    autoLogin = {
      enable = builtins.hasAttr "autoLoginUser" host_attr;
      user = host_attr.autoLoginUser;
    };
    sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
  };
}
