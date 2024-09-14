{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.file-listing;
in
{
  options.modules.file-listing = { enable = mkEnableOption "file-listing"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tree
      eza
    ];
  };

}

