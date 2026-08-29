{
  host_attr,
  pkgs,
  ...
}: {
  services.displayManager = {
    gdm.enable = false;
    autoLogin = {
      enable = true;
      user = host_attr.autoLoginUser;
    };
    sddm = {
      enable = true;
      wayland.enable = false; # NOTE: Keep it false to make the mouse work
      package = pkgs.kdePackages.sddm;
    };
  };
}
