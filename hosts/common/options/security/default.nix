{pkgs, ...}: {
  security = {
    rtkit.enable = true;
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
    apparmor = {
      enable = true;
      enableCache = true;
      packages = with pkgs; [
        apparmor-utils
        apparmor-profiles
        roddhjav-apparmor-rules
      ];
    };
  };
  services = {
    # NOTE: For GNOME only
    gnome.gnome-keyring.enable = true;
    openssh = {
      enable = false;
      settings.PasswordAuthentication = false;
    };
  };
}
