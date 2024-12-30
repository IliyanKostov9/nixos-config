{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.utils.zip;
in
{
  options.modules.utils.zip = { enable = mkEnableOption "zip"; };

  config = mkIf cfg.enable {
    # environment.systemPackages = with pkgs; [ unzip bzip2 xz zlib ];
  };
}
