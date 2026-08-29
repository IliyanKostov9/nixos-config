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
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
    };
  };
}
