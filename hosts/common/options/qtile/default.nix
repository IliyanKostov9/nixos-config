{pkgs, ...}: {
  services.xserver.windowManager.qtile = {
    enable = true;
    extraPackages = python3Packages:
      with pkgs.python3Packages; [
        qtile-extras
      ];
  };
}
