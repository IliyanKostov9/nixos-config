{pkgs ? import <nixpkgs> {}}: let
  username = "ikostov2";

  jdk-overlay = self: super: {
    jdk =
      if builtins.pathExists "/home/${username}/.config/certs"
      then
        super.jdk8.override
        {
          cacert = self.runCommand "CC Maven" {} ''
            mkdir -p $out/etc/ssl/certs
            cat ${super.cacert}/etc/ssl/certs/ca-bundle.crt \
              ${/home/${username}/.config/certs/cc_root.cer} > $out/etc/ssl/certs/ca-bundle.crt
          '';
        }
      else super.jdk8;
  };

  customPkgs = import <nixpkgs> {
    overlays = [jdk-overlay];
  };
in
  pkgs.mkShell {
    name = "java8";
    buildInputs = with pkgs; [
      customPkgs.jdk
    ];

    runScript = "zsh";
    shellHook = "${pkgs.zsh}/bin/zsh";
  }
