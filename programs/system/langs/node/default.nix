{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.node;
in
{
  options.modules.node = { enable = mkEnableOption "node"; };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.node_22
    ];
  };

}

