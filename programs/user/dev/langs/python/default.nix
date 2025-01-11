{ pkgs, pkgs-unstable, lib, config, ... }:
with lib;
let cfg = config.modules.dev.langs.python;
in
{
  options.modules.dev.langs.python = { enable = mkEnableOption "python"; };

  config = mkIf cfg.enable {

    home.packages = [
      pkgs.python3
      pkgs.pipx
      pkgs-unstable.uv
    ];
  };
}

