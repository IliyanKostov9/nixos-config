{
  host_attr,
  pkgs,
  lib,
  ...
}: {
  services.displayManager = {
    gdm.enable = false;
    autoLogin = {
      enable = true;
      user = host_attr.autoLoginUser;
    };
    sddm = {
      wayland.enable = true;
      enable = true;
      theme = lib.mkDefault "catppuccin-macchiato";
      package = pkgs.kdePackages.sddm;
    };
  };
}
