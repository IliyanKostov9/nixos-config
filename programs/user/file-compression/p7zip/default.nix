{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.file-compression.p7zip;
in
{
  options.modules.file-compression.p7zip = { enable = mkEnableOption "p7zip"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.p7zip
    ];
  };
}
