{ nixpkgs, lib, pkgs, stateVersion, user, ... }:
let
  username = user;
in
{
  imports = [
    ./${username}
  ];
  home = {
    homeDirectory = "/home/${username}";
    inherit username stateVersion;
  };

  nixpkgs.overlays = [
    (self: super: {
      jdk =
        if builtins.pathExists "/home/${username}/.config/certs" then
          super.jdk8.override
            {
              cacert = self.runCommand "CC Maven" { } ''
                mkdir -p $out/etc/ssl/certs
                cat ${super.cacert}/etc/ssl/certs/ca-bundle.crt \
                  ${/home/${username}/.config/certs/cc_root.cer} > $out/etc/ssl/certs/ca-bundle.crt
              '';
            }
        else super.jdk8;
    })
  ];

  nixpkgs.config.allowUnfree = true;
  # Disable annoying home news
  news.display = "silent";
  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
