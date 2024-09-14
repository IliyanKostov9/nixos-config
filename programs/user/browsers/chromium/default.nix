{  lib, config, ... }:
with lib;
let cfg = config.modules.chromium;
in
{
  options.modules.chromium = { enable = mkEnableOption "chromium"; };

  config = mkIf cfg.enable {
  programs.chromium.enable = true;
  nixpkgs.config.chromium = {
    enableWideVine = true;
  };
  };

}
