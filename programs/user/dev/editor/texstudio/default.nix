{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.texstudio;
in
{
  options.modules.texstudio = { enable = mkEnableOption "texstudio"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.texstudio
    ];
  };

}
