{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.utils.dir-content-ls;
in
{
  options.modules.utils.dir-content-ls = { enable = mkEnableOption "dir-content-ls"; };

  config = mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      tree
      fd
      tldr
    ];
  };
}

