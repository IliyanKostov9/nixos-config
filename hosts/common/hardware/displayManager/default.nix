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
      wayland.enable = false; # NOTE: Keep it false to make the mouse work
      package = pkgs.kdePackages.sddm;
    };
  };
}
