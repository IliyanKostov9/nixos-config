{ pkgs, pkgs_unstable, lib, config, ... }:
with lib;
let cfg = config.modules.python;
in
{
  options.modules.python = { enable = mkEnableOption "python"; };

  config = mkIf cfg.enable {

    home.packages = [
      pkgs.python3
      pkgs.pipx
      pkgs_unstable.uv
    ];
  };
}

