{pkgs, ...}: {
  security = {
    tpm2 = {
      enable = true;
      pkcs11.enable = true;
      tctiEnvironment.enable = true;
    };
    rtkit.enable = true;
    apparmor = {
      enable = true;
      enableCache = true;
      # policies.firejail = {
      # BUG: error while loading shared libraries: libdl.so.2: cannot open shared object file: No such file or directory
      # enable = true;
      # profile = ''
      #   include <tunables/global>
      #   profile firejail-default ${pkgs.firejail} {
      #   include <abstractions/base>
      #   }
      # '';
      # };
      packages = with pkgs; [
        apparmor-utils
        apparmor-profiles
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
