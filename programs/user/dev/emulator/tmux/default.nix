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
      plugins = with pkgs.tmuxPlugins; [
        resurrect
        sensible
        yank
        open
      ];
      extraConfig = lib.fileContents ./tmux.conf;
      disableConfirmationPrompt = false;
      clock24 = true;
      baseIndex = 1;
      mouse = true;
    };
  };

}

