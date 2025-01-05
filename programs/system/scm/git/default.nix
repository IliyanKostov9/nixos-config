{ lib, config, ... }:
with lib;
let cfg = config.modules.scm.git;
in
{
  options.modules.scm.git = { enable = mkEnableOption "git"; };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      prompt.enable = true;
      lfs.enable = false;
    };
  };
}
