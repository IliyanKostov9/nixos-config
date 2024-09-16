{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.zip;
in
{
  options.modules.zip = { enable = mkEnableOption "zip"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [ unzip bzip2 xz zlib ];
  };

}

