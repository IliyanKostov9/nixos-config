{ pkgs, lib, config, ... }:
with lib;
let cfg = config.modules.tmux;
in
{
  options.modules.tmux = { enable = mkEnableOption "tmux"; };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.tmux
    ];

    programs.tmux = {
      enable = true;
      extraConfig = lib.fileContents ./tmux.conf;
    };
  };

}

