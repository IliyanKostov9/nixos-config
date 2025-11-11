{
  pkgs,
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.security.cryptography;
in {
  options.modules.security.cryptography = {enable = mkEnableOption "cryptography";};

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        openssl
        pass
        age
        pinentry-qt
        gnupg
        nvidia-container-toolkit
      ];
    };
  };
}
