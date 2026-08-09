{
  host_attr,
  pkgs,
  lib,
  ...
}: {
  services = {
    desktopManager.gnome.enable = true;
    displayManager = {
      autoLogin = {
        enable = true;
        user = host_attr.autoLoginUser;
      };
      gdm.enable = false;
      sddm = {
        wayland.enable = true;
        enable = true;
        theme = lib.mkDefault "catppuccin-macchiato";
        package = pkgs.kdePackages.sddm;
      };
    };
  };
}
